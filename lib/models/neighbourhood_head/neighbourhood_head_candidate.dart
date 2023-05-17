import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/models/user/user.dart';

class NeighbourhoodHeadCandidate {
  int id = -1;
  int area_id = -1;
  Area? dataArea;
  int user_id = -1;
  User? dataUser;
  int periode = -1;
  String visi = '';
  String misi = '';
  int total_vote_obtained = -1;
  DateTime created_at = DateTime.now();
  User? created_by;
  DateTime? discualified_at;
  User? discualified_by;
  String? discualified_notes;
  int status = -99;

  // vote require
  String? totalTask;
  String? totalRatingTask;
  String? avgRatingTask;

  NeighbourhoodHeadCandidate.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['dataArea'] != null) {
      dataArea = Area.fromData(data['dataArea']);
    }
    if (data['user_id'] != null) {
      user_id = int.parse(data['user_id'].toString());
    }
    if (data['dataUser'] != null) {
      dataUser = User.fromData(data['dataUser']);
    }
    if (data['periode'] != null) {
      periode = int.parse(data['periode'].toString());
    }
    if (data['visi'] != null) {
      visi = data['visi'].toString();
    }
    if (data['misi'] != null) {
      misi = data['misi'].toString();
    }
    if (data['total_vote_obtained'] != null) {
      total_vote_obtained = int.parse(data['total_vote_obtained'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['created_by'] != null) {
      created_by = User.fromData(data['created_by']);
    }
    if (data['discualified_at'] != null) {
      discualified_at = DateTime.parse(data['discualified_at'].toString());
    }
    if (data['discualified_by'] != null) {
      discualified_by = User.fromData(data['discualified_by']);
    }
    if (data['discualified_notes'] != null) {
      discualified_notes = data['discualified_notes'].toString();
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['totalTask'] != null) {
      totalTask = data['totalTask'].toString();
    }
    if (data['totalRatingTask'] != null) {
      totalRatingTask = data['totalRatingTask'].toString();
    }
    if (data['avgRatingTask'] != null) {
      avgRatingTask = data['avgRatingTask'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "area_id": area_id,
      "dataArea": dataArea,
      "user_id": user_id,
      "dataUser": dataUser,
      "periode": periode,
      "visi": visi,
      "misi": misi,
      "total_vote_obtained": total_vote_obtained,
      "created_at": created_at,
      "created_by": created_by,
      "discualified_at": discualified_at,
      "discualified_by": discualified_by,
      "discualified_notes": discualified_notes,
      "status": status,
      "totalTask": totalTask,
      "totalRatingTask": totalRatingTask,
      "avgRatingTask": avgRatingTask,
    };
  }
}
