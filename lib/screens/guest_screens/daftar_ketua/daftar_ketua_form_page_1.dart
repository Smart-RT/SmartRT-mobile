import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_2.dart';

class DaftarKetuaFormPage1 extends StatefulWidget {
  static const String id = 'DaftarKetuaFormPage1';
  const DaftarKetuaFormPage1({Key? key}) : super(key: key);

  @override
  State<DaftarKetuaFormPage1> createState() => _DaftarKetuaFormPage1State();
}

class _DaftarKetuaFormPage1State extends State<DaftarKetuaFormPage1> {
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
                  initialValue: '[Nama Lengkap]',
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
                  initialValue: '[Alamat Rumah]',
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
                TextFormField(
                  autocorrect: false,
                  initialValue: '[Kecamatan]',
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'Kecamatan',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kecamatan tidak boleh kosong';
                    }
                  },
                ),
                SB_height15,
                TextFormField(
                  autocorrect: false,
                  initialValue: '[Kelurahan]',
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'Kelurahan',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kelurahan tidak boleh kosong';
                    }
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
