import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/area.dart';
import 'package:smart_rt/models/user_role_request.dart';

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
  int? kk_num;
  String full_name = "";
  String? address;
  int? rt_num;
  int? sub_district_id;
  int? urban_village;
  int? rw_num;
  String gender = "Laki-Laki";
  String? born_at;
  DateTime? born_date = DateTime.now();
  int? religion;
  bool? is_married;
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
  List<UserRoleRequests> user_role_requests = [];

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
    if (userData['is_married'] != null) {
      is_married = userData['is_married'] == 1 ? true : false;
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
          userData['user_role_requests'].map<UserRoleRequests>((request) {
        return UserRoleRequests.fromData(request);
      }));
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
        "is_married": (is_married ?? false) ? 1 : 0,
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
        "created_by": created_by
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
