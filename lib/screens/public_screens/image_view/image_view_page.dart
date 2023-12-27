import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class ImageViewPageArgument {
  String imgLocation;
  ImageViewPageArgument({required this.imgLocation});
}

class ImageViewPage extends StatefulWidget {
  static const String id = 'ImageViewPage';
  ImageViewPageArgument args;
  ImageViewPage({Key? key, required this.args}) : super(key: key);

  @override
  State<ImageViewPage> createState() => _ImageViewPageState();
}

class _ImageViewPageState extends State<ImageViewPage> {
  String imgLocation = '';

  void getData() async {
    imgLocation = widget.args.imgLocation;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        GestureDetector(
          onTap: () async {
            final response = await NetUtil().dioClient.get(imgLocation,
                options: Options(responseType: ResponseType.bytes));
            var dir = Directory('/storage/emulated/0/Download');
            var filename = '${dir.path}/${imgLocation.split('/').last}';
            final file = File(filename);
            await file.writeAsBytes(Uint8List.fromList(response.data));
            SmartRTSnackbar.show(context,
                message: 'Berhasil download gambar',
                backgroundColor: smartRTSuccessColor);
          },
          child: Icon(Icons.download),
        ),
        SB_width15
      ]),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: smartRTPrimaryColor,
          child: imgLocation == ''
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Lottie.asset(
                          'assets/lotties/welcome/welcome-smile.json',
                          fit: BoxFit.fitWidth),
                    ),
                    Text(
                      'MOHON MENUNGGU ...',
                      textAlign: TextAlign.center,
                      style: smartRTTextLarge.copyWith(
                          color: smartRTSecondaryColor, letterSpacing: 3),
                    ),
                  ],
                )
              : PhotoView(imageProvider: NetworkImage(imgLocation))),
    );
  }
}
