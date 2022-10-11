enum Role {
  Admin,
  Guest,
  Warga,
  Bendahara,
  Sekretaris,
  Wakil_RT,
  Ketua_RT,
  None
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
  DateTime born_date = DateTime.now();
  int? religion;
  bool? is_married;
  String? profession;
  String phone = "";
  Role user_role = Role.None;
  int? area_id;
  bool is_lottery_club_member = false;
  int? task_rating;
  String? sign_img;
  String? photo_profile_img;
  bool is_health = true;
  int total_serving_as_neighbourhood_head = 0;
  String refresh_token = "";
  DateTime created_at = DateTime.now();
  int? created_by;

  User.fromData(Map<String, dynamic> data) {
    Map<String, dynamic> userData = data['user'];
    id = userData['id'];
    nik = userData['nik'];
    kk_num = userData['kk_num'];
    full_name = userData['full_name'];
    address = userData['address'];
    rt_num = userData['rt_num'];
    sub_district_id = userData['sub_district_id'];
    urban_village = userData['urban_village'];
    rw_num = userData['rw_num'];
    gender = userData['gender'];
    born_at = userData['born_at'];
    
    if (userData['born_date'] != null) {
      born_date = DateTime.parse(userData['born_date']);
    }

    religion = userData['religion'];
    is_married = userData['is_married'] == 1 ? true : false;
    profession = userData['profession'];
    phone = userData['phone'];

    user_role = roleFromId(userData['user_role']);

    area_id = userData['area_id'];
    is_lottery_club_member =
        userData['is_lottery_club_member'] == 1 ? true : false;
    task_rating = userData['task_rating'];
    sign_img = userData['sign_img'];
    photo_profile_img = userData['photo_profile_img'];
    is_health = userData['is_health'] == 1 ? true : false;
    total_serving_as_neighbourhood_head =
        userData['total_serving_as_neighbourhood_head'];

    refresh_token = data['refreshToken'];

    if (userData['created_at'] != null) {
      created_at = DateTime.parse(userData['created_at']);
    }
    created_by = userData['created_by'];
  }

  Role roleFromId(int id) {
    try {
      return Role.values.elementAt(id - 1);
    } catch (e) {
      return Role.None;
    }
  }
}
