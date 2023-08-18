import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/area/area.dart';

class AreaBillTransaction {
  int id = -1;
  int area_bill_id = -1;
  int? area_bill_repeat_detail_id;
  int user_id = -1;
  String? midtrans_order_id;
  String? midtrans_trasanction_id;
  String? payment_type;
  String? acquiring_bank;
  int bill_amount = 0;
  String? va_num;
  int status = 0;
  String? midtrans_transaction_status;
  DateTime created_at = DateTime.now();
  DateTime? updated_at;
  User? updated_by;
  DateTime? midtrans_created_at;
  DateTime? midtrans_expired_at;
  User? dataUser;

  AreaBillTransaction.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['area_bill_id'] != null) {
      area_bill_id = int.parse(data['area_bill_id'].toString());
    }
    if (data['area_bill_repeat_detail_id'] != null) {
      area_bill_repeat_detail_id =
          int.parse(data['area_bill_repeat_detail_id'].toString());
    }
    if (data['user_id'] != null) {
      user_id = int.parse(data['user_id'].toString());
    }
    if (data['midtrans_order_id'] != null) {
      midtrans_order_id = data['midtrans_order_id'].toString();
    }
    if (data['midtrans_trasanction_id'] != null) {
      midtrans_trasanction_id = data['midtrans_trasanction_id'].toString();
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
      updated_by = User.fromData(data['updated_by']);
    }
    if (data['midtrans_created_at'] != null) {
      midtrans_created_at =
          DateTime.parse(data['midtrans_created_at'].toString());
    }
    if (data['midtrans_expired_at'] != null) {
      midtrans_expired_at =
          DateTime.parse(data['midtrans_expired_at'].toString());
    }
    if (data['dataUser'] != null) {
      dataUser = User.fromData(data['dataUser']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area_bill_id': area_bill_id,
      'area_bill_repeat_detail_id': area_bill_repeat_detail_id,
      'user_id': user_id,
      'midtrans_order_id': midtrans_order_id,
      'midtrans_trasanction_id': midtrans_trasanction_id,
      'payment_type': payment_type,
      'acquiring_bank': acquiring_bank,
      'bill_amount': bill_amount,
      'va_num': va_num,
      'status': status,
      'midtrans_transaction_status': midtrans_transaction_status,
      'created_at': created_at,
      'updated_at': updated_at,
      'updated_by': updated_by,
      'midtrans_created_at': midtrans_created_at,
      'midtrans_expired_at': midtrans_expired_at,
      'dataUser': dataUser,
    };
  }
}
