import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/pengumuman/create_pengumuman/create_pengumuman_page_2.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class CreatePengumumanPage1 extends StatefulWidget {
  static const String id = 'CreatePengumumanPage1';
  const CreatePengumumanPage1({Key? key}) : super(key: key);

  @override
  State<CreatePengumumanPage1> createState() => _CreatePengumumanPage1State();
}

class _CreatePengumumanPage1State extends State<CreatePengumumanPage1> {
  final _TECTitle = TextEditingController();
  final _TECDetail = TextEditingController();

  void nextPage() async {
    if (_TECDetail.text == '' || _TECTitle.text == '') {
      SmartRTSnackbar.show(context,
          message: 'Pastikan semua data terisi !',
          backgroundColor: smartRTErrorColor);
    } else {
      CreatePengumumanPage2Argument args = CreatePengumumanPage2Argument(
          title: _TECTitle.text, detail: _TECDetail.text);
      Navigator.pushNamed(context, CreatePengumumanPage2.id, arguments: args);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Pengumuman ( 1 / 2 )'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: paddingScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Judul dan \nIsi Pengumuman'.toUpperCase(),
                    style: smartRTTextTitle_Primary,
                  ),
                  Text(
                    'Isilah pada kolom Judul dan Isi Pengumuman sesuai pengumuman yang ingin diumumkan!',
                    style: smartRTTextNormal_Primary,
                    textAlign: TextAlign.justify,
                  ),
                  SB_height30,
                  TextFormField(
                    controller: _TECTitle,
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Judul Pengumuman',
                    ),
                  ),
                  SB_height30,
                  TextFormField(
                    controller: _TECDetail,
                    autocorrect: false,
                    maxLines: 10,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Isi Pengumuman',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ))),
          onPressed: () async {
            nextPage();
          },
          child: Text(
            'SELANJUTNYA',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
