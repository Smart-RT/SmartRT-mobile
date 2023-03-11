import 'package:flutter/material.dart';
import 'package:smart_rt/constants/style.dart';

class SmartRTSnackbar {
  static void show(BuildContext context,
      {required String message, required Color backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: smartRTTextSmall,
      ),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}
