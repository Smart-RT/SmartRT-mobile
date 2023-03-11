import 'package:smart_rt/models/area.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_member.dart';
import 'package:smart_rt/models/user.dart';

class LotteryClubPeriodDetailBill {
  int id = -1;
  int? lottery_club_period_detail_id;
  int? lottery_club_period_member_id;
  int? user_id;
  String? midtrans_order_id;
  String? midtrans_transaction_id;
  String? payment_type;
  String? acquiring_bank;
  int bill_amount = 0;
  String? va_num;
  int status = 0;
  String? midtrans_transaction_status;
  DateTime created_at = DateTime.now();
  int? created_by;
  DateTime? updated_at;
  int? updated_by;
  DateTime? midtrans_created_at;
  DateTime? midtrans_expired_at;
  User? data_user;
  User? data_user_konfirmasi;

  LotteryClubPeriodDetailBill.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['lottery_club_period_detail_id'] != null) {
      lottery_club_period_detail_id =
          int.parse(data['lottery_club_period_detail_id'].toString());
    }
    if (data['lottery_club_period_member_id'] != null) {
      lottery_club_period_member_id =
          int.parse(data['lottery_club_period_member_id'].toString());
    }
    if (data['user_id'] != null) {
      user_id = int.parse(data['user_id'].toString());
    }
    if (data['midtrans_order_id'] != null) {
      midtrans_order_id = data['midtrans_order_id'];
    }
    if (data['midtrans_transaction_id'] != null) {
      midtrans_transaction_id = data['midtrans_transaction_id'];
    }
    if (data['midtrans_transaction_status'] != null) {
      midtrans_transaction_status = data['midtrans_transaction_status'];
    }
    if (data['midtrans_created_at'] != null) {
      midtrans_created_at =
          DateTime.parse(data['midtrans_created_at'].toString());
    }
    if (data['midtrans_expired_at'] != null) {
      midtrans_expired_at =
          DateTime.parse(data['midtrans_expired_at'].toString());
    }
    if (data['payment_type'] != null) {
      payment_type = data['payment_type'];
    }
    if (data['acquiring_bank'] != null) {
      acquiring_bank = data['acquiring_bank'];
    }

    if (data['bill_amount'] != null) {
      bill_amount = int.parse(data['bill_amount'].toString());
    }
    if (data['va_num'] != null) {
      va_num = data['va_num'];
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at']);
    }
    if (data['created_by'] != null) {
      created_by = int.parse(data['created_by'].toString());
    }
    if (data['updated_at'] != null) {
      updated_at = DateTime.parse(data['updated_at']);
    }
    if (data['updated_by'] != null) {
      updated_by = int.parse(data['updated_by'].toString());
    }
    if (data['data_user'] != null) {
      data_user = User.fromData(data['data_user']);
    }
    if (data['data_user_konfirmasi'] != null) {
      data_user_konfirmasi = User.fromData(data['data_user_konfirmasi']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "LotteryClubPeriodDetailBill": {
        "id": id.toString(),
        "lottery_club_period_detail_id":
            lottery_club_period_detail_id.toString(),
        "lottery_club_period_member_id":
            lottery_club_period_member_id.toString(),
        "user_id": user_id.toString(),
        "midtrans_order_id": midtrans_order_id.toString(),
        "midtrans_transaction_id": midtrans_transaction_id.toString(),
        "payment_type": payment_type.toString(),
        "acquiring_bank": acquiring_bank.toString(),
        "bill_amount": bill_amount.toString(),
        "va_num": va_num.toString(),
        "status": status.toString(),
        "midtrans_transaction_status": midtrans_transaction_status.toString(),
        "created_at": created_at.toString(),
        "created_by": created_by.toString(),
        "updated_at": updated_at.toString(),
        "updated_by": updated_by.toString(),
        "midtrans_created_at": midtrans_created_at.toString(),
        "midtrans_expired_at": midtrans_expired_at.toString(),
        "data_user": data_user,
        "data_user_konfirmasi": data_user_konfirmasi,
      }
    };
  }
}
