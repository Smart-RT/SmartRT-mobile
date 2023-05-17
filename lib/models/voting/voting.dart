import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
import 'package:smart_rt/models/user/user.dart';

class Voting {
  int id = -1;
  int voter_id = -1;
  int neighbourhood_head_candidate_id = -1;
  DateTime created_at = DateTime.now();
  String periode = '';
  User? dataVoter;
  NeighbourhoodHeadCandidate? dataKandidat;

  Voting.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['voter_id'] != null) {
      voter_id = int.parse(data['voter_id'].toString());
    }
    if (data['neighbourhood_head_candidate_id'] != null) {
      neighbourhood_head_candidate_id =
          int.parse(data['neighbourhood_head_candidate_id'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at']);
    }
    if (data['periode'] != null) {
      periode = data['periode'].toString();
    }
    if (data['dataVoter'] != null) {
      dataVoter = User.fromData(data['dataVoter']);
    }
    if (data['dataKandidat'] != null) {
      dataKandidat = NeighbourhoodHeadCandidate.fromData(data['dataKandidat']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "voter_id": voter_id,
      "neighbourhood_head_candidate_id": neighbourhood_head_candidate_id,
      "created_at": created_at,
      "periode": periode,
      "dataVoter": dataVoter,
      "dataKandidat": dataKandidat
    };
  }
}
