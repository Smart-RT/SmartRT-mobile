import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class AuthProvider extends ApplicationProvider {
  static User? currentUser;
  static bool isLoggedIn = false;

  Future<bool> login(
      {required BuildContext context,
      required String phone,
      required String password}) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .post("/users/login", data: {"noTelp": phone, "kataSandi": password});
      User user = User.fromData(resp.data);
      currentUser = user;
      debugPrint(
          'IDnya: ${user.id}, Namanya: ${user.full_name} berjenis kelamin : ${user.gender}');
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        SmartRTSnackbar.show(context,
            message: e.response!.data.toString(),
            backgroundColor: smartRTErrorColor);
      }
      return false;
    }
  }
}
