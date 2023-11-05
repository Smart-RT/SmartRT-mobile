import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/screens/pdf_screen/pdf_screen.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:http_parser/http_parser.dart';

class BuatJanjiTemuPage extends StatefulWidget {
  static const String id = 'BuatJanjiTemuPage';
  const BuatJanjiTemuPage({Key? key}) : super(key: key);

  @override
  State<BuatJanjiTemuPage> createState() => _BuatJanjiTemuPageState();
}

class _BuatJanjiTemuPageState extends State<BuatJanjiTemuPage> {
  FilePickerResult? _fileLampiran;
  PlatformFile? _file;
  final _TECTitlte = TextEditingController();
  final _TECDetail = TextEditingController();
  final _TECDateTime = TextEditingController();
  String areaSelectedItem = '';
  final List<Area> listArea = [];
  String txtMsg = '';
  List<DropdownMenuItem> areaItems = [
    const DropdownMenuItem(
      child: Text(''),
      value: '',
    ),
  ];

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<Area> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id.toString(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                  'Kec. ${item.data_kecamatan!.name}, Kel. ${item.data_kelurahan!.name.substring(10)}\nRW ${StringFormat.numFormatRTRW(item.rw_num.toString())}, RT ${StringFormat.numFormatRTRW(item.rt_num.toString())}',
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

  void getAreaItems() async {
    Response<dynamic> resp = await NetUtil().dioClient.get('/meet/get/areas');
    listArea.clear();
    listArea.addAll((resp.data).map<Area>((request) {
      return Area.fromData(request);
    }));
    areaItems.clear();
    areaItems = _addDividersAfterItems(listArea);
    areaSelectedItem = areaItems[0].value;
    if (listArea.isEmpty) {
      txtMsg =
          'Maaf! Anda tidak dapat membuat Janji Temu dikarenakan tidak ada Wilayah lain selain wilayah anda!';
    }
    setState(() {});
  }

  bool isDataValid() {
    if (areaSelectedItem == '' ||
        _TECDateTime.text == '' ||
        _TECTitlte.text == '' ||
        _TECDetail.text == '' ||
        _fileLampiran == null) {
      return false;
    } else {
      return true;
    }
  }

  void buatPermohonan() async {
    if (isDataValid()) {
      try {
        MultipartFile multipartFileLampiran = await MultipartFile.fromFile(
            _fileLampiran!.files.first.path!,
            filename: _fileLampiran!.files.first.path!.split('/').last,
            contentType: MediaType('application', 'pdf'));

        var formData = FormData.fromMap({
          "file_lampiran": multipartFileLampiran,
          "title": _TECTitlte.text,
          "detail": _TECDetail.text,
          "area_id": areaSelectedItem,
          "meet_datetime": _TECDateTime.text,
        });

        Response<dynamic> resp =
            await NetUtil().dioClient.post('/meet/add', data: formData);
        if (resp.statusCode.toString() == '200') {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushNamed(context, ListJanjiTemuPage.id);
        }
        SmartRTSnackbar.show(context,
            message: resp.data, backgroundColor: smartRTSuccessColor);
      } catch (e) {
        SmartRTSnackbar.show(context,
            message: 'Gagal membuat permohonan!',
            backgroundColor: smartRTErrorColor);
      }
    } else {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data telah terisi!',
          backgroundColor: smartRTErrorColor);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getAreaItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buat Janji Temu'),
      ),
      body: listArea.isEmpty
          ? Padding(
              padding: paddingScreen,
              child: Center(
                child: Text(
                  txtMsg,
                  style: smartRTTextLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: paddingScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'TEMPAT DAN TANGGAL',
                      style: smartRTTextTitle,
                      textAlign: TextAlign.left,
                    ),
                    SB_height15,
                    Text(
                      'Area RT',
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SB_height5,
                    DropdownButtonFormField2(
                      dropdownMaxHeight: 200,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      value: areaItems[0].value,
                      style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold),
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
                      items: areaItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item.value,
                                child: item.child,
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          areaSelectedItem = value.toString();
                          debugPrint(areaSelectedItem);
                        });
                      },
                      onSaved: (value) {
                        areaSelectedItem = value.toString();
                      },
                    ),
                    SB_height15,
                    DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      locale: const Locale('id', 'ID'),
                      dateMask: 'dd MMMM yyyy HH:mm',
                      style: smartRTTextNormal_Primary,
                      firstDate: DateTime.now().add(const Duration(days: 3)),
                      lastDate: DateTime.now().add(const Duration(days: 90)),
                      initialDate: DateTime.now().add(const Duration(days: 3)),
                      dateLabelText: 'Tanggal Janjian',
                      onChanged: (val) => print(val),
                      onSaved: (val) => print(val),
                      controller: _TECDateTime,
                    ),
                    Divider(
                      color: smartRTPrimaryColor,
                      height: 50,
                      thickness: 1,
                    ),
                    Text(
                      'KEPERLUAN',
                      style: smartRTTextTitle,
                      textAlign: TextAlign.left,
                    ),
                    SB_height15,
                    TextFormField(
                      controller: _TECTitlte,
                      autocorrect: false,
                      style: smartRTTextLarge,
                      decoration: const InputDecoration(
                        labelText: 'Judul',
                      ),
                    ),
                    SB_height15,
                    TextFormField(
                      controller: _TECDetail,
                      maxLines: 10,
                      autocorrect: false,
                      style: smartRTTextLarge,
                      decoration: const InputDecoration(
                        labelText: 'Detail',
                      ),
                    ),
                    Divider(
                      color: smartRTPrimaryColor,
                      height: 50,
                      thickness: 1,
                    ),
                    Text(
                      'LAMPIRAN',
                      style: smartRTTextTitle,
                      textAlign: TextAlign.left,
                    ),
                    SB_height15,
                    _fileLampiran == null
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                _fileLampiran = await FilePicker.platform
                                    .pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['pdf']);

                                if (_fileLampiran != null) {
                                  File file = File(_fileLampiran!
                                      .files.single.path
                                      .toString());
                                  _file = _fileLampiran!.files.first;
                                  setState(() {});
                                } else {
                                  // User canceled the picker
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_file,
                                    color: smartRTSecondaryColor,
                                    size: 20,
                                  ),
                                  SB_width15,
                                  Text(
                                    'Upload File',
                                    style: smartRTTextNormalBold_Secondary,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.all(0),
                                child: ListTile(
                                  tileColor: smartRTPrimaryColor,
                                  textColor: smartRTSecondaryColor,
                                  leading: Image.asset(
                                      'assets/img/icons/file/pdf.png'),
                                  title: Text(
                                    _file!.name,
                                    style: smartRTTextNormalBold_Secondary,
                                  ),
                                  subtitle: Text(
                                    _file!.path.toString(),
                                    style: smartRTTextNormal_Secondary,
                                  ),
                                  trailing: GestureDetector(
                                      child: Icon(
                                        Icons.close,
                                        color: smartRTSecondaryColor,
                                        size: 15,
                                      ),
                                      onTap: () async {
                                        _fileLampiran = null;
                                        _file = null;
                                        setState(() {});
                                      }),
                                ),
                              ),
                              SB_height15,
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PDFScreen(
                                            path: _file!.path.toString()),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Lihat',
                                    style: smartRTTextNormalBold_Secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: listArea.isEmpty
          ? const SizedBox()
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ))),
                onPressed: () {
                  buatPermohonan();
                },
                child: Text(
                  'BUAT PERMOHONAN',
                  style: smartRTTextLargeBold_Secondary,
                ),
              ),
            ),
    );
  }
}
