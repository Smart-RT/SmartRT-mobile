import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_repeat_detail.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_transaction.dart';
import 'package:smart_rt/utilities/net_util.dart';

class AreaBillProvider extends ChangeNotifier {
  List<AreaBill> listAreaBill = [];
  List<AreaBillTransaction> listPembayar = [];
  List<AreaBillRepeatDetail> listBulanan = [];

  void updateListener() => notifyListeners();

  Future<bool> addAreaBill({
    required String name,
    required int billAmount,
    required int isRepeated,
  }) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.post('/iuran/add', data: {
        'name': name,
        'billAmount': billAmount,
        'isRepeated': isRepeated,
      });
      if (resp.statusCode.toString() == '200') {
        return true;
      } else {
        return false;
      }
      // notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<void> getAreaBillByAreaID({
    required int areaID,
  }) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/iuran/get/all/by-area/$areaID');
      if (resp.statusCode.toString() == '200') {
        listAreaBill.clear();
        listAreaBill.addAll((resp.data).map<AreaBill>((request) {
          return AreaBill.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getAreaBillTransactionByAreaBillID({
    required int areaBillID,
    int? areaBillRepeatDetailID,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .post('/iuran/transaction/get/all', data: {
        'areaBillID': areaBillID,
        'areaBillRepeatDetailID': areaBillRepeatDetailID
      });

      if (resp.statusCode.toString() == '200') {
        listPembayar.clear();
        listPembayar.addAll((resp.data).map<AreaBillTransaction>((request) {
          return AreaBillTransaction.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getAreaBillRepeatDetailByAreaBillID({
    required int areaBillID,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/iuran/repeat-detail/get/all/by-id/$areaBillID');

      if (resp.statusCode.toString() == '200') {
        listBulanan.clear();
        listBulanan.addAll((resp.data).map<AreaBillRepeatDetail>((request) {
          return AreaBillRepeatDetail.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> bayarCash(
      {required int areaID,
      required int areaBillTransactionID,
      required int areaBillID,
      int? areaBillRepeatDetailID}) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/iuran/transaction/payment/cash', data: {
        'areaBillID': areaBillID,
        'areaBillTransactionID': areaBillTransactionID,
        'areaBillRepeatDetailID': areaBillRepeatDetailID
      });
      if (resp.statusCode.toString() == '200') {
        getAreaBillByAreaID(areaID: areaID);
        getAreaBillTransactionByAreaBillID(areaBillID: areaBillID);
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

  Future<bool> bayarTF({
    required int areaID,
    required int areaBillID,
    required int areaBillTransactionID,
    required String paymentType,
    required String bank,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/iuran/transaction/payment/transfer-bank', data: {
        'payment_type': paymentType,
        'bank': bank,
        'id_bill': areaBillTransactionID,
      });
      if (resp.statusCode.toString() == '200') {
        getAreaBillByAreaID(areaID: areaID);
        getAreaBillTransactionByAreaBillID(areaBillID: areaBillID);
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

  Future<bool> batalkanMetodeTF({
    required int areaID,
    required int areaBillID,
  }) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/iuran/transaction/payment/cancel', data: {
        "id_bill": areaBillID,
      });
      if (resp.statusCode.toString() == '200') {
        getAreaBillByAreaID(areaID: areaID);
        getAreaBillTransactionByAreaBillID(areaBillID: areaBillID);
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

  Future<bool> nonAktifkanIuran({required AreaBill bill}) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/iuran/update/nonaktifkan/${bill.id}');

      if (resp.statusCode.toString() == '200') {
        int index = listAreaBill.indexOf(bill);
        listAreaBill[index].status = 0;
      }
      notifyListeners();

      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
    return false;
  }
}
