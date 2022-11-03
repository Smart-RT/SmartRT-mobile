import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_3.dart';
import 'package:provider/provider.dart';

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
  final ImagePicker _picker = ImagePicker();
  CroppedFile? croppedImageKTP;
  CroppedFile? croppedImageKTPSelfie;

  void _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (type == 'KTP') {
        croppedImageKTP = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
      } else {
        croppedImageKTPSelfie = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                Text(
                  'Foto KTP',
                  style: smartRTTextTitleCard_Primary,
                ),
                SB_height15,
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: croppedImageKTP == null
                      ? GestureDetector(
                          onTap: () {
                            _pickImage('KTP');
                          },
                          child: Container(
                            color: smartRTShadowColor,
                            child: Icon(
                              Icons.add_circle_outlined,
                              size: 50,
                              color: smartRTPrimaryColor,
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            Image.file(File(croppedImageKTP!.path)),
                            Positioned(
                                bottom: 1,
                                right: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    _pickImage('KTP');
                                  },
                                  child: Stack(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 45,
                                        color: smartRTPrimaryColor,
                                      ),
                                      Positioned(
                                        top: 1,
                                        right: 1,
                                        child: Icon(
                                          Icons.change_circle,
                                          size: 20,
                                          color: smartRTTertiaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                ),
                SB_height30,
                Text(
                  'Foto Selfie dengan KTP',
                  style: smartRTTextTitleCard_Primary,
                ),
                SB_height15,
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: croppedImageKTPSelfie == null
                      ? GestureDetector(
                          onTap: () {
                            _pickImage('KTPSelfie');
                          },
                          child: Container(
                            color: smartRTShadowColor,
                            child: Icon(
                              Icons.add_circle_outlined,
                              size: 50,
                              color: smartRTPrimaryColor,
                            ),
                          ),
                        )
                      : Stack(
                          children: [
                            Image.file(File(croppedImageKTPSelfie!.path)),
                            Positioned(
                                bottom: 1,
                                right: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    _pickImage('KTPSelfie');
                                  },
                                  child: Stack(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 45,
                                        color: smartRTPrimaryColor,
                                      ),
                                      Positioned(
                                        top: 1,
                                        right: 1,
                                        child: Icon(
                                          Icons.change_circle,
                                          size: 20,
                                          color: smartRTTertiaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
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
