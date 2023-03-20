import 'package:smart_rt/models/user/user.dart';

class News {
  int id = -1;
  String? file_img;
  String title = '';
  String detail = '';
  int area_id = -1;
  DateTime created_at = DateTime.now();
  User? created_by;
  int status = 1;

  News.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['file_img'] != null) {
      file_img = data['file_img'].toString();
    }
    if (data['title'] != null) {
      title = data['title'].toString();
    }
    if (data['detail'] != null) {
      detail = data['detail'].toString();
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
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
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "file_img": file_img.toString(),
      "title": title.toString(),
      "detail": detail.toString(),
      "area_id": area_id.toString(),
      "status": status.toString(),
      "created_at": created_at.toString(),
      "created_by": created_by,
    };
  }
}
