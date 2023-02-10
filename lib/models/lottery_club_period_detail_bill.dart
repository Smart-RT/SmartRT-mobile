import 'package:smart_rt/models/area.dart';
import 'package:smart_rt/models/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club_period_member.dart';
import 'package:smart_rt/models/user.dart';

class LotteryClubPeriodDetailBill {
  int id = -1;
  LotteryClubPeriodDetail? lottery_club_period_detail_id;
  LotteryClubPeriodMember? lottery_club_period_member_id;
  User? user_id;
  int bill_amount = 0;
  int? pay_amount;
  String? via;
  String? va_num;
  int status = 0;
  DateTime created_at = DateTime.now();
  User? created_by;
  DateTime? updated_at;
  User? updated_by;

  LotteryClubPeriodDetailBill.fromData(Map<String, dynamic> data) {
    id = data['id'];
    lottery_club_period_detail_id = data['lottery_club_period_detail_id'];
    lottery_club_period_member_id = data['lottery_club_period_member_id'];
    user_id = data['user_id'];
    bill_amount = data['bill_amount'];
    pay_amount = data['pay_amount'];
    via = data['via'];
    va_num = data['va_num'];
    status = data['status'];
    created_at = data['created_at'];
    created_by = data['created_by'];
    updated_at = data['updated_at'];
    updated_by = data['updated_by'];
  }

  Map<String, dynamic> toJson() {
    return {
      "LotteryClubPeriodDetailBill": {
        "id": id,
        "lottery_club_period_detail_id": lottery_club_period_detail_id,
        "lottery_club_period_member_id": lottery_club_period_member_id,
        "user_id": user_id,
        "bill_amount": bill_amount,
        "pay_amount": pay_amount,
        "via": via,
        "va_num": va_num,
        "status": status,
        "created_at": created_at,
        "created_by": created_by,
        "updated_at": updated_at,
        "updated_by": updated_by,
      }
    };
  }
}
