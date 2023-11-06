import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/setting_provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class KaroselBerandaPage extends StatefulWidget {
  static const String id = 'KaroselBerandaPage';
  const KaroselBerandaPage({Key? key}) : super(key: key);

  @override
  State<KaroselBerandaPage> createState() => _KaroselBerandaPageState();
}

class _KaroselBerandaPageState extends State<KaroselBerandaPage> {
  final ImagePicker _picker = ImagePicker();
  CroppedFile? croppedImgKarosel3;
  CroppedFile? croppedImgKarosel2;
  CroppedFile? croppedImgKarosel1;

  void simpan() async {
    bool isSuccess = await context.read<SettingProvider>().updateKarosel(
          context: context,
          karosel1: croppedImgKarosel1!,
          karosel2: croppedImgKarosel2!,
          karosel3: croppedImgKarosel3!,
        );
    if (isSuccess) {
      Navigator.pop(context);
      SmartRTSnackbar.show(context,
          message: "Berhasil menyimpan!", backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: "Gagal membuat permintaan!",
          backgroundColor: smartRTErrorColor);
    }
  }

  void _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (type == 'Karosel3') {
        croppedImgKarosel3 = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
      } else if (type == 'Karosel2') {
        croppedImgKarosel2 = await ImageCropper().cropImage(
            sourcePath: image.path,
            aspectRatioPresets: [CropAspectRatioPreset.ratio16x9]);
      } else {
        croppedImgKarosel1 = await ImageCropper().cropImage(
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
        title: Text('Karosel Beranda'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Karosel Beranda [ 1 / 3 ]',
                style: smartRTTextTitleCard_Primary,
              ),
              SB_height15,
              AspectRatio(
                aspectRatio: 16 / 9,
                child: croppedImgKarosel1 == null
                    ? GestureDetector(
                        onTap: () {
                          _pickImage('Karosel1');
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
                          Image.file(File(croppedImgKarosel1!.path)),
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage('Karosel1');
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
                'Karosel Beranda [ 2 / 3 ]',
                style: smartRTTextTitleCard_Primary,
              ),
              SB_height15,
              AspectRatio(
                aspectRatio: 16 / 9,
                child: croppedImgKarosel2 == null
                    ? GestureDetector(
                        onTap: () {
                          _pickImage('Karosel2');
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
                          Image.file(File(croppedImgKarosel2!.path)),
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage('Karosel2');
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
                'Karosel Beranda [ 3 / 3 ]',
                style: smartRTTextTitleCard_Primary,
              ),
              SB_height15,
              AspectRatio(
                aspectRatio: 16 / 9,
                child: croppedImgKarosel3 == null
                    ? GestureDetector(
                        onTap: () {
                          _pickImage('Karosel3');
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
                          Image.file(File(croppedImgKarosel3!.path)),
                          Positioned(
                              bottom: 1,
                              right: 1,
                              child: GestureDetector(
                                onTap: () {
                                  _pickImage('Karosel3');
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
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            simpan();
          },
          child: Text(
            'SIMPAN',
            style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
