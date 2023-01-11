import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';

class ListTileArisan extends StatelessWidget {
  const ListTileArisan(
      {Key? key, required this.title, required this.onTapDestination})
      : super(key: key);

  final String title;
  final String onTapDestination;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: smartRTTextLargeBold_Primary,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: smartRTPrimaryColor,
      ),
      onTap: (){Navigator.pushNamed(context, onTapDestination);},
    );
  }
}
