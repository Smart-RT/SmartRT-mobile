import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/meet/meeting.dart';
import 'package:smart_rt/utilities/net_util.dart';

class MeetingProvider extends ChangeNotifier {
  List<Meeting> listMeetingPermohonan = [];
  List<Meeting> listMeetingTerjadwalkan = [];
  List<Meeting> listMeetingTelahBerlalu = [];
  List<Meeting> listMeetingStatusNegative = [];
  Map<String, Future> futures = {};

  void updateListener() => notifyListeners();

  Future<void> getPermohonan() async {
    try {
      Response<dynamic> respPermohonan =
          await NetUtil().dioClient.get('/meet/get/status/permohonan');
      listMeetingPermohonan.clear();
      listMeetingPermohonan
          .addAll((respPermohonan.data).map<Meeting>((request) {
        return Meeting.fromData(request);
      }));
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getTerjadwalkan() async {
    try {
      Response<dynamic> respTerjadwalkan =
          await NetUtil().dioClient.get('/meet/get/status/terjadwalkan');
      listMeetingTerjadwalkan.clear();
      listMeetingTerjadwalkan
          .addAll((respTerjadwalkan.data).map<Meeting>((request) {
        return Meeting.fromData(request);
      }));
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getTelahBerlalu() async {
    try {
      Response<dynamic> respTelahBerlalu =
          await NetUtil().dioClient.get('/meet/get/status/telah-berlalu');
      listMeetingTelahBerlalu.clear();
      listMeetingTelahBerlalu
          .addAll((respTelahBerlalu.data).map<Meeting>((request) {
        return Meeting.fromData(request);
      }));
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getStatusNegative() async {
    try {
      Response<dynamic> respStatusNegative =
          await NetUtil().dioClient.get('/meet/get/status/status-negative');
      listMeetingStatusNegative.clear();
      listMeetingStatusNegative
          .addAll((respStatusNegative.data).map<Meeting>((request) {
        return Meeting.fromData(request);
      }));
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }
}
