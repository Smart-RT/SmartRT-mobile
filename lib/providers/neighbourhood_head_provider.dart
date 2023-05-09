import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';

class NeighbourhoodHeadProvider extends ChangeNotifier {
  NeighbourhoodHeadCandidate dataSayaSebagaiKandidatPengurusRTSekarang =
      NeighbourhoodHeadCandidate.fromData({});
  NeighbourhoodHeadCandidate get getDataSayaSebagaiKandidatPengurusRTSekarang =>
      dataSayaSebagaiKandidatPengurusRTSekarang;
  set setDataSayaSebagaiKandidatPengurusRTSekarang(
      NeighbourhoodHeadCandidate value) {
    dataSayaSebagaiKandidatPengurusRTSekarang = value;
  }

  List<NeighbourhoodHeadCandidate> listKandidatPengurusRTSekarang = [];
  List<NeighbourhoodHeadCandidate> get getListKandidatPengurusRTSekarang =>
      listKandidatPengurusRTSekarang;
  set setListKandidatPengurusRTSekarang(
      List<NeighbourhoodHeadCandidate> value) {
    listKandidatPengurusRTSekarang = value;
  }

  void updateListener() => notifyListeners();

  Future<void> getDataMyNeighbourhoodHeadCandidateThisPeriod({
    required String periode,
  }) async {
    try {
      dataSayaSebagaiKandidatPengurusRTSekarang =
          NeighbourhoodHeadCandidate.fromData({});
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/neighbourhood-head/get/my/period/$periode');
      debugPrint('STATUS CODE');
      debugPrint(resp.statusCode.toString());
      if (resp.statusCode.toString() == '200') {
        NeighbourhoodHeadCandidate tempData =
            NeighbourhoodHeadCandidate.fromData(resp.data);
        User user = AuthProvider.currentUser!;
        DateTime tenureEnd =
            user.area!.tenure_end_at.add(const Duration(days: -60));
        if ((tempData.created_at).compareTo(tenureEnd) > 0) {
          dataSayaSebagaiKandidatPengurusRTSekarang =
              NeighbourhoodHeadCandidate.fromData(resp.data);
        }
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> resignFromCandidate(
      {required int idNeighbourhoodHeadCandidate,
      required String notes,
      required String periode}) async {
    try {
      await NetUtil().dioClient.patch('/neighbourhood-head/resign', data: {
        "idNeighbourhoodHeadCandidate": idNeighbourhoodHeadCandidate,
        "notes": notes,
      });
      getDataMyNeighbourhoodHeadCandidateThisPeriod(periode: periode);
      getListNeighbourhoodHeadCandidateThisPeriod(periode: periode);
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<void> getListNeighbourhoodHeadCandidateThisPeriod({
    required String periode,
  }) async {
    try {
      listKandidatPengurusRTSekarang.clear();

      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/neighbourhood-head/get/all/period/$periode');
      if (resp.statusCode.toString() == '200') {
        listKandidatPengurusRTSekarang
            .addAll((resp.data).map<NeighbourhoodHeadCandidate>((request) {
          return NeighbourhoodHeadCandidate.fromData(request);
        }));
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> discualifiedCandidate(
      {required int idNeighbourhoodHeadCandidate,
      required String alasan,
      required String periode}) async {
    try {
      await NetUtil()
          .dioClient
          .patch('/neighbourhood-head/discualification', data: {
        "idNeighbourhoodHeadCandidate": idNeighbourhoodHeadCandidate,
        "alasan": alasan,
      });
      getListNeighbourhoodHeadCandidateThisPeriod(periode: periode);
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }

  Future<bool> fillVisiMisi(
      {required int idNeighbourhoodHeadCandidate,
      required String visi,
      required String misi,
      required String periode}) async {
    try {
      await NetUtil()
          .dioClient
          .patch('/neighbourhood-head/update/visi-misi', data: {
        "idNeighbourhoodHeadCandidate": idNeighbourhoodHeadCandidate,
        "visi": visi,
        "misi": misi,
      });
      getDataMyNeighbourhoodHeadCandidateThisPeriod(periode: periode);
      getListNeighbourhoodHeadCandidateThisPeriod(periode: periode);
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }
}
