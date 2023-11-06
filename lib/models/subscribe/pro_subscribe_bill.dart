import 'package:smart_rt/models/user/user.dart';

class ProSubscribeBill {
  int id = -1;
  int pro_subscribe_id = -1;
  int area_id = -1;
  int? payer_id;
  String? midtrans_order_id;
  String? midtrans_transaction_id;
  String? payment_type;
  String? acquiring_bank;
  int bill_amount = 0;
  String? va_num;
  int status = -99;
  String? midtrans_transaction_status;
  DateTime created_at = DateTime.now();
  DateTime? updated_at;
  User? updated_by;
  DateTime? midtrans_created_at;
  DateTime? midtrans_expired_at;

  ProSubscribeBill.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['pro_subscribe_id'] != null) {
      pro_subscribe_id = int.parse(data['pro_subscribe_id'].toString());
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['payer_id'] != null) {
      payer_id = int.parse(data['payer_id'].toString());
    }
    if (data['midtrans_order_id'] != null) {
      midtrans_order_id = data['midtrans_order_id'].toString();
    }
    if (data['midtrans_transaction_id'] != null) {
      midtrans_transaction_id = data['midtrans_transaction_id'].toString();
    }
    if (data['payment_type'] != null) {
      payment_type = data['payment_type'].toString();
    }
    if (data['acquiring_bank'] != null) {
      acquiring_bank = data['acquiring_bank'].toString();
    }
    if (data['bill_amount'] != null) {
      bill_amount = int.parse(data['bill_amount'].toString());
    }
    if (data['va_num'] != null) {
      va_num = data['va_num'].toString();
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['midtrans_transaction_status'] != null) {
      midtrans_transaction_status =
          data['midtrans_transaction_status'].toString();
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['updated_at'] != null) {
      updated_at = DateTime.parse(data['updated_at'].toString());
    }
    if (data['updated_by'] != null) {
      User.fromData(data['updated_by']);
    }
    if (data['midtrans_created_at'] != null) {
      midtrans_created_at =
          DateTime.parse(data['midtrans_created_at'].toString());
    }
    if (data['midtrans_expired_at'] != null) {
      midtrans_expired_at =
          DateTime.parse(data['midtrans_expired_at'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "pro_subscribe_id": pro_subscribe_id,
      "area_id": area_id,
      "payer_id": payer_id,
      "midtrans_order_id": midtrans_order_id,
      "midtrans_transaction_id": midtrans_transaction_id,
      "payment_type": payment_type,
      "acquiring_bank": acquiring_bank,
      "bill_amount": bill_amount,
      "va_num": va_num,
      "status": status,
      "created_at": created_at,
      "updated_at": updated_at,
      "midtrans_expired_at": midtrans_expired_at,
      "midtrans_created_at": midtrans_created_at,
    };
  }
}
