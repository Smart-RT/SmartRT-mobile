import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/area/area.dart';

class ProSubscribe {
  int id = -1;
  int area_id = -1;
  DateTime? latest_payment_at;
  DateTime created_at = DateTime.now();
  User? created_by;
  int status = -99;

  Area? dataArea;

  ProSubscribe.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['latest_payment_at'] != null) {
      latest_payment_at = DateTime.parse(data['latest_payment_at'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['created_by'] != null) {
      created_by = User.fromData(data['created_by']);
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }

    if (data['dataArea'] != null) {
      dataArea = Area.fromData(data['dataArea']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "area_id": area_id,
      "latest_payment_at": latest_payment_at,
      "created_at": created_at,
      "created_by": created_by,
      "status": status,
      "dataArea": dataArea,
    };
  }
}
