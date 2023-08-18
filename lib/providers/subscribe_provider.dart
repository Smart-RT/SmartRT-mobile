import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/models/subscribe/pro_subscribe_bill.dart';
import 'package:smart_rt/utilities/net_util.dart';

class SubscribeProvider extends ChangeNotifier {
  List<ProSubscribeBill> riwayatTagihan = [];
  List<Area> listAreaLangganan = [];

  void updateListener() => notifyListeners();

  Future<void> getListAreaLangganan() async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/addresses/get/area/subscribe');
      if (resp.statusCode.toString() == '200') {
        listAreaLangganan.clear();
        listAreaLangganan.addAll((resp.data).map<Area>((request) {
          return Area.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getRiwayatTagihanByAreaID({
    required int areaID,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/subscribe-pro/bill/get-list/by/area/$areaID');
      if (resp.statusCode.toString() == '200') {
        riwayatTagihan.clear();
        riwayatTagihan.addAll((resp.data).map<ProSubscribeBill>((request) {
          return ProSubscribeBill.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getRiwayatTagihanByProSubscribeID({
    required int proSubscribeID,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/subscribe-pro/bill/get-list/by/pro-subscribe/$proSubscribeID');
      if (resp.statusCode.toString() == '200') {
        riwayatTagihan.clear();
        riwayatTagihan.addAll((resp.data).map<ProSubscribeBill>((request) {
          return ProSubscribeBill.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> pilihMetodePembayaran({
    required String paymentType,
    required String bank,
    required int idProSubscribeBill,
    required int index,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/subscribe-pro/payment/pick-method', data: {
        'paymentType': paymentType,
        'bank': bank,
        'idProSubscribeBill': idProSubscribeBill,
      });
      if (resp.statusCode.toString() == '200') {
        ProSubscribeBill dataBaru = ProSubscribeBill.fromData(resp.data);
        riwayatTagihan[index] = dataBaru;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<bool> batalkanMetodePembayaran({
    required int idProSubscribeBill,
    required int index,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/subscribe-pro/payment/cancel', data: {
        'idProSubscribeBill': idProSubscribeBill,
      });
      if (resp.statusCode.toString() == '200') {
        ProSubscribeBill dataBaru = ProSubscribeBill.fromData(resp.data);
        riwayatTagihan[index] = dataBaru;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<bool> getRiwayatTagihanByID({
    required int idProSubscribeBill,
    required int index,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/subscribe-pro/bill/get/$idProSubscribeBill');
      if (resp.statusCode.toString() == '200') {
        ProSubscribeBill dataBaru = ProSubscribeBill.fromData(resp.data);
        if (dataBaru == riwayatTagihan[index]) {
          return false;
        } else {
          riwayatTagihan[index] = dataBaru;
          notifyListeners();
          return true;
        }
      } else {
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }
}
