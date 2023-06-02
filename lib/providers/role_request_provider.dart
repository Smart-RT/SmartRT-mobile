import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/utilities/net_util.dart';

class RoleRequestProvider extends ChangeNotifier {
  List<UserRoleRequest> listUserRoleReqKetuaRT = [];

  void updateListener() => notifyListeners();

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
      required String tenureEndAt}) async {
    try {
      debugPrint('sadsada');
      UserRoleRequest data = listUserRoleReqKetuaRT[index];
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/users/update/roleReq/ketua', data: {
        "idRoleReq": data.id,
        "isAccepted": isAccepted,
        "tenure_end_at": tenureEndAt
      });

      debugPrint('asdsadadadsdsa');

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
