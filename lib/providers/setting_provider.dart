import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/app_setting/app_setting.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class SettingProvider extends ChangeNotifier {
  int subscribeAmount = 0;
  List<Map<String, dynamic>> karosel = [];

  void updateListener() => notifyListeners();

  Future<void> getDataSubscribeAmount() async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/setting/get/subscribe-amount');
      if (resp.statusCode.toString() == '200') {
        AppSetting dataSubscribeAmount = AppSetting.fromData(resp.data);
        subscribeAmount = int.parse(dataSubscribeAmount.detail);
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> updateSubscribeAmount({
    required int subcribeAmount,
  }) async {
    try {
      await NetUtil().dioClient.patch('/setting/update/subscribe-amount',
          data: {"subscribe_amount": subcribeAmount});
      getDataSubscribeAmount();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<bool> getKarosel() async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/setting/carousel/home/');
      karosel.clear();
      resp.data.forEach((item) {
        karosel.add({"about": item['about'], "detail": item['detail']});
      });
      notifyListeners();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<bool> updateKarosel({
    required BuildContext context,
    required CroppedFile karosel1,
    required CroppedFile karosel2,
    required CroppedFile karosel3,
  }) async {
    try {
      MultipartFile multipartKarosel1 = await MultipartFile.fromFile(
          karosel1.path,
          filename: karosel1.path.split('/').last,
          contentType: MediaType(
              'image', karosel1.path.split('/').last.split('.').last));

      MultipartFile multipartKarosel2 = await MultipartFile.fromFile(
          karosel2.path,
          filename: karosel2.path.split('/').last,
          contentType: MediaType(
              'image', karosel2.path.split('/').last.split('.').last));

      MultipartFile multipartKarosel3 = await MultipartFile.fromFile(
          karosel3.path,
          filename: karosel3.path.split('/').last,
          contentType: MediaType(
              'image', karosel3.path.split('/').last.split('.').last));

      var formData = FormData.fromMap({
        "Karosel1": multipartKarosel1,
        "Karosel2": multipartKarosel2,
        "Karosel3": multipartKarosel3,
      });

      Response<dynamic> resp = await NetUtil()
          .dioClient
          .post('/setting/carousel/home/update', data: formData);

      notifyListeners();
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
