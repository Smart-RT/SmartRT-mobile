import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class GabungWilayah extends StatefulWidget {
  static const String id = 'GabungWilayah';
  const GabungWilayah({Key? key}) : super(key: key);

  @override
  State<GabungWilayah> createState() => _GabungWilayahState();
}

class _GabungWilayahState extends State<GabungWilayah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
                    'Gabung Wilayah',
                    style: smartRTTextTitle_Primary,
                  ),
                  Text(
                    'Masukkan kode wilayah anda yang didapatkan dari Ketua RT wilayah anda agar dapat bergabung dengan wilayah anda dan menikmati fitur-fitur yang telah disediakan',
                    style: smartRTTextNormal_Primary,
                  ),
                  SB_height15,
                  TextFormField(
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                    },
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {/** ... */},
                  child: Text(
                    'KIRIM',
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
