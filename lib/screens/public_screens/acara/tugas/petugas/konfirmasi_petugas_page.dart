import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/event/event_task_detail.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_1.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';

class KonfirmasiPetugasPageArgument {
  List<EventTaskDetail> dataReq;
  String title;
  KonfirmasiPetugasPageArgument({
    required this.dataReq,
    required this.title,
  });
}

class KonfirmasiPetugasPage extends StatefulWidget {
  static const String id = 'KonfirmasiPetugasPage';
  KonfirmasiPetugasPageArgument args;
  KonfirmasiPetugasPage({Key? key, required this.args}) : super(key: key);

  @override
  State<KonfirmasiPetugasPage> createState() => _KonfirmasiPetugasPageState();
}

class _KonfirmasiPetugasPageState extends State<KonfirmasiPetugasPage> {
  User user = AuthProvider.currentUser!;
  List<EventTaskDetail> dataReq = [];
  String title = '';

  void konfirmasi({required EventTaskDetail data}) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda ingin menerima ${data.dataUser!.full_name} (${data.dataUser!.address ?? '-'}) menjadi bertugas di $title',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  await context.read<EventProvider>().confirmationTaskDetail(
                      idTaskDetail: data.id, status: -1);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  SmartRTSnackbar.show(context,
                      message: 'Berhasil menolak petugas !',
                      backgroundColor: smartRTSuccessColor);
                },
                child: Text(
                  'Tidak',
                  style:
                      smartRTTextNormal.copyWith(color: smartRTStatusRedColor),
                ),
              ),
              TextButton(
                onPressed: () async {
                  await context
                      .read<EventProvider>()
                      .confirmationTaskDetail(idTaskDetail: data.id, status: 1);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  SmartRTSnackbar.show(context,
                      message: 'Berhasil menerima petugas !',
                      backgroundColor: smartRTSuccessColor);
                },
                child: Text(
                  'IYA',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // List<int> listID = [];
    // for (var i = 0; i < listUserWilayah!.length; i++) {
    //   if (isChecked[i]) {
    //     listID.add(listUserWilayah![i].id);
    //   }
    // }

    // await context
    //     .read<EventProvider>()
    //     .giveTask(idTask: widget.args.taskID, listUserID: listID);
    // Navigator.pop(context);
    // SmartRTSnackbar.show(context,
    //     message: 'Berhasil memberikan tugas ke warga !',
    //     backgroundColor: smartRTSuccessColor);
  }

  void getData() async {
    dataReq = widget.args.dataReq;
    title = widget.args.title;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding: paddingScreen,
            child: const ExplainPart(
                title: 'LIST PERMOHONAN AMBIL TUGAS',
                notes:
                    'Anda dapat mengkonfirmasi dengan menekan salah satu dari list sehingga muncul pop-up konfirmasi!'),
          ),
          Divider(
            color: smartRTPrimaryColor,
            height: 2,
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, int) {
                return Divider(
                  color: smartRTPrimaryColor,
                  height: 5,
                );
              },
              itemCount: dataReq.length,
              itemBuilder: (context, index) {
                return ListTileUser1(
                  fullName: dataReq[index].dataUser!.full_name,
                  address: dataReq[index].dataUser!.address.toString(),
                  photoPathURL:
                      '${backendURL}/public/uploads/users/${dataReq[index].dataUser!.id}/profile_picture/',
                  photo: dataReq[index].dataUser!.photo_profile_img.toString(),
                  initialName: StringFormat.initialName(
                      dataReq[index].dataUser!.full_name),
                  onTap: () {
                    konfirmasi(data: dataReq[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
