import 'package:smart_rt/models/lottery_club_period.dart';
import 'package:smart_rt/models/lottery_club.dart';
import 'package:smart_rt/models/user.dart';

class LotteryClubPeriodDetail {
  int id = -1;
  LotteryClubPeriod? lottery_club_period_id;
  LotteryClub? lottery_club_id;
  int total_attendance = 0;
  User? winner_1_id;
  User? winner_2_id;
  String status = 'Unpublished';
  int is_offline_meet = 0;
  String? meet_at;
  DateTime meet_date = DateTime.now();
  DateTime created_by = DateTime.now();
  User? created_at;
  DateTime updated_by = DateTime.now();
  User? updated_at;

  LotteryClubPeriodDetail.fromData(Map<String, dynamic> data) {
    id = data['id'];
    lottery_club_period_id = data['lottery_club_period_id'];
    lottery_club_id = data['lottery_club_id'];
    total_attendance = data['total_attendance'];
    winner_1_id = data['winner_1_id'];
    winner_2_id = data['winner_2_id'];
    status = data['status'];
    is_offline_meet = data['is_offline_meet'];
    meet_at = data['meet_at'];
    meet_date = data['meet_date'];
    created_by = data['created_by'];
    created_at = data['created_at'];
    updated_by = data['updated_by'];
    updated_at = data['updated_at'];
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
      }
    };
  }
}
