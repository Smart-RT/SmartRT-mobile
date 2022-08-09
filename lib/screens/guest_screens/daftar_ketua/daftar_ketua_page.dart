import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_1.dart';

class DaftarKetuaPage extends StatefulWidget {
  static const String id = 'DaftarKetuaPage';
  const DaftarKetuaPage({Key? key}) : super(key: key);

  @override
  State<DaftarKetuaPage> createState() => _DaftarKetuaPageState();
}

class _DaftarKetuaPageState extends State<DaftarKetuaPage> {
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
                  'Daftar Menjadi\nKetua RT',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Anda menjabat sebagai Ketua RT di wilayah anda? Yuk daftarkan diri anda pada aplikasi ini sebagai ketua RT agar dapat mengajak warga anda untuk masuk ke wilayah anda dan mengakses fitur-fitur yang akan membantu warga serta pengurus wilayah RT anda.',
                  style: smartRTTextNormal_Primary,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, DaftarKetuaFormPage1.id);
                },
                child: Text(
                  'DAFTAR SEKARANG',
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