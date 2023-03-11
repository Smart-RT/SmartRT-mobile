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
  int? created_by;

  LotteryClubPeriodMember.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['user_id'] != null) {
      user_id = User.fromData(data['user_id']);
    }
    if (data['periode'] != null) {
      periode = int.parse(data['periode'].toString());
    }
    if (data['debt_amount'] != null) {
      debt_amount = int.parse(data['debt_amount'].toString());
    }
    if (data['already_be_a_winner'] != null) {
      already_be_a_winner = int.parse(data['already_be_a_winner'].toString());
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['notes'] != null) {
      notes = data['notes'];
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at']);
    }
    if (data['created_by'] != null) {
      created_by = int.parse(data['created_by'].toString());
    }
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
        "created_at": created_at.toString(),
        "created_by": created_by,
      }
    };
  }
}
