import 'package:smart_rt/models/user/user.dart';

class Committe {
  int id = -1;
  User? data_user;
  int area_id = -1;
  int status = -99;
  DateTime created_at = DateTime.now();
  User? created_by;
  DateTime? confirmation_at;
  User? confirmation_by;
  String? notes;

  Committe.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['data_user'] != null) {
      data_user = User.fromData(data['data_user']);
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['created_by'] != null) {
      created_by = User.fromData(data['created_by']);
    }
    if (data['confirmation_at'] != null) {
      confirmation_at = DateTime.parse(data['confirmation_at'].toString());
    }
    if (data['confirmation_by'] != null) {
      confirmation_by = User.fromData(data['confirmation_by']);
    }
    if (data['notes'] != null) {
      notes = data['notes'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "data_user": data_user,
      "area_id": area_id,
      "status": status,
      "created_at": created_at,
      "created_by": created_by,
      "confirmation_at": confirmation_at,
      "confirmation_by": confirmation_by,
      "notes": notes,
    };
  }
}
