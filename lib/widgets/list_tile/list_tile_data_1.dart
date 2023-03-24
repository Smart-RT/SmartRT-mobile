import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';

class ListTileData1 extends StatelessWidget {
  const ListTileData1({
    Key? key,
    required this.txtLeft,
    required this.txtRight,
    this.txtStyleLeft,
    this.txtStyleRight,
    this.txtStyleColon,
    this.onTap,
  }) : super(key: key);

  final String txtLeft;
  final TextStyle? txtStyleLeft;
  final String txtRight;
  final TextStyle? txtStyleRight;
  final TextStyle? txtStyleColon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Text(
            txtLeft,
            style: txtStyleLeft ?? smartRTTextLarge,
          ),
        ),
        Expanded(
          child: Text(
            ':',
            style: txtStyleColon ?? smartRTTextLarge,
          ),
        ),
        Expanded(
          flex: 8,
          child: GestureDetector(
            onTap: onTap,
            child: Text(
              txtRight,
              style: txtStyleRight ?? smartRTTextLarge,
            ),
          ),
        ),
      ],
    );
  }
}
