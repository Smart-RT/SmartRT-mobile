import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/voting/voting.dart';
import 'package:smart_rt/utilities/net_util.dart';

class VotingProvider extends ChangeNotifier {
  Voting myVoteData = Voting.fromData({});
  Voting get myData => myVoteData;
  set myData(Voting value) {
    myVoteData = value;
  }

  void updateListener() => notifyListeners();

  Future<void> getMyVoteData({
    required String periode,
  }) async {
    try {
      myVoteData = Voting.fromData({});
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/vote/data/my/period/$periode');

      if (resp.statusCode.toString() == '200') {
        if (resp.data != "") {
          myVoteData = Voting.fromData({
            "id": resp.data['id'],
            "voter_id": resp.data['voter_id'],
            "neighbourhood_head_candidate_id":
                resp.data['neighbourhood_head_candidate_id'],
            "created_at": resp.data['created_at'],
            "periode": resp.data['periode'],
            "dataVoter": resp.data['dataVoter'],
            "dataKandidat": resp.data['dataKandidat']
          });
        }
      }
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<bool> sendVote({
    required String periode,
    required int idNeighbourhoodHeadCandidate,
  }) async {
    try {
      await NetUtil().dioClient.post('/vote/send', data: {
        "idNeighbourhoodHeadCandidate": idNeighbourhoodHeadCandidate,
        "periode": periode,
      });

      getMyVoteData(periode: periode);
      return true;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
      return false;
    }
  }
}
