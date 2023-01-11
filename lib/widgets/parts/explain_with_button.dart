import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class ExplainWithButton extends StatelessWidget {
  const ExplainWithButton({
    Key? key,
    required this.title,
    required this.notes,
    required this.buttonText,
    required this.onTapDestination,
  }) : super(key: key);

  final String title;
  final String notes;
  final String buttonText;
  final String onTapDestination;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: smartRTTextTitle,
        ),
        Text(
          notes,
          style: smartRTTextNormal_Primary,
        ),
        SB_height15,
        Container(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, onTapDestination);
            },
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
