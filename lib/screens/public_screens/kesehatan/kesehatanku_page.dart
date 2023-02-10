import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page_1.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_minta_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatanku_page.dart';

class KesehatankuPage extends StatefulWidget {
  static const String id = 'KesehatankuPage';
  const KesehatankuPage({Key? key}) : super(key: key);

  @override
  State<KesehatankuPage> createState() => _KesehatankuPageState();
}

class _KesehatankuPageState extends State<KesehatankuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kesehatanku'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: paddingCard,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: smartRTPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: smartRTShadowColor,
                        spreadRadius: 5,
                        blurRadius: 25),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Kesehatanku Sekarang',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                    Text(
                      'Sehat',
                      style: smartRTTextTitle_Success,
                    ),
                  ],
                ),
              ),
              SB_height15,
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RiwayatKesehatankuPage.id);
                },
                child: Container(
                  width: double.infinity,
                  padding: paddingCard,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: smartRTPrimaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: smartRTShadowColor,
                          spreadRadius: 5,
                          blurRadius: 25),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riwayat Kesehatanku',
                        style: smartRTTextNormal_Secondary,
                      ),
                      Icon(
                        Icons.list,
                        color: smartRTSecondaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SB_height15,
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RiwayatBantuanPage.id);
                },
                child: Container(
                  width: double.infinity,
                  padding: paddingCard,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: smartRTPrimaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: smartRTShadowColor,
                          spreadRadius: 5,
                          blurRadius: 25),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Riwayat Bantuan',
                        style: smartRTTextNormal_Secondary,
                      ),
                      Icon(
                        Icons.list,
                        color: smartRTSecondaryColor,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SB_height30,
              Text(
                'Anda Kurang Sehat ?',
                style: smartRTTextTitle_Primary,
              ),
              Text(
                'Laporkan kesehatan anda segera agar dapat mengakses fitur sesuai dengan kondisi kesehatan anda sekarang.',
                style: smartRTTextNormal_Primary,
                textAlign: TextAlign.justify,
              ),
              SB_height30,
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FormLaporKesehatanPage1.id);
                  },
                  child: Text(
                    'LAPOR KESEHATAN',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
              SB_height30,
              Text(
                'Butuh Bantuan ?',
                style: smartRTTextTitle_Primary,
              ),
              Text(
                'Anda dapat meminta bantuan untuk memenuhi keperluan anda ketika kondisi kesehatan anda kurang baik. Hal tersebut bertujuan agar kepulihan kesehatan anda dapat lebih maksimal serta meminimkan penularan jika mempunyai penyakit menular.',
                style: smartRTTextNormal_Primary,
                textAlign: TextAlign.justify,
              ),
              SB_height30,
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, FormMintaBantuanPage.id);
                  },
                  child: Text(
                    'MINTA BANTUAN',
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
