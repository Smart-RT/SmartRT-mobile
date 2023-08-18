import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/area/area.dart';

class AreaBillRepeatDetail {
  int id = -1;
  DateTime month_year = DateTime.now();
  int area_bill_id = -1;
  int bill_amount = 0;
  int payer_total = 0;
  int payer_count = 0;
  int total_paid_amount = 0;

  AreaBillRepeatDetail.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['month_year'] != null) {
      month_year = DateTime.parse(data['month_year'].toString());
    }
    if (data['area_bill_id'] != null) {
      area_bill_id = int.parse(data['area_bill_id'].toString());
    }
    if (data['bill_amount'] != null) {
      bill_amount = int.parse(data['bill_amount'].toString());
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
      'month_year': month_year,
      'area_bill_id': area_bill_id,
      'bill_amount': bill_amount,
      'payer_total': payer_total,
      'payer_count': payer_count,
      'total_paid_amount': total_paid_amount,
    };
  }
}
