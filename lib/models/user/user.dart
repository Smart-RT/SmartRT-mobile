import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/models/area/sub_district.dart';
import 'package:smart_rt/models/area/urban_village.dart';
import 'package:smart_rt/models/user/user_role_request.dart';

enum Role {
  Admin, //0
  Guest, //1
  Warga, //2
  Bendahara, //3
  Sekretaris, //4
  Wakil_RT, //5
  Ketua_RT, //6
  None //7
}

class User {
  int id = -1;
  String? nik;
  String? kk_num;
  String full_name = "";
  String? address;
  int? rt_num;
  int? sub_district_id;
  int? urban_village;
  int? rw_num;
  String gender = "Laki-Laki";
  String? born_at;
  DateTime? born_date = DateTime.now();
  String? religion;
  String? status_perkawinan;
  String? profession;
  String phone = "";
  Role user_role = Role.None;
  Area? area;
  bool is_lottery_club_member = false;
  int? task_rating;
  String? sign_img;
  String? photo_profile_img;
  int is_health = 1;
  int? total_serving_as_neighbourhood_head = 0;
  String token = "";
  String refresh_token = "";
  DateTime created_at = DateTime.now();
  int? created_by;
  List<UserRoleRequest> user_role_requests = [];
  SubDistrict? data_sub_district;
  UrbanVillage? data_urban_village;
  String? nationality;

  User.fromData(Map<String, dynamic> data) {
    Map<String, dynamic> userData = data;
    if (data['user'] != null) {
      userData = data['user'];
      token = data['token'];
      refresh_token = data['refreshToken'];
    }

    id = userData['id'];
    nik = userData['nik'];
    kk_num = userData['kk_num'];
    full_name = userData['full_name'];
    address = userData['address'];
    if (userData['rt_num'] != null) {
      rt_num = userData['rt_num'];
    }
    if (userData['sub_district_id'] != null) {
      sub_district_id = userData['sub_district_id'];
    }
    if (userData['urban_village'] != null) {
      urban_village = userData['urban_village'];
    }
    if (userData['rw_num'] != null) {
      rw_num = userData['rw_num'];
    }
    gender = userData['gender'];
    if (userData['born_at'] != null) {
      born_at = userData['born_at'];
    }

    if (userData['born_date'] != null) {
      born_date = DateTime.parse(userData['born_date']);
    }
    if (userData['religion'] != null) {
      religion = userData['religion'];
    }
    if (userData['status_perkawinan'] != null) {
      status_perkawinan = userData['status_perkawinan'];
    }
    if (userData['religion'] != null) {
      profession = userData['profession'];
    }

    phone = userData['phone'];

    user_role = roleFromId(userData['user_role']);

    if (userData['area'] != null) {
      area = Area.fromData(userData['area']);
    }
    if (userData['is_lottery_club_member'] != null) {
      is_lottery_club_member =
          userData['is_lottery_club_member'] == 1 ? true : false;
    }
    if (userData['task_rating'] != null) {
      task_rating = userData['task_rating'];
    }
    if (userData['sign_img'] != null) {
      sign_img = userData['sign_img'];
    }

    if (userData['nationality'] != null) {
      nationality = userData['nationality'];
    }

    photo_profile_img = userData['photo_profile_img'];
    is_health = int.parse(userData['is_health'].toString());
    total_serving_as_neighbourhood_head =
        userData['total_serving_as_neighbourhood_head'];

    if (userData['created_at'] != null) {
      created_at = DateTime.parse(userData['created_at']);
    }
    if (userData['created_by'] != null) {
      created_by = userData['created_by'];
    }

    if (userData['user_role_requests'] != null) {
      user_role_requests.clear();
      user_role_requests.addAll(
          userData['user_role_requests'].map<UserRoleRequest>((request) {
        return UserRoleRequest.fromData(request);
      }));
    }

    if (userData['data_urban_village'] != null) {
      data_urban_village =
          UrbanVillage.fromData(userData['data_urban_village']);
    }
    if (userData['data_sub_district'] != null) {
      data_sub_district = SubDistrict.fromData(userData['data_sub_district']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "user": {
        "id": id,
        "nik": nik,
        "kk_num": kk_num,
        "full_name": full_name,
        "address": address,
        "rt_num": rt_num,
        "sub_district_id": sub_district_id,
        "urban_village": urban_village,
        "rw_num": rw_num,
        "gender": gender,
        "born_at": born_at,
        "born_date": born_date.toString(),
        "religion": religion,
        "status_perkawinan": status_perkawinan,
        "profession": profession,
        "phone": phone,
        "user_role": Role.values.indexOf(user_role) + 1,
        "area": area == null ? area : area!.toJson(),
        "is_lottery_club_member": is_lottery_club_member ? 1 : 0,
        "task_rating": task_rating,
        "sign_img": sign_img,
        "photo_profile_img": photo_profile_img,
        "is_health": is_health.toString(),
        "total_serving_as_neighbourhood_head":
            total_serving_as_neighbourhood_head,
        "created_at": created_at.toString(),
        "created_by": created_by,
        "data_urban_village": data_urban_village,
        "data_sub_district": data_sub_district,
        "nationality": nationality,
      },
      "token": token,
      "refreshToken": refresh_token
    };
  }

  Role roleFromId(int id) {
    try {
      return Role.values.elementAt(id - 1);
    } catch (e) {
      return Role.None;
    }
  }

  String initialName() {
    // J
    String initName = '';
    if (full_name == '') {
      return '';
    } else if (full_name.contains(' ')) {
      List<String> nama = full_name.toUpperCase().split(' ');
      return '${nama[0][0]}${nama[1][0]}';
    } else if (full_name.length < 2) {
      return full_name.toUpperCase();
    } else {
      return '${full_name[0]}${full_name[1]}'.toUpperCase();
    }
  }
}
