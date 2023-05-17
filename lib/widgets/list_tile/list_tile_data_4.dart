import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class ListTileData4 extends StatelessWidget {
  const ListTileData4({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: smartRTPrimaryColor,
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(50))),
          child: Text(
            title,
            style: smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
          ),
        ),
        SB_height15,
        Row(
          children: [
            SB_width5,
            Icon(
              Icons.circle,
              size: 5,
              color: smartRTPrimaryColor,
            ),
            SB_width15,
            Text(subTitle)
          ],
        ),
        SB_height15,
      ],
    );
  }
}
