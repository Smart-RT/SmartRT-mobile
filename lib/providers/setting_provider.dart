import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/app_setting/app_setting.dart';
import 'package:smart_rt/utilities/net_util.dart';

class SettingProvider extends ChangeNotifier {
  int subscribeAmount = 0;

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
}
