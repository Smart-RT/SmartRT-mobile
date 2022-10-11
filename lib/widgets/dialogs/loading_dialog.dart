import 'package:smart_rt/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog {
  static show(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: Center(
                child: Container(
                  color: smartRTPrimaryColor,
              width: 175,
              height: 175,
              child: AlertDialog(
                  contentPadding: EdgeInsets.all(15),
                  content: SpinKitSpinningLines(color: smartRTSecondaryColor)),
            )),
          );
        });
  }

  static hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
