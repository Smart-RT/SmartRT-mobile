import 'package:smart_rt/models/area.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_member.dart';
import 'package:smart_rt/models/user.dart';

class LotteryClubPeriodDetailAbsence {
  int id = -1;
  User? user_id;
  int lottery_club_period_member_id = -99;
  int lottery_club_period_detail_id = -99;
  int is_present = 0;
  DateTime? present_date;
  DateTime created_at = DateTime.now();
  int? created_by;

  LotteryClubPeriodDetailAbsence.fromData(Map<String, dynamic> data) {
    id = int.parse(data['id'].toString());
    if (data['user_id'] != null) {
      user_id = User.fromData(data['user_id']);
    }
    lottery_club_period_member_id =
        int.parse(data['lottery_club_period_member_id'].toString());
    lottery_club_period_detail_id =
        int.parse(data['lottery_club_period_detail_id'].toString());
    is_present = data['is_present'];
    if (data['present_date'] != null) {
      present_date = DateTime.parse(data['present_date']);
    }
    created_at = DateTime.parse(data['created_at']);
    created_by = int.parse(data['created_by'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": user_id,
      "lottery_club_period_member_id": lottery_club_period_member_id,
      "lottery_club_period_detail_id": lottery_club_period_detail_id,
      "is_present": is_present,
      "present_date": present_date,
      "created_at": created_at,
      "created_by": created_by,
    };
  }
}
