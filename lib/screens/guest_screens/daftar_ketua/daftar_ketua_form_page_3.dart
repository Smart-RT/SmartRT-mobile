import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_page.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/pdf_screen.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class DaftarKetuaFormPage3Arguments {
  String namaLengkap;
  String alamat;
  String kecamatan;
  String kelurahan;
  String noRT;
  String noRW;
  CroppedFile croppedImageKTP;
  CroppedFile croppedImageKTPSelfie;

  DaftarKetuaFormPage3Arguments({
    required this.namaLengkap,
    required this.alamat,
    required this.kecamatan,
    required this.kelurahan,
    required this.noRT,
    required this.noRW,
    required this.croppedImageKTP,
    required this.croppedImageKTPSelfie,
  });
}

class DaftarKetuaFormPage3 extends StatefulWidget {
  static const String id = 'DaftarKetuaFormPage3';
  DaftarKetuaFormPage3Arguments args;
  DaftarKetuaFormPage3({Key? key, required this.args}) : super(key: key);

  @override
  State<DaftarKetuaFormPage3> createState() => _DaftarKetuaFormPage3State();
}

class _DaftarKetuaFormPage3State extends State<DaftarKetuaFormPage3> {
  FilePickerResult? _fileLampiran;
  PlatformFile? _file;

  void daftarReqKetuaRT() async {
    bool isSuccess = await context.read<AuthProvider>().daftarReqKetuaRT(
        context: context,
        alamat: widget.args.alamat,
        namaLengkap: widget.args.namaLengkap,
        rt_num: widget.args.noRT,
        rw_num: widget.args.noRW,
        sub_district_id: widget.args.kecamatan,
        urban_village_id: widget.args.kelurahan,
        ktp: widget.args.croppedImageKTP,
        ktpSelfie: widget.args.croppedImageKTPSelfie,
        fileLampiran: _fileLampiran!);
    if (isSuccess) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      SmartRTSnackbar.show(context,
          message: "Berhasil membuat permintaan!",
          backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: "Gagal membuat permintaan!",
          backgroundColor: smartRTErrorColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Ketua RT ( 3 / 3 )'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
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
                  ? SizedBox(
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
                        SizedBox(
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
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: () {
            if (_fileLampiran != null) {
              daftarReqKetuaRT();
            } else {
              SmartRTSnackbar.show(context,
                  message: 'File Lampiran tidak boleh kosong!',
                  backgroundColor: smartRTErrorColor);
            }
          },
          child: Text(
            'DAFTAR',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
