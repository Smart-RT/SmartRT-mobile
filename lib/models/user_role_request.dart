import 'package:flutter/material.dart';
import 'package:smart_rt/models/sub_districts.dart';
import 'package:smart_rt/models/urban_villages.dart';
import 'package:smart_rt/screens/public_screens/update_role/req_update_role_page.dart';

class UserRoleRequests {
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
  SubDistricts? sub_district_id;
  UrbanVillages? urban_village_id;
  DateTime created_at = DateTime.now();
  DateTime? accepted_at;
  DateTime? rejected_at;

  UserRoleRequests.fromData(Map<String, dynamic> data) {
    Map<String, dynamic> userRoleRequestData = data;
    id = userRoleRequestData['id'];
    requester_id = userRoleRequestData['requester_id'];
    confirmater_id = userRoleRequestData['confirmater_id'];
    confirmater_role_id = userRoleRequestData['confirmater_role_id'];
    area_id = userRoleRequestData['area_id'];
    request_code = userRoleRequestData['request_code'];
    ktp_img = userRoleRequestData['ktp_img'];
    selfie_ktp_img = userRoleRequestData['selfie_ktp_img'];
    file_lampiran = userRoleRequestData['file_lampiran'];
    request_role = userRoleRequestData['request_role'];
    rt_num = userRoleRequestData['rt_num'];
    rw_num = userRoleRequestData['rw_num'];

    if (userRoleRequestData['sub_district_id'] != null) {    
      sub_district_id = SubDistricts.fromData(userRoleRequestData['sub_district_id']);
    }
    if (userRoleRequestData['urban_village_id'] != null) {    
      urban_village_id = UrbanVillages.fromData(userRoleRequestData['urban_village_id']);
    }

    if (userRoleRequestData['created_at'] != null) {
      created_at = DateTime.parse(userRoleRequestData['created_at']);
    }
    if (userRoleRequestData['accepted_at'] != null) {
      accepted_at = DateTime.parse(userRoleRequestData['accepted_at']);
    }
    if (userRoleRequestData['rejected_at'] != null) {
      rejected_at = DateTime.parse(userRoleRequestData['rejected_at']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "userRoleRequests": {
        "id": id,
        "requester_id": requester_id,
        "confirmater_id": confirmater_id,
        "confirmater_role_id": confirmater_role_id,
        "area_id": area_id,
        "request_code": request_code,
        "ktp_img": ktp_img,
        "selfie_ktp_img": selfie_ktp_img,
        "file_lampiran": file_lampiran,
        "request_role": request_role,
        "rt_num": rt_num,
        "rw_num": rw_num,
        "sub_district_id": sub_district_id,
        "urban_village_id": urban_village_id,
        "created_at": created_at.toString(),
        "accepted_at": accepted_at.toString(),
        "rejected_at": rejected_at.toString()
      }
    };
  }
}
