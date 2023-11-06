import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class ReqUpdateRolePage extends StatefulWidget {
  static const String id = 'ReqUpdateRolePage';
  const ReqUpdateRolePage({Key? key}) : super(key: key);

  @override
  State<ReqUpdateRolePage> createState() => _ReqUpdateRolePageState();
}

class _ReqUpdateRolePageState extends State<ReqUpdateRolePage> {
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
                  'Anda Pengurus Wilayah?',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Masukkan kode kepengurusan wilayah anda yang didapatkan dari Ketua RT wilayah anda agar dapat mengakses fitur-fitur pengurus wilayah yang sudah disediakan',
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
                    return null;
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
