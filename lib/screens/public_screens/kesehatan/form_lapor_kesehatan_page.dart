import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/disease_group.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/health_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_1.dart';
import 'package:provider/provider.dart';

class FormLaporKesehatanPageArguments {
  String type;
  User dataUserTerlaporkan;
  FormLaporKesehatanPageArguments(
      {required this.type, required this.dataUserTerlaporkan});
}

class FormLaporKesehatanPage extends StatefulWidget {
  static const String id = 'FormLaporKesehatanPage';
  FormLaporKesehatanPageArguments args;
  FormLaporKesehatanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<FormLaporKesehatanPage> createState() => _FormLaporKesehatanPageState();
}

class _FormLaporKesehatanPageState extends State<FormLaporKesehatanPage> {
  final _detailPenyakitController = TextEditingController();
  User user = AuthProvider.currentUser!;
  String type = '';
  String exampleNotesDiseaseGroup = '';
  String _tingkatBahayaSelectedItem = '';
  String _diseaseGroupSelectedItem = '';
  User? dataUserTerlaporkan;
  List<DiseaseGroup> listDiseaseGroup = [];

  List<DropdownMenuItem> _diseaseGroupItems = [
    DropdownMenuItem(
      child: Text(''),
      value: '',
    ),
  ];

  final List<DropdownMenuItem> _tingkatBahayaItems = const [
    DropdownMenuItem(
      value: '1',
      child: Text('Ringan'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Sedang'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('Berat'),
    ),
  ];

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<DiseaseGroup> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id.toString(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(item.name,
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                height: 0,
                color: smartRTTertiaryColor,
              ),
            ),
        ],
      );
    }
    return _menuItems;
  }

  void getData() async {
    type = (widget.args.type).toUpperCase();
    _tingkatBahayaSelectedItem = _tingkatBahayaItems[0].value;
    dataUserTerlaporkan = widget.args.dataUserTerlaporkan;

    Response<dynamic> resp =
        await NetUtil().dioClient.get('/health/diseaseGroup');
    listDiseaseGroup.clear();
    listDiseaseGroup.addAll((resp.data).map<DiseaseGroup>((request) {
      return DiseaseGroup.fromData(request);
    }));

    _diseaseGroupItems.clear();
    _diseaseGroupItems = _addDividersAfterItems(listDiseaseGroup);
    _diseaseGroupSelectedItem = _diseaseGroupItems[0].value;
    exampleNotesDiseaseGroup =
        listDiseaseGroup[int.parse(_diseaseGroupSelectedItem) - 1]
                .example_notes ??
            '';

    setState(() {});
  }

  void createUserHealthReport() async {
    if (_detailPenyakitController.text == '') {
      SmartRTSnackbar.show(context,
          message: 'Gagal! Pastikan semua terisi!',
          backgroundColor: smartRTErrorColor);
    } else {
      int area_reported_id = user.area!.id;
      int reported_id_for = dataUserTerlaporkan!.id;

      bool isSukses = await context.read<HealthProvider>().melaporkanKesehatan(
          context: context,
          reported_id_for: reported_id_for,
          area_reported_id: area_reported_id,
          disease_group_id: int.parse(_diseaseGroupSelectedItem),
          disease_level: int.parse(_tingkatBahayaSelectedItem),
          disease_notes: _detailPenyakitController.text,
          type: type);

      if (!isSukses) {
        // ignore: use_build_context_synchronously
        SmartRTSnackbar.show(context,
            message: 'Gagal Melaporkan! Cobalah lagi!',
            backgroundColor: smartRTErrorColor);
      } else {
        if (type == "ORANG LAIN") {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, KesehatankuPage.id);
        // ignore: use_build_context_synchronously
        SmartRTSnackbar.show(context,
            message: 'Berhasil membuat laporan!',
            backgroundColor: smartRTSuccessColor);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'FORM LAPORAN KESEHATAN',
                style: smartRTTextTitleCard.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                'UNTUK ${type.toUpperCase()}',
                style: smartRTTextLarge,
                textAlign: TextAlign.center,
              ),
              type.toUpperCase() == 'ORANG LAIN'
                  ? Column(
                      children: [
                        SB_height30,
                        Divider(
                          color: smartRTPrimaryColor,
                          thickness: 1,
                          height: 10,
                        ),
                        ListTileUser1(
                            fullName: dataUserTerlaporkan!.full_name,
                            address: dataUserTerlaporkan!.address.toString(),
                            initialName: StringFormat.initialName(
                                dataUserTerlaporkan!.full_name)),
                        Divider(
                          color: smartRTPrimaryColor,
                          thickness: 1,
                          height: 10,
                        ),
                        SB_height30
                      ],
                    )
                  : Divider(
                      color: smartRTPrimaryColor,
                      thickness: 1,
                      height: 50,
                    ),
              Text(
                'Tingkat Bahaya',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SB_height5,
              DropdownButtonFormField2(
                dropdownMaxHeight: 200,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                value: _tingkatBahayaItems[0].value,
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: smartRTPrimaryColor,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: _tingkatBahayaItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item.value,
                          child: item.child,
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Tidak boleh kosong';
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _tingkatBahayaSelectedItem = value.toString();
                    debugPrint(_tingkatBahayaSelectedItem);
                  });
                },
                onSaved: (value) {
                  _tingkatBahayaSelectedItem = value.toString();
                },
              ),
              SB_height15,
              Text(
                'Tipe Penyakit',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SB_height5,
              DropdownButtonFormField2(
                dropdownMaxHeight: 200,
                value: _diseaseGroupItems[0].value,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: smartRTPrimaryColor,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: _diseaseGroupItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item.value,
                          child: item.child,
                          enabled: item.enabled,
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Tidak boleh kosong';
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _diseaseGroupSelectedItem = value.toString();
                    exampleNotesDiseaseGroup = listDiseaseGroup[
                                int.parse(_diseaseGroupSelectedItem) - 1]
                            .example_notes ??
                        '';
                  });
                },
                onSaved: (value) {
                  _diseaseGroupSelectedItem = value.toString();
                },
              ),
              SB_height15,
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  exampleNotesDiseaseGroup == ''
                      ? ''
                      : 'Contoh Penyakit : \n${exampleNotesDiseaseGroup}',
                  style:
                      smartRTTextNormal.copyWith(color: smartRTTertiaryColor),
                ),
              ),
              SB_height15,
              TextFormField(
                controller: _detailPenyakitController,
                maxLines: 5,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: InputDecoration(
                  labelText: 'Detail Penyakit',
                  hintText:
                      'Tulislah gejala atau penyakit yang sedang dialami disini...\n\nContoh:\nFlu, Batuk, Pilek, Demam',
                  hintStyle: smartRTTextNormal.copyWith(
                    color: smartRTTertiaryColor,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tidak boleh kosong';
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ))),
          onPressed: () {
            createUserHealthReport();
          },
          child: Text(
            'SELESAI DAN LAPOR',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
