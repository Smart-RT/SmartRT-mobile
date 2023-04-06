import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:http_parser/http_parser.dart';
import 'package:smart_rt/providers/news_provider.dart';
import 'package:smart_rt/screens/public_screens/home/public_home.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class CreatePengumumanPage2Argument {
  String title;
  String detail;

  CreatePengumumanPage2Argument({
    required this.title,
    required this.detail,
  });
}

class CreatePengumumanPage2 extends StatefulWidget {
  static const String id = 'CreatePengumumanPage2';
  CreatePengumumanPage2Argument args;
  CreatePengumumanPage2({Key? key, required this.args}) : super(key: key);

  @override
  State<CreatePengumumanPage2> createState() => _CreatePengumumanPage2State();
}

class _CreatePengumumanPage2State extends State<CreatePengumumanPage2> {
  final ImagePicker _picker = ImagePicker();
  CroppedFile? croppedImageLampiran;

  void buatDanTampilkanPengumuman() async {
    Response<dynamic> resp;
    bool isSukses = true;
    if (croppedImageLampiran == null) {
      isSukses = await context.read<NewsProvider>().createNews(
          title: widget.args.title,
          detail: widget.args.detail,
          isWithLampiran: 'false');
    } else {
      MultipartFile multipartImageLampiran = await MultipartFile.fromFile(
          croppedImageLampiran!.path,
          filename: croppedImageLampiran!.path.split('/').last,
          contentType: MediaType('image',
              croppedImageLampiran!.path.split('/').last.split('.').last));
      isSukses = await context.read<NewsProvider>().createNews(
          title: widget.args.title,
          detail: widget.args.detail,
          isWithLampiran: 'true',
          multiPartImageLampiran: multipartImageLampiran);
    }

    if (isSukses) {
      Navigator.pop(context);
      Navigator.pop(context);
      SmartRTSnackbar.show(context,
          message: 'Berhasil membuat pengumuman!',
          backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: 'Terjadi Kesalahan, Coba lagi nanti !',
          backgroundColor: smartRTErrorColor);
    }
  }

  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      croppedImageLampiran = await ImageCropper().cropImage(
        sourcePath: image.path,
      );

      setState(() {});
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
        title: Text('Buat Pengumuman ( 2 / 2 )'),
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
                    'Lampiran'.toUpperCase(),
                    style: smartRTTextTitle_Primary,
                  ),
                  Text(
                    'Unggahlah foto file pengumuman yang berformat .png, .jpg, atau .jpeg',
                    style: smartRTTextNormal_Primary,
                    textAlign: TextAlign.justify,
                  ),
                  SB_height30,
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: croppedImageLampiran == null
                        ? GestureDetector(
                            onTap: () {
                              _pickImage();
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
                              Center(
                                  child: Image.file(
                                      File(croppedImageLampiran!.path))),
                              Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      _pickImage();
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
            buatDanTampilkanPengumuman();
          },
          child: Text(
            'BUAT DAN TAMPILKAN',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
