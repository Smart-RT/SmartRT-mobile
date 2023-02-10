import 'package:smart_rt/models/user.dart';

class LotteryClubPeriodMember {
  int id = -1;
  User? user_id;
  int periode = 0;
  int debt_amount = 0;
  int already_be_a_winner = 0;
  int status = 1;
  String? notes;
  DateTime created_at = DateTime.now();
  User? created_by;

  LotteryClubPeriodMember.fromData(Map<String, dynamic> data) {
    id = data['id'];
    user_id = data['user_id'];
    periode = data['periode'];
    debt_amount = data['debt_amount'];
    already_be_a_winner = data['already_be_a_winner'];
    status = data['status'];
    notes = data['notes'];
    created_at = data['created_at'];
    created_by = data['created_by'];
  }

  Map<String, dynamic> toJson() {
    return {
      "LotteryClubPeriodMember": {
        "id": id,
        "user_id": user_id,
        "periode": periode,
        "debt_amount": debt_amount,
        "already_be_a_winner": already_be_a_winner,
        "status": status,
        "notes": notes,
        "created_at": created_at,
        "created_by": created_by,
      }
    };
  }
}
