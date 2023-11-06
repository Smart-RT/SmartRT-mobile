import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardListTileWithButton extends StatelessWidget {
  const CardListTileWithButton({
    Key? key,
    required this.title,
    this.titleTextStyle,
    required this.subtitle,
    this.buttonText,
    this.onTapButton,
    this.buttonText2,
    this.onTapButton2,
  }) : super(key: key);

  final String title;
  final TextStyle? titleTextStyle;
  final String subtitle;
  final String? buttonText;
  final Function()? onTapButton;
  final String? buttonText2;
  final Function()? onTapButton2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: titleTextStyle ?? smartRTTextTitle,
          textAlign: TextAlign.left,
        ),
        SB_height15,
        Text(
          subtitle,
          style: smartRTTextNormal_Primary,
          textAlign: TextAlign.justify,
        ),
        SB_height30,
        if (buttonText != '' && buttonText != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTapButton ?? () {},
              child: Text(
                buttonText!,
                style: smartRTTextLargeBold_Secondary,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        if (buttonText2 != '' &&
            buttonText2 != null &&
            buttonText != '' &&
            buttonText != null)
          SB_height15,
        if (buttonText2 != '' && buttonText2 != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTapButton2 ?? () {},
              child: Text(
                buttonText2!,
                style: smartRTTextLargeBold_Secondary,
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
