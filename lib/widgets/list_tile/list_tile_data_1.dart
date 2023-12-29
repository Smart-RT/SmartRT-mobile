import 'package:flutter/material.dart';
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
    this.crossAxisAlignment,
    this.isShowIconArrow,
  }) : super(key: key);

  final String txtLeft;
  final TextStyle? txtStyleLeft;
  final String txtRight;
  final TextStyle? txtStyleRight;
  final TextStyle? txtStyleColon;
  final GestureTapCallback? onTap;
  final bool? isShowIconArrow;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
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
        Expanded(
            child: isShowIconArrow == null
                ? SizedBox()
                : !isShowIconArrow!
                    ? SizedBox()
                    : GestureDetector(
                        onTap: onTap, child: Icon(Icons.arrow_forward_ios))),
      ],
    );
  }
}
