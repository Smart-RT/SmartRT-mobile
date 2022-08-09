import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class DaftarKetuaFormPage3 extends StatefulWidget {
  static const String id = 'DaftarKetuaFormPage3';
  const DaftarKetuaFormPage3({Key? key}) : super(key: key);

  @override
  State<DaftarKetuaFormPage3> createState() => _DaftarKetuaFormPage3State();
}

class _DaftarKetuaFormPage3State extends State<DaftarKetuaFormPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Ketua RT ( 3 / 3 )'),
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
                  'Lampiran',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Unggahlah surat keputusan anda telah terpilih menjadi Ketua RT di wilayah atau surat keterangan menjabat sebagai Ketua RT yang didapatkan dari Ketua RW anda.',
                  style: smartRTTextNormal_Primary,
                  textAlign: TextAlign.justify,
                ),
                SB_height30,
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
                onPressed: () {/** ... */},
                child: Text(
                  'DAFTAR',
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