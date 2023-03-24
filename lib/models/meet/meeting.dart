import 'package:smart_rt/models/user/user.dart';

class Meeting {
  int id = -1;
  int area_id = -1;
  DateTime meet_datetime = DateTime.now();
  User? meet_datetime_negotiated_by;
  String title = '';
  String detail = '';
  String file_lampiran = '';
  DateTime created_at = DateTime.now();
  User? created_by;
  DateTime? confirmated_at;
  User? confirmated_by;
  String? confirmated_notes;
  User? origin_respondent_by;
  User? new_respondent_by;
  int? new_respondent_role;
  DateTime? change_respondent_at;
  int status = 0;

  Meeting.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['meet_datetime'] != null) {
      meet_datetime = DateTime.parse(data['meet_datetime'].toString());
    }
    if (data['meet_datetime_negotiated_by'] != null) {
      meet_datetime_negotiated_by =
          User.fromData(data['meet_datetime_negotiated_by']);
    }
    if (data['title'] != null) {
      title = data['title'].toString();
    }
    if (data['detail'] != null) {
      detail = data['detail'].toString();
    }
    if (data['file_lampiran'] != null) {
      file_lampiran = data['file_lampiran'].toString();
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['created_by'] != null) {
      created_by = User.fromData(data['created_by']);
    }
    if (data['confirmated_at'] != null) {
      confirmated_at = DateTime.parse(data['confirmated_at'].toString());
    }
    if (data['confirmated_by'] != null) {
      confirmated_by = User.fromData(data['confirmated_by']);
    }
    if (data['confirmated_notes'] != null) {
      confirmated_notes = data['confirmated_notes'].toString();
    }
    if (data['origin_respondent_by'] != null) {
      origin_respondent_by = User.fromData(data['origin_respondent_by']);
    }
    if (data['new_respondent_by'] != null) {
      new_respondent_by = User.fromData(data['new_respondent_by']);
    }
    if (data['new_respondent_role'] != null) {
      new_respondent_role = int.parse(data['new_respondent_role'].toString());
    }
    if (data['change_respondent_at'] != null) {
      change_respondent_at =
          DateTime.parse(data['change_respondent_at'].toString());
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "area_id": area_id.toString(),
      "meet_datetime": meet_datetime.toString(),
      "meet_datetime_negotiated_by": meet_datetime_negotiated_by.toString(),
      "title": title.toString(),
      "detail": detail.toString(),
      "file_lampiran": file_lampiran.toString(),
      "created_at": created_at.toString(),
      "created_by": created_by.toString(),
      "confirmated_at": confirmated_at.toString(),
      "confirmated_by": confirmated_by.toString(),
      "confirmated_notes": confirmated_notes.toString(),
      "origin_respondent_by": origin_respondent_by.toString(),
      "new_respondent_by": new_respondent_by.toString(),
      "new_respondent_role": new_respondent_role.toString(),
      "change_respondent_at": change_respondent_at.toString(),
      "status": status.toString(),
    };
  }
}
