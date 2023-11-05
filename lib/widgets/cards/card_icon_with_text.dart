import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/utilities/string/string_format.dart';

class CardIconWithText extends StatelessWidget {
  const CardIconWithText({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: 70,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: smartRTTertiaryColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
          SB_height5,
          Text(
            StringFormat.convert1Line1Word(title),
            style: smartRTTextNormal,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
