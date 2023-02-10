import 'package:smart_rt/models/area.dart';
import 'package:smart_rt/models/lottery_club.dart';
import 'package:smart_rt/models/user.dart';

class LotteryClubPeriod {
  int id = -1;
  Area? area_id;
  LotteryClub? lottery_club_id;
  int period = 0;
  int income_amount = 0;
  int expense_amount = 0;
  int kas_period_amount = 0;
  int bill_amount = 0;
  int winner_bill_amount = 0;
  int total_already_not_be_a_winner = 0;
  int meet_ctr = 0;
  int year_limit = 0;
  int total_members = 0;
  int total_meets = 0;
  String default_meet_location = '';
  DateTime default_meet_date = DateTime.now();
  DateTime started_at = DateTime.now();
  DateTime ended_at = DateTime.now();
  DateTime created_at = DateTime.now();
  User? created_by;
  DateTime updated_at = DateTime.now();
  User? updated_by;

  LotteryClubPeriod.fromData(Map<String, dynamic> data) {
    id = data['id'];
    area_id = data['area_id'];
    lottery_club_id = data['lottery_club_id'];
    period = data['period'];
    income_amount = data['income_amount'];
    expense_amount = data['expense_amount'];
    kas_period_amount = data['kas_period_amount'];
    bill_amount = data['bill_amount'];
    winner_bill_amount = data['winner_bill_amount'];
    total_already_not_be_a_winner = data['total_already_not_be_a_winner'];
    meet_ctr = data['meet_ctr'];
    year_limit = data['year_limit'];
    total_members = data['total_members'];
    total_meets = data['total_meets'];
    default_meet_location = data['default_meet_location'];
    default_meet_date = data['default_meet_date'];
    started_at = data['started_at'];
    ended_at = data['ended_at'];
    created_at = data['created_at'];
    created_by = data['created_by'];
    updated_at = data['updated_at'];
    updated_by = data['updated_by'];
  }

  Map<String, dynamic> toJson() {
    return {
      "LotteryClubPeriod": {
        "id": id,
        "area_id": area_id,
        "lottery_club_id": lottery_club_id,
        "period": period,
        "income_amount": income_amount,
        "expense_amount": expense_amount,
        "kas_period_amount": kas_period_amount,
        "bill_amount": bill_amount,
        "winner_bill_amount": winner_bill_amount,
        "total_already_not_be_a_winner": total_already_not_be_a_winner,
        "meet_ctr": meet_ctr,
        "year_limit": year_limit,
        "total_members": total_members,
        "total_meets": total_meets,
        "default_meet_location": default_meet_location,
        "default_meet_date": default_meet_date.toString(),
        "started_at": started_at.toString(),
        "ended_at": ended_at.toString(),
        "created_at": created_at.toString(),
        "created_by": created_by,
        "updated_at": updated_at.toString(),
        "updated_by": updated_by,
      }
    };
  }
}
