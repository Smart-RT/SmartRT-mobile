import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class ListTileData5 extends StatelessWidget {
  const ListTileData5({
    Key? key,
    required this.txtLeft,
    required this.txtRight,
    this.txtStyleLeft,
    this.txtStyleRight,
    this.onTap,
  }) : super(key: key);

  final String txtLeft;
  final TextStyle? txtStyleLeft;
  final String txtRight;
  final TextStyle? txtStyleRight;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 10,
          child: Text(
            txtLeft,
            style: txtStyleLeft ?? smartRTTextLarge,
            textAlign: TextAlign.left,
          ),
        ),
        SB_width15,
        Expanded(
          flex: 10,
          child: GestureDetector(
            onTap: onTap ?? () {},
            child: Text(
              txtRight,
              style: txtStyleRight ?? smartRTTextLarge,
              textAlign: TextAlign.right,
            ),
          ),
        ),
        SB_width15,
        Expanded(
            child: onTap == null ? SizedBox() : Icon(Icons.arrow_forward_ios)),
      ],
    );
  }
}
