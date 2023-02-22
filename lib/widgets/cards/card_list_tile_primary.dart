import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardListTilePrimary extends StatelessWidget {
  const CardListTilePrimary({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: paddingCard,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: smartRTPrimaryColor,
          boxShadow: [
            BoxShadow(
                color: smartRTShadowColor, spreadRadius: 5, blurRadius: 25),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: smartRTTextNormal_Secondary,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: smartRTSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
