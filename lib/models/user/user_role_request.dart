import 'package:smart_rt/models/area/sub_district.dart';
import 'package:smart_rt/models/area/urban_village.dart';
import 'package:smart_rt/models/user/user.dart';

class UserRoleRequest {
  int id = -1;
  int requester_id = -1;
  int? confirmater_id;
  int confirmater_role_id = -1;
  int? area_id;
  String? request_code;
  String? ktp_img;
  String? selfie_ktp_img;
  String? file_lampiran;
  int request_role = -1;
  int? rt_num;
  int? rw_num;
  SubDistrict? sub_district_id;
  UrbanVillage? urban_village_id;
  DateTime created_at = DateTime.now();
  DateTime? accepted_at;
  DateTime? rejected_at;
  User? data_user_requester;
  User? data_user_confirmater;

  UserRoleRequest.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['requester_id'] != null) {
      requester_id = int.parse(data['requester_id'].toString());
    }

    if (data['request_role'] != null) {
      request_role = int.parse(data['request_role'].toString());
    }

    if (data['confirmater_role_id'] != null) {
      confirmater_role_id = int.parse(data['confirmater_role_id'].toString());
    }
    if (data['confirmater_id'] != null) {
      confirmater_id = int.parse(data['confirmater_id'].toString());
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['request_code'] != null) {
      request_code = data['request_code'];
    }
    if (data['ktp_img'] != null) {
      ktp_img = data['ktp_img'];
    }
    if (data['selfie_ktp_img'] != null) {
      selfie_ktp_img = data['selfie_ktp_img'];
    }
    if (data['file_lampiran'] != null) {
      file_lampiran = data['file_lampiran'];
    }
    if (data['rt_num'] != null) {
      rt_num = int.parse(data['rt_num'].toString());
    }
    if (data['rw_num'] != null) {
      rw_num = int.parse(data['rw_num'].toString());
    }
    if (data['sub_district_id'] != null) {
      sub_district_id = SubDistrict.fromData(data['sub_district_id']);
    }
    if (data['urban_village_id'] != null) {
      urban_village_id = UrbanVillage.fromData(data['urban_village_id']);
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at']);
    }
    if (data['accepted_at'] != null) {
      accepted_at = DateTime.parse(data['accepted_at']);
    }
    if (data['rejected_at'] != null) {
      rejected_at = DateTime.parse(data['rejected_at']);
    }
    if (data['data_user_confirmater'] != null) {
      data_user_confirmater = User.fromData(data['data_user_confirmater']);
    }
    if (data['data_user_requester'] != null) {
      data_user_requester = User.fromData(data['data_user_requester']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "userRoleRequest": {
        "id": id.toString(),
        "requester_id": requester_id.toString(),
        "confirmater_id": confirmater_id.toString(),
        "confirmater_role_id": confirmater_role_id.toString(),
        "area_id": area_id.toString(),
        "request_code": request_code.toString(),
        "ktp_img": ktp_img.toString(),
        "selfie_ktp_img": selfie_ktp_img.toString(),
        "file_lampiran": file_lampiran.toString(),
        "request_role": request_role.toString(),
        "rt_num": rt_num.toString(),
        "rw_num": rw_num.toString(),
        "sub_district_id": sub_district_id.toString(),
        "urban_village_id": urban_village_id.toString(),
        "created_at": created_at.toString(),
        "accepted_at": accepted_at.toString(),
        "rejected_at": rejected_at.toString(),
        "data_user_confirmater": data_user_confirmater,
        "data_user_requester": data_user_requester,
      }
    };
  }
}
