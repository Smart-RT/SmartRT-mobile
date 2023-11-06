import 'package:smart_rt/models/lottery_club/lottery_club_period.dart';
import 'package:smart_rt/models/user/user.dart';

class LotteryClubPeriodDetail {
  int id = -1;
  LotteryClubPeriod? lottery_club_period_id;
  int? lottery_club_id;
  int total_attendance = 0;
  User? winner_1_id;
  User? winner_2_id;
  String status = 'Unpublished';
  int is_offline_meet = 0;
  String? meet_at;
  DateTime meet_date = DateTime.now();
  DateTime created_at = DateTime.now();
  int? created_by;
  DateTime? updated_at;
  int? updated_by;
  int pertemuan_ke = 0;
  int period_ke = 0;

  LotteryClubPeriodDetail.fromData(Map<String, dynamic> data) {
    id = int.parse(data['id'].toString());
    if (data['lottery_club_period_id'] != null) {
      lottery_club_period_id =
          LotteryClubPeriod.fromData(data['lottery_club_period_id']);
    }
    lottery_club_id = int.parse(data['lottery_club_id'].toString());
    if (data['total_attendance'] != null) {
      total_attendance = int.parse(data['total_attendance'].toString());
    }
    if (data['winner_1_id'] != null) {
      winner_1_id = User.fromData(data['winner_1_id']);
    }
    if (data['winner_2_id'] != null) {
      winner_2_id = User.fromData(data['winner_2_id']);
    }
    status = data['status'];
    is_offline_meet = int.parse(data['is_offline_meet'].toString());
    if (data['meet_at'] != null) {
      meet_at = data['meet_at'];
    }
    meet_date = DateTime.parse(data['meet_date']);

    created_by = data['created_by'];
    created_at = DateTime.parse(data['created_at']);

    if (data['updated_by'] != null) {
      updated_by = data['updated_by'];
    }
    if (data['updated_at'] != null) {
      updated_at = DateTime.parse(data['updated_at']);
    }
    if (data['pertemuan_ke'] != null) {
      pertemuan_ke = int.parse(data['pertemuan_ke'].toString());
    }
    if (data['period_ke'] != null) {
      period_ke = int.parse(data['period_ke'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "LotteryClubPeriodDetail": {
        "id": id,
        "lottery_club_period_id": lottery_club_period_id,
        "lottery_club_id": lottery_club_id,
        "total_attendance": total_attendance,
        "winner_1_id": winner_1_id,
        "winner_2_id": winner_2_id,
        "status": status,
        "is_offline_meet": is_offline_meet,
        "meet_at": meet_at,
        "meet_date": meet_date,
        "created_by": created_by,
        "created_at": created_at,
        "updated_by": updated_by,
        "updated_at": updated_at,
        "pertemuan_ke": pertemuan_ke,
        "period_ke": period_ke,
      }
    };
  }
}
