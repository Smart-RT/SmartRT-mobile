import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/pdf_screen.dart';

class DaftarKetuaFormPage3 extends StatefulWidget {
  static const String id = 'DaftarKetuaFormPage3';
  const DaftarKetuaFormPage3({Key? key}) : super(key: key);

  @override
  State<DaftarKetuaFormPage3> createState() => _DaftarKetuaFormPage3State();
}

class _DaftarKetuaFormPage3State extends State<DaftarKetuaFormPage3> {
  FilePickerResult? _fileLampiran;
  PlatformFile? _file;
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
                _fileLampiran == null
                    ? Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            _fileLampiran = await FilePicker.platform.pickFiles(
                                type: FileType.custom,
                                allowedExtensions: ['pdf']);

                            if (_fileLampiran != null) {
                              File file = File(
                                  _fileLampiran!.files.single.path.toString());
                              _file = _fileLampiran!.files.first;
                              setState(() {});
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                color: smartRTSecondaryColor,
                                size: 20,
                              ),
                              SB_width15,
                              Text(
                                'Upload File',
                                style: smartRTTextNormalBold_Secondary,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          Card(
                            margin: EdgeInsets.all(0),
                            child: ListTile(
                              tileColor: smartRTPrimaryColor,
                              textColor: smartRTSecondaryColor,
                              leading:
                                  Image.asset('assets/img/icons/file/pdf.png'),
                              title: Text(
                                _file!.name,
                                style: smartRTTextNormalBold_Secondary,
                              ),
                              subtitle: Text(
                                _file!.path.toString(),
                                style: smartRTTextNormal_Secondary,
                              ),
                              trailing: GestureDetector(
                                  child: Icon(
                                    Icons.close,
                                    color: smartRTSecondaryColor,
                                    size: 15,
                                  ),
                                  onTap: () async {
                                    _fileLampiran = null;
                                    _file = null;
                                    setState(() {});
                                  }),
                            ),
                          ),
                          SB_height15,
                          Container(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PDFScreen(path: _file!.path.toString()),
                                  ),
                                );
                              },
                              child: Text(
                                'Lihat',
                                style: smartRTTextNormalBold_Secondary,
                              ),
                            ),
                          ),
                        ],
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
