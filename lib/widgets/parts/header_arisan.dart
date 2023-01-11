import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class HeaderArisan extends StatelessWidget {
  const HeaderArisan(
      {Key? key,
      required this.preTitle,
      required this.title,
      required this.subTitle,
      required this.preTitleColor,
      required this.titleColor,
      required this.subTitleColor})
      : super(key: key);

  final String preTitle;
  final String title;
  final String subTitle;
  final Color preTitleColor;
  final Color titleColor;
  final Color subTitleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: smartRTPrimaryColor,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: preTitle != "",
              child: Text(
                preTitle,
                style: smartRTTextLarge.copyWith(
                    color: preTitleColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Visibility(
              visible: title != "",
              child: Text(
                title,
                style: smartRTTextTitle.copyWith(color: titleColor),
                textAlign: TextAlign.center,
              ),
            ),
            Visibility(
              visible: subTitle != "",
              child: Text(
                subTitle,
                style: smartRTTextNormal.copyWith(
                    color: subTitleColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
