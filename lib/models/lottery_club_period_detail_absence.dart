import 'package:smart_rt/models/area.dart';
import 'package:smart_rt/models/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club_period_member.dart';
import 'package:smart_rt/models/user.dart';

class LotteryClubPeriodDetailAbsence {
  int id = -1;
  User? user_id;
  LotteryClubPeriodMember? lottery_club_period_member_id;
  LotteryClubPeriodDetail? lottery_club_period_detail_id;
  int is_present = 0;
  DateTime? present_date;
  DateTime created_at = DateTime.now();
  User? created_by;

  LotteryClubPeriodDetailAbsence.fromData(Map<String, dynamic> data) {
    id = data['id'];
    user_id = data['user_id'];
    lottery_club_period_member_id = data['lottery_club_period_member_id'];
    lottery_club_period_detail_id = data['lottery_club_period_detail_id'];
    is_present = data['is_present'];
    present_date = data['present_date'];
    created_at = data['created_at'];
    created_by = data['created_by'];
  }

  Map<String, dynamic> toJson() {
    return {
      "LotteryClubPeriodDetailAbsence": {
        "id": id,
        "user_id": user_id,
        "lottery_club_period_member_id": lottery_club_period_member_id,
        "lottery_club_period_detail_id": lottery_club_period_detail_id,
        "is_present": is_present,
        "present_date": present_date,
        "created_at": created_at,
        "created_by": created_by,
      }
    };
  }
}
