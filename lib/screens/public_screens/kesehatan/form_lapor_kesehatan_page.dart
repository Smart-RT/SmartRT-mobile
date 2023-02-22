import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/health_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user.dart';
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
  String type = '';
  String _tingkatBahayaSelectedItem = '';
  User? dataUserTerlaporkan;
  final List<String> _tingkatBahayaItems = ['Ringan', 'Sedang', 'Berat'];
  User user = AuthProvider.currentUser!;

  void getData() async {
    type = (widget.args.type).toUpperCase();
    _tingkatBahayaSelectedItem = _tingkatBahayaItems[0];
    dataUserTerlaporkan = widget.args.dataUserTerlaporkan;
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
          disease_level: _tingkatBahayaSelectedItem == "Ringan"
              ? 0
              : _tingkatBahayaSelectedItem == "Sedang"
                  ? 1
                  : 2,
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
      body: Container(
        padding: paddingScreen,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 215,
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
                              const Divider(
                                thickness: 5,
                                height: 50,
                              ),
                              ListTileUser(
                                  fullName: dataUserTerlaporkan!.full_name,
                                  address:
                                      dataUserTerlaporkan!.address.toString(),
                                  initialName: StringFormat.initialName(
                                      dataUserTerlaporkan!.full_name)),
                              const Divider(
                                thickness: 5,
                                height: 50,
                              ),
                            ],
                          )
                        : const Divider(
                            thickness: 5,
                            height: 50,
                          ),
                    Text(
                      'Tingkat Bahaya',
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    SB_height5,
                    DropdownButtonFormField2(
                      value: _tingkatBahayaItems[0],
                      style: smartRTTextLarge.copyWith(
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
                      items: _tingkatBahayaItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: smartRTTextNormal_Primary,
                                ),
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
                        });
                      },
                      onSaved: (value) {
                        _tingkatBahayaSelectedItem = value.toString();
                      },
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
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    createUserHealthReport();
                  },
                  child: Text(
                    'SELESAI DAN LAPOR',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
