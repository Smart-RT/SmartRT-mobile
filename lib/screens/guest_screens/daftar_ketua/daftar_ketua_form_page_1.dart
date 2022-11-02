import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/sub_districts.dart';
import 'package:smart_rt/models/urban_villages.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_2.dart';
import 'package:smart_rt/utilities/net_util.dart';

class DaftarKetuaFormPage1 extends StatefulWidget {
  static const String id = 'DaftarKetuaFormPage1';
  const DaftarKetuaFormPage1({Key? key}) : super(key: key);

  @override
  State<DaftarKetuaFormPage1> createState() => _DaftarKetuaFormPage1State();
}

class _DaftarKetuaFormPage1State extends State<DaftarKetuaFormPage1> {
  String _kecamatanSelectedValue = '';
  String _kelurahanSelectedValue = '';

  final List<SubDistricts> _listKecamatan = [];
  final List<UrbanVillages> _listKelurahan = [];

  final TextEditingController textEditingControllerKecamatan =
      TextEditingController();
  final TextEditingController textEditingControllerKelurahan =
      TextEditingController();

  Future<void> loadKecamatan() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get("/addresses/subDistricts");

    setState(() {
      _listKecamatan.addAll(resp.data.map<SubDistricts>((request) {
        return SubDistricts.fromData(request);
      }));
    });
    print(_listKecamatan);
  }

  Future<void> loadKelurahan() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get("/addresses/urbanVillages");

    setState(() {
      _listKelurahan.addAll(resp.data.map<UrbanVillages>((request) {
        return UrbanVillages.fromData(request);
      }));
    });
    print(_listKelurahan);
  }

  @override
  void initState() {
    super.initState();
    loadKecamatan();
    loadKelurahan();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Ketua RT ( 1 / 3 )'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tentang Saya\ndan Wilayah Saya',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Pastikan data anda sesuai dengan data yang valid dan sesuai dengan KTP.',
                  style: smartRTTextNormal_Primary,
                  textAlign: TextAlign.justify,
                ),
                SB_height30,
                TextFormField(
                  autocorrect: false,
                  initialValue: AuthProvider.currentUser!.full_name,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                  },
                ),
                SB_height30,
                Text(
                  'Catatan : Wilayah RT anda akan dibuat berdasarkan Kecamatan, Kelurahan, no RT, dan no RW sesuai yang anda cantumkan. Jika telah di konfirmasi oleh pihak pengelola aplikasi, maka otomatis alamat Ketua RT pada wilayah tersebut akan diarahkan pada alamat anda.',
                  style: smartRTTextNormal_Primary,
                  textAlign: TextAlign.justify,
                ),
                SB_height30,
                TextFormField(
                  autocorrect: false,
                  initialValue: AuthProvider.currentUser!.address,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'Alamat Rumah',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat tidak boleh kosong';
                    }
                  },
                ),
                SB_height15,
                DropdownButtonFormField2(
                  style: smartRTTextLargeBold_Primary,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  dropdownMaxHeight: 200,
                  searchController: textEditingControllerKecamatan,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: textEditingControllerKecamatan,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: smartRTTextLargeBold_Primary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    debugPrint(item.toString());
                    List<String> ids = _listKecamatan
                        .where(
                          (element) => element.name
                              .toUpperCase()
                              .contains(searchValue.toUpperCase()),
                        )
                        .map(
                          (e) => e.id.toString(),
                        )
                        .toList();
                    return ids.contains(item.value.toString());
                  },
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingControllerKecamatan.clear();
                    }
                  },
                  isExpanded: true,
                  hint: Text(
                    'Kecamatan',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: smartRTPrimaryColor,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 25, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: _listKecamatan
                      .map((item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(
                              item.name,
                              style: smartRTTextNormal_Primary,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Kecamatan tidak boleh kosong';
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      _kecamatanSelectedValue = value.toString();
                    });
                  },
                  onSaved: (value) {
                    _kecamatanSelectedValue = value.toString();
                  },
                ),
                SB_height15,
                DropdownButtonFormField2(
                  style: smartRTTextLargeBold_Primary,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  dropdownMaxHeight: 200,
                  searchController: textEditingControllerKelurahan,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: textEditingControllerKelurahan,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: smartRTTextLargeBold_Primary,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    debugPrint(item.toString());
                    List<String> ids = _listKelurahan
                        .where(
                          (element) => element.name
                              .toUpperCase()
                              .contains(searchValue.toUpperCase()),
                        )
                        .map(
                          (e) => e.id.toString(),
                        )
                        .toList();
                    return ids.contains(item.value.toString());
                  },
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingControllerKelurahan.clear();
                    }
                  },
                  isExpanded: true,
                  hint: Text(
                    'Kelurahan',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  disabledHint: Text(
                    'Kelurahan',
                    style: smartRTTextLargeBold_Primary.copyWith(
                        color: smartRTDisabledColor),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  iconDisabledColor: smartRTDisabledColor,
                  iconEnabledColor: smartRTPrimaryColor,
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 25, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: _listKelurahan
                      .map((item) => DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(
                              item.name,
                              style: smartRTTextNormal_Primary,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Kelurahan tidak boleh kosong';
                    }
                  },
                  onChanged: _kecamatanSelectedValue.isNotEmpty
                      ? (value) {
                          setState(() {
                            _kelurahanSelectedValue = value.toString();
                          });
                        }
                      : null,
                  onSaved: (value) {
                    _kelurahanSelectedValue = value.toString();
                  },
                ),
                SB_height15,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        autocorrect: false,
                        initialValue: '[Nomor RT]',
                        style: smartRTTextNormal_Primary,
                        decoration: const InputDecoration(
                          labelText: 'Nomor RT',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor RT tidak boleh kosong';
                          }
                        },
                      ),
                    ),
                    SB_width25,
                    Expanded(
                      child: TextFormField(
                        autocorrect: false,
                        initialValue: '[Nomor RW]',
                        style: smartRTTextNormal_Primary,
                        decoration: const InputDecoration(
                          labelText: 'Nomor RW',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor RW tidak boleh kosong';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SB_height15,
                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: Container(
                //     color: smartRTShadowColor,
                //   ),
                // ),
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DaftarKetuaFormPage2.id);
                },
                child: Text(
                  'SELANJUTNYA',
                  style: smartRTTextLargeBold_Secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
