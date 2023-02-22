import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardListTileWithButton extends StatelessWidget {
  const CardListTileWithButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onTapButton,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String buttonText;
  final Function()? onTapButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: smartRTTextTitle_Primary,
        ),
        SB_height15,
        Text(
          subtitle,
          style: smartRTTextNormal_Primary,
          textAlign: TextAlign.justify,
        ),
        SB_height30,
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTapButton,
            child: Text(
              buttonText,
              style: smartRTTextLargeBold_Secondary,
            ),
          ),
        ),
      ],
    );
  }
}
