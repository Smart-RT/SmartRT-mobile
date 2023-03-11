import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:photo_view/photo_view.dart';

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
    return Container(
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
            : PhotoView(imageProvider: NetworkImage(imgLocation)));
  }
}
