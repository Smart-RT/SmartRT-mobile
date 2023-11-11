import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';

class RoleRequestProvider extends ChangeNotifier {
  List<UserRoleRequest> listUserRoleReqKetuaRT = [];
  List<UserRoleRequest> listUserRoleReqPengurus = [];
  List<UserRoleRequest> listUserRoleReqWargaPermohonan = [];
  List<UserRoleRequest> listUserRoleReqWargaDikonfirmasi = [];
  Map<String, Future> futures = {};

  void updateListener() => notifyListeners();

  Future<void> getUserRoleReqWargaYes() async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/users/getRoleRequest/typeReqRole/warga/isConfirmation/yes');
      listUserRoleReqWargaDikonfirmasi.clear();
      listUserRoleReqWargaDikonfirmasi
          .addAll((resp.data).map<UserRoleRequest>((request) {
        return UserRoleRequest.fromData(request);
      }));
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getUserRoleReqWargaNo() async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/users/getRoleRequest/typeReqRole/warga/isConfirmation/no');
      listUserRoleReqWargaDikonfirmasi.clear();
      listUserRoleReqWargaPermohonan
          .addAll((resp.data).map<UserRoleRequest>((request) {
        return UserRoleRequest.fromData(request);
      }));
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getUserRoleReqPengurusData() async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/users/getRoleRequests');
      if (resp.statusCode.toString() == '200') {
        listUserRoleReqPengurus.clear();
        listUserRoleReqPengurus
            .addAll((resp.data).map<UserRoleRequest>((request) {
          return UserRoleRequest.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getUserRoleReqKetuaData() async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/users/getRoleRequest/typeReqRole/ketua-rt');
      if (resp.statusCode.toString() == '200') {
        listUserRoleReqKetuaRT.clear();
        listUserRoleReqKetuaRT
            .addAll((resp.data).map<UserRoleRequest>((request) {
          return UserRoleRequest.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> confirmationUserRoleReqKetua(
      {required bool isAccepted,
      required int index,
      required String tenureEndAt,
      required String notes}) async {
    try {
      UserRoleRequest data = listUserRoleReqKetuaRT[index];
      Response<dynamic> resp =
          await NetUtil().dioClient.patch('/users/update/roleReq/ketua', data: {
        "idRoleReq": data.id,
        "isAccepted": isAccepted,
        "tenure_end_at": tenureEndAt,
        "notes": notes
      });

      listUserRoleReqKetuaRT[index].confirmater_id =
          AuthProvider.currentUser!.id;
      listUserRoleReqKetuaRT[index].accepted_at = DateTime.now();

      notifyListeners();

      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }
}
