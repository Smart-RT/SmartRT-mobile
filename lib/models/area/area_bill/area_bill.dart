import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/area/area.dart';

class AreaBill {
  int id = -1;
  String name = '';
  int area_id = -1;
  int bill_amount = 0;
  int status = 0;
  int is_repeated = 0;
  DateTime created_at = DateTime.now();
  User? created_by;
  DateTime? ended_at;
  User? ended_by;
  Area? dataArea;
  int payer_total = 0;
  int payer_count = 0;
  int total_paid_amount = 0;

  AreaBill.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['name'] != null) {
      name = data['name'].toString();
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['bill_amount'] != null) {
      bill_amount = int.parse(data['bill_amount'].toString());
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['is_repeated'] != null) {
      is_repeated = int.parse(data['is_repeated'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['ended_at'] != null) {
      ended_at = DateTime.parse(data['ended_at'].toString());
    }
    if (data['created_by'] != null) {
      created_by = User.fromData(data['created_by']);
    }
    if (data['ended_by'] != null) {
      ended_by = User.fromData(data['ended_by']);
    }
    if (data['dataArea'] != null) {
      dataArea = Area.fromData(data['dataArea']);
    }
    if (data['payer_total'] != null) {
      payer_total = int.parse(data['payer_total'].toString());
    }
    if (data['payer_count'] != null) {
      payer_count = int.parse(data['payer_count'].toString());
    }
    if (data['total_paid_amount'] != null) {
      total_paid_amount = int.parse(data['total_paid_amount'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'area_id': area_id,
      'bill_amount': bill_amount,
      'status': status,
      'is_repeated': is_repeated,
      'created_at': created_at,
      'ended_at': ended_at,
      'created_by': created_by,
      'ended_by': ended_by,
      'dataArea': dataArea,
      'payer_total': payer_total,
      'payer_count': payer_count,
      'total_paid_amount': total_paid_amount,
    };
  }
}
