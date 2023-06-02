import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/utilities/net_util.dart';

class PopulationProvider extends ChangeNotifier {
  int populasiUtara = 0;
  int get populasiU => populasiUtara;
  set populasiU(int value) {
    populasiUtara = value;
  }

  int populasiBarat = 0;
  int get populasiB => populasiBarat;
  set populasiB(int value) {
    populasiBarat = value;
  }

  int populasiSelatan = 0;
  int get populasiS => populasiSelatan;
  set populasiS(int value) {
    populasiSelatan = value;
  }

  int populasiTimur = 0;
  int get populasiT => populasiTimur;
  set populasiT(int value) {
    populasiTimur = value;
  }

  int populasiPusat = 0;
  int get populasiP => populasiPusat;
  set populasiP(int value) {
    populasiPusat = value;
  }

  void updateListener() => notifyListeners();

  Future<void> getPopulation() async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/addresses/get/total-population');
      if (resp.statusCode.toString() == '200') {
        populasiBarat = resp.data['barat'];
        populasiPusat = resp.data['pusat'];
        populasiSelatan = resp.data['selatan'];
        populasiTimur = resp.data['timur'];
        populasiUtara = resp.data['utara'];
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }
}
