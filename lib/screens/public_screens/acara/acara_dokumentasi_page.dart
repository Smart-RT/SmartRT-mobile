import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/screens/public_screens/acara/form_acara/form_acara_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/form_tugas/form_tugas_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/tugas_page_detail.dart';
import 'package:smart_rt/screens/public_screens/image_view/image_view_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:http_parser/http_parser.dart';

class AcaraDokumentasiPageArgument {
  int dataEventIdx;
  AcaraDokumentasiPageArgument({required this.dataEventIdx});
}

class AcaraDokumentasiPage extends StatefulWidget {
  static const String id = 'AcaraDokumentasiPage';
  AcaraDokumentasiPageArgument args;
  AcaraDokumentasiPage({Key? key, required this.args}) : super(key: key);

  @override
  State<AcaraDokumentasiPage> createState() => _AcaraDokumentasiPageState();
}

class _AcaraDokumentasiPageState extends State<AcaraDokumentasiPage> {
  User user = AuthProvider.currentUser!;
  final ImagePicker _picker = ImagePicker();

  void _pickImage({required int event_id}) async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      List<MultipartFile> photosData =
          await Future.wait(images.map((photo) async {
        var byteData = await photo.readAsBytes();
        // var byteData = await photo.getByteData();
        return MultipartFile.fromBytes(
            byteData.buffer
                .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
            filename: '${photo.name}',
            contentType: MediaType('image', '${photo.name.split('.').last}'));
      }));
      var formData = FormData.fromMap({
        "photos": photosData,
        "event_id": event_id,
        "area_id": user.area_id
      });
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .post('/event/add/photo-documentation', data: formData);
      if (resp.statusCode == 200) {
        SmartRTSnackbar.show(context,
            message: resp.data.toString(),
            backgroundColor: smartRTSuccessColor);
        await getData();
      }
      setState(() {});
    }
  }

  List<String> listPhoto = <String>[];

  Future<void> getData() async {
    int dataEventIdx = widget.args.dataEventIdx;
    Event dataEvent = context.read<EventProvider>().dataListEvent[dataEventIdx];
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/event/get/photo-documentation/${dataEvent.id}');

    setState(() {
      listPhoto.clear();
      listPhoto.addAll(resp.data.map<String>((request) {
        return request['name'].toString();
      }));
      print(listPhoto);
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Event dataEvent =
        context.watch<EventProvider>().dataListEvent[widget.args.dataEventIdx];
    return Scaffold(
      appBar: AppBar(
        title: Text('Dokumentasi Acara'),
        actions: [],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          ...listPhoto.map((e) => GestureDetector(
                onTap: () {
                  ImageViewPageArgument args = ImageViewPageArgument(
                      imgLocation:
                          '${backendURL}/public/uploads/events/${dataEvent.id}/$e');
                  Navigator.pushNamed(context, ImageViewPage.id,
                      arguments: args);
                },
                child: Image.network(
                  '${backendURL}/public/uploads/events/${dataEvent.id}/$e',
                  fit: BoxFit.fitWidth,
                ),
              ))
        ],
      ),
      floatingActionButton: Padding(
        padding: paddingScreen,
        child: SizedBox(
            height: 75,
            width: 75,
            child: ElevatedButton(
              onPressed: () async {
                _pickImage(event_id: dataEvent.id);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              )),
              child: const Icon(Icons.add),
            )),
      ),
    );
  }
}
