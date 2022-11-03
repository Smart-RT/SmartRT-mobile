import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_3.dart';

class DaftarKetuaFormPage2Arguments {
  String namaLengkap;
  String alamat;
  String kecamatan;
  String kelurahan;
  String noRT;
  String noRW;

  DaftarKetuaFormPage2Arguments(
      {required this.namaLengkap,
      required this.alamat,
      required this.kecamatan,
      required this.kelurahan,
      required this.noRT,
      required this.noRW});
}

class DaftarKetuaFormPage2 extends StatefulWidget {
  static const String id = 'DaftarKetuaFormPage2';
  DaftarKetuaFormPage2Arguments args;
  DaftarKetuaFormPage2({Key? key, required this.args}) : super(key: key);

  @override
  State<DaftarKetuaFormPage2> createState() => _DaftarKetuaFormPage2State();
}

class _DaftarKetuaFormPage2State extends State<DaftarKetuaFormPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Ketua RT ( 2 / 3 )'),
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
                  'Identitas',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Unggahlah foto KTP berserta foto selfie dengan KTP anda untuk membantu dalam proses konfirmasi. Data anda akan terjaga ke-privasiannya dan tidak akan disalah gunakan.',
                  style: smartRTTextNormal_Primary,
                  textAlign: TextAlign.justify,
                ),
                SB_height30,
                Text('Foto KTP', style: smartRTTextTitleCard_Primary,),
                SB_height15,
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: smartRTShadowColor,
                  ),
                ),
                SB_height30,
                Text('Foto Selfie dengan KTP', style: smartRTTextTitleCard_Primary,),
                SB_height15,
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: smartRTShadowColor,
                  ),
                ),
                
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DaftarKetuaFormPage3.id);
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