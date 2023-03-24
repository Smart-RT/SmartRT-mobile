import 'package:smart_rt/models/area/sub_district.dart';
import 'package:smart_rt/models/area/urban_village.dart';
import 'package:smart_rt/models/lottery_club/lottery_club.dart';
import 'package:smart_rt/models/user/user.dart';

class Area {
  int id = -1;
  String area_code = 'xxx';
  int rt_num = 0;
  int rw_num = 0;
  int sub_district_id = 0;
  int urban_village_id = 0;
  int is_lottery_club_period_active = 0;
  LotteryClub? lottery_club_id;
  User? ketua_id;
  User? wakil_ketua_id;
  String wakil_ketua_code = 'XXX';
  User? sekretaris_id;
  String sekretaris_code = 'XXX';
  User? bendahara_id;
  String bendahara_code = 'XXX';
  DateTime tenure_end_at = DateTime.now().add(Duration(days: 1460));
  SubDistrict? data_kecamatan;
  UrbanVillage? data_kelurahan;

  Area.fromData(Map<String, dynamic> data) {
    id = data['id'];
    area_code = data['area_code'];
    rt_num = data['rt_num'];
    rw_num = data['rw_num'];
    sub_district_id = data['sub_district_id'];
    urban_village_id = data['urban_village_id'];
    is_lottery_club_period_active = data['is_lottery_club_period_active'];
    if (data['lottery_club_id'] != null) {
      lottery_club_id = LotteryClub.fromData(data['lottery_club_id']);
    }
    if (data['ketua_id'] != null) {
      ketua_id = User.fromData(data['ketua_id']);
    }
    if (data['wakil_ketua_id'] != null) {
      wakil_ketua_id = User.fromData(data['wakil_ketua_id']);
    }
    wakil_ketua_code = data['wakil_ketua_code'];
    if (data['sekretaris_id'] != null) {
      sekretaris_id = User.fromData(data['sekretaris_id']);
    }
    sekretaris_code = data['sekretaris_code'];
    if (data['bendahara_id'] != null) {
      bendahara_id = User.fromData(data['bendahara_id']);
    }
    bendahara_code = data['bendahara_code'];
    tenure_end_at = DateTime.parse(data['tenure_end_at']);
    if (data['data_kecamatan'] != null) {
      data_kecamatan = SubDistrict.fromData(data['data_kecamatan']);
    }
    if (data['data_kelurahan'] != null) {
      data_kelurahan = UrbanVillage.fromData(data['data_kelurahan']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "area_code": area_code,
      "rt_num": rt_num,
      "rw_num": rw_num,
      "sub_district_id": sub_district_id,
      "urban_village_id": urban_village_id,
      "is_lottery_club_period_active": is_lottery_club_period_active,
      "lottery_club_id":
          lottery_club_id == null ? lottery_club_id : lottery_club_id!.toJson(),
      "ketua_id": ketua_id!.toJson(),
      "wakil_ketua_id":
          wakil_ketua_id == null ? wakil_ketua_id : wakil_ketua_id!.toJson(),
      "wakil_ketua_code": wakil_ketua_code,
      "sekretaris_id":
          sekretaris_id == null ? sekretaris_id : sekretaris_id!.toJson(),
      "sekretaris_code": sekretaris_code,
      "bendahara_id":
          bendahara_id == null ? bendahara_id : bendahara_id!.toJson(),
      "bendahara_code": bendahara_code,
      "tenure_end_at": tenure_end_at.toString(),
      "data_kecamatan": data_kecamatan,
      "data_kelurahan": data_kelurahan,
    };
  }
}
