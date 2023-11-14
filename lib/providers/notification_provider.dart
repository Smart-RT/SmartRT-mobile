import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/notification/notification.dart' as No;
import 'package:smart_rt/utilities/net_util.dart';

class NotificationProvider extends ChangeNotifier {
  int totalUnread = 0;
  List<No.Notification> notifications = [];
  Map<String, Future> futures = {};

  void updateListener() => notifyListeners();

  Future<void> getNotifications(BuildContext context) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/notifications/get/all');

      // set total unread
      totalUnread = resp.data['total_unread'];
      notifications.clear();
      notifications.addAll(resp.data['notifications']
          .map<No.Notification>((d) => No.Notification.fromData(d)));
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> readNotification(
      BuildContext context, No.Notification notification) async {
    try {
      if (notification.isRead) return;

      Response<dynamic> resp = await NetUtil()
          .dioClient
          .patch('/notifications/read/${notification.id}');
      if (resp.statusCode.toString() == "200") {
        // set total unread
        totalUnread = totalUnread - 1;
        int indx = notifications.indexOf(notification);
        notifications[indx].isRead = true;
        notifyListeners();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> readAllNotification(BuildContext context) async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.patch('/notifications/read/all');
      if (resp.statusCode.toString() == "200") {
        // set total unread
        totalUnread = 0;
        notifications = notifications.map(
          (e) {
            e.isRead = true;
            return e;
          },
        ).toList();

        notifyListeners();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }
}
