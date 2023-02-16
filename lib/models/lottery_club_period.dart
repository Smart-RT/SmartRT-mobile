class LotteryClubPeriod {
  int id = -1;
  int? area_id;
  int? lottery_club_id;
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
  int? created_by;
  DateTime updated_at = DateTime.now();
  int? updated_by;

  LotteryClubPeriod.fromData(Map<String, dynamic> data) {
    id = int.parse(data['id'].toString());
    area_id = int.parse(data['area_id'].toString());
    lottery_club_id = int.parse(data['lottery_club_id'].toString());
    period = int.parse(data['period'].toString());
    income_amount = int.parse(data['income_amount'].toString());
    expense_amount = int.parse(data['expense_amount'].toString());
    kas_period_amount = int.parse(data['kas_period_amount'].toString());
    bill_amount = int.parse(data['bill_amount'].toString());
    winner_bill_amount = int.parse(data['winner_bill_amount'].toString());
    total_already_not_be_a_winner =
        int.parse(data['total_already_not_be_a_winner'].toString());
    meet_ctr = int.parse(data['meet_ctr'].toString());
    year_limit = int.parse(data['year_limit'].toString());
    total_members = int.parse(data['total_members'].toString());
    total_meets = int.parse(data['total_meets'].toString());
    if (data['default_meet_location'] != null) {
      default_meet_location = data['default_meet_location'];
    }
    if (data['default_meet_date'] != null) {
      default_meet_date = DateTime.parse(data['default_meet_date']);
    }
    started_at = DateTime.parse(data['started_at']);
    if (data['ended_at'] != null) {
      ended_at = DateTime.parse(data['ended_at']);
    }
    created_at = DateTime.parse(data['created_at']);
    created_by = int.parse(data['created_by'].toString());
    if (data['updated_at'] != null) {
      updated_at = DateTime.parse(data['updated_at']);
    }
    if (data['updated_by'] != null) {
      updated_by = int.parse(data['updated_by'].toString());
    }
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
