import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/committe/committe.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';

class CommitteProvider extends ChangeNotifier {
  Committe dataMyCommitteActive = Committe.fromData({});
  Committe get committe => dataMyCommitteActive;
  set committe(Committe value) {
    dataMyCommitteActive = value;
  }

  List<Committe> listPanitiaSekarang = [];
  List<Committe> get committeSekarang => listPanitiaSekarang;
  set committeSekarang(List<Committe> value) {
    listPanitiaSekarang = value;
  }

  void updateListener() => notifyListeners();

  Future<void> getDataMyCommitteActive() async {
    try {
      dataMyCommitteActive = Committe.fromData({});
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/committe/get/my');
      if (resp.statusCode.toString() == '200') {
        Committe tempData = Committe.fromData(resp.data);
        User user = AuthProvider.currentUser!;
        DateTime tenureEnd =
            user.area!.tenure_end_at.add(const Duration(days: -60));
        if ((tempData.created_at).compareTo(tenureEnd) > 0) {
          dataMyCommitteActive = Committe.fromData(resp.data);
        }
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getListCommitte() async {
    try {
      listPanitiaSekarang.clear();

      Response<dynamic> resp =
          await NetUtil().dioClient.get('/committe/get/all');
      if (resp.statusCode.toString() == '200') {
        listPanitiaSekarang.addAll((resp.data).map<Committe>((request) {
          return Committe.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> cancelReqCommitte({
    required int idCommitte,
  }) async {
    try {
      await NetUtil().dioClient.patch('/committe/req/cancel', data: {
        "committe_id": idCommitte,
      });
      getDataMyCommitteActive();
      getListCommitte();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<bool> acceptReqCommitte({
    required int idCommitte,
  }) async {
    try {
      await NetUtil().dioClient.patch('/committe/req/accept', data: {
        "committe_id": idCommitte,
      });
      getDataMyCommitteActive();
      getListCommitte();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<bool> rejectReqCommitte({
    required int idCommitte,
    required String alasan,
  }) async {
    try {
      await NetUtil().dioClient.patch('/committe/req/reject', data: {
        "committe_id": idCommitte,
        "alasan": alasan,
      });
      getDataMyCommitteActive();
      getListCommitte();
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }
}
