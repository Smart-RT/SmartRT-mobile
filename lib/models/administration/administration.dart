import 'package:smart_rt/models/administration/administration_type.dart';
import 'package:smart_rt/models/user/user.dart';

class Administration {
  int id = -1;
  AdministrationType? administration_type;
  int area_id = -1;
  int creator_id = -1;
  String? creator_fullname;
  DateTime? creator_borndate;
  String? creator_bornplace;
  String? creator_gender;
  String? creator_religion;
  String? creator_wedding_status;
  String? creator_ktp_img;
  String? creator_ktp_num;
  String? creator_kk_img;
  String? creator_kk_num;
  String? creator_job;
  String? creator_nationality;
  String? creator_address;
  String? data_rt_num;
  String? data_rw_num;
  int? data_kelurahan_id;
  String? data_kelurahan_name;
  int? data_kecamatan_id;
  String? data_kecamatan_name;
  String? data_letter_num;
  int? confirmater_id;
  String? confirmater_fullname;
  String? confirmater_sign_img;
  int? confirmation_status;
  DateTime? confirmation_at;
  String? confirmation_rejected_reason;
  DateTime created_at = DateTime.now();
  DateTime? creator_additional_datetime;
  String? creator_age;
  String? creator_notes;
  String? creator_anak_ke;
  String? creator_dad_name;
  String? creator_dad_bornplace;
  DateTime? creator_dad_borndate;
  String? creator_dad_religion;
  String? creator_dad_job;
  String? creator_dad_address;
  String? creator_dad_ktp_num;
  String? creator_dad_ktp_img;
  String? creator_mom_name;
  String? creator_mom_bornplace;
  DateTime? creator_mom_borndate;
  String? creator_mom_religion;
  String? creator_mom_job;
  String? creator_mom_address;
  String? creator_mom_ktp_num;
  String? creator_mom_ktp_img;
  User? data_creator;
  String? creator_relation_with_parent;

  Administration.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['administration_type'] != null) {
      administration_type =
          AdministrationType.fromData(data['administration_type']);
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['creator_id'] != null) {
      creator_id = int.parse(data['creator_id'].toString());
    }
    if (data['creator_fullname'] != null) {
      creator_fullname = data['creator_fullname'];
    }
    if (data['creator_borndate'] != null) {
      creator_borndate = DateTime.parse(data['creator_borndate'].toString());
    }
    if (data['creator_bornplace'] != null) {
      creator_bornplace = data['creator_bornplace'];
    }
    if (data['creator_gender'] != null) {
      creator_gender = data['creator_gender'];
    }
    if (data['creator_religion'] != null) {
      creator_religion = data['creator_religion'];
    }
    if (data['creator_wedding_status'] != null) {
      creator_wedding_status = data['creator_wedding_status'];
    }
    if (data['creator_ktp_img'] != null) {
      creator_ktp_img = data['creator_ktp_img'];
    }
    if (data['creator_ktp_num'] != null) {
      creator_ktp_num = data['creator_ktp_num'];
    }
    if (data['creator_kk_img'] != null) {
      creator_kk_img = data['creator_kk_img'];
    }
    if (data['creator_kk_num'] != null) {
      creator_kk_num = data['creator_kk_num'];
    }
    if (data['creator_job'] != null) {
      creator_job = data['creator_job'];
    }
    if (data['creator_nationality'] != null) {
      creator_nationality = data['creator_nationality'];
    }
    if (data['creator_address'] != null) {
      creator_address = data['creator_address'];
    }
    if (data['data_rt_num'] != null) {
      data_rt_num = data['data_rt_num'];
    }
    if (data['data_rw_num'] != null) {
      data_rw_num = data['data_rw_num'];
    }
    if (data['data_kelurahan_id'] != null) {
      data_kelurahan_id = int.parse(data['data_kelurahan_id'].toString());
    }
    if (data['data_kelurahan_name'] != null) {
      data_kelurahan_name = data['data_kelurahan_name'];
    }
    if (data['data_kecamatan_id'] != null) {
      data_kecamatan_id = int.parse(data['data_kecamatan_id'].toString());
    }
    if (data['data_kecamatan_name'] != null) {
      data_kecamatan_name = data['data_kecamatan_name'];
    }
    if (data['data_letter_num'] != null) {
      data_letter_num = data['data_letter_num'];
    }
    if (data['confirmater_id'] != null) {
      confirmater_id = int.parse(data['confirmater_id'].toString());
    }
    if (data['confirmater_fullname'] != null) {
      confirmater_fullname = data['confirmater_fullname'];
    }
    if (data['confirmater_sign_img'] != null) {
      confirmater_sign_img = data['confirmater_sign_img'];
    }
    if (data['confirmation_status'] != null) {
      confirmation_status = int.parse(data['confirmation_status'].toString());
    }
    if (data['confirmation_at'] != null) {
      confirmation_at = DateTime.parse(data['confirmation_at'].toString());
    }
    if (data['confirmation_rejected_reason'] != null) {
      confirmation_rejected_reason = data['confirmation_rejected_reason'];
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['creator_additional_datetime'] != null) {
      creator_additional_datetime =
          DateTime.parse(data['creator_additional_datetime'].toString());
    }
    if (data['creator_age'] != null) {
      creator_age = data['creator_age'].toString();
    }
    if (data['creator_notes'] != null) {
      creator_notes = data['creator_notes'].toString();
    }
    if (data['creator_anak_ke'] != null) {
      creator_anak_ke = data['creator_anak_ke'].toString();
    }
    if (data['creator_dad_name'] != null) {
      creator_dad_name = data['creator_dad_name'].toString();
    }
    if (data['creator_dad_bornplace'] != null) {
      creator_dad_bornplace = data['creator_dad_bornplace'].toString();
    }
    if (data['creator_dad_borndate'] != null) {
      creator_dad_borndate =
          DateTime.parse(data['creator_dad_borndate'].toString());
    }
    if (data['creator_dad_religion'] != null) {
      creator_dad_religion = data['creator_dad_religion'].toString();
    }
    if (data['creator_dad_job'] != null) {
      creator_dad_job = data['creator_dad_job'].toString();
    }
    if (data['creator_dad_address'] != null) {
      creator_dad_address = data['creator_dad_address'].toString();
    }
    if (data['creator_dad_ktp_num'] != null) {
      creator_dad_ktp_num = data['creator_dad_ktp_num'].toString();
    }
    if (data['creator_dad_ktp_img'] != null) {
      creator_dad_ktp_img = data['creator_dad_ktp_img'].toString();
    }
    if (data['creator_mom_name'] != null) {
      creator_mom_name = data['creator_mom_name'].toString();
    }
    if (data['creator_mom_bornplace'] != null) {
      creator_mom_bornplace = data['creator_mom_bornplace'].toString();
    }
    if (data['creator_mom_borndate'] != null) {
      creator_mom_borndate =
          DateTime.parse(data['creator_mom_borndate'].toString());
    }
    if (data['creator_mom_religion'] != null) {
      creator_mom_religion = data['creator_mom_religion'].toString();
    }
    if (data['creator_mom_job'] != null) {
      creator_mom_job = data['creator_mom_job'].toString();
    }
    if (data['creator_mom_address'] != null) {
      creator_mom_address = data['creator_mom_address'].toString();
    }
    if (data['creator_mom_ktp_num'] != null) {
      creator_mom_ktp_num = data['creator_mom_ktp_num'].toString();
    }
    if (data['creator_mom_ktp_img'] != null) {
      creator_mom_ktp_img = data['creator_mom_ktp_img'].toString();
    }
    if (data['creator_relation_with_parent'] != null) {
      creator_relation_with_parent =
          data['creator_relation_with_parent'].toString();
    }
    if (data['data_creator'] != null) {
      data_creator = User.fromData(data['data_creator']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "administration_type": administration_type.toString(),
      "area_id": area_id.toString(),
      "creator_id": creator_id.toString(),
      "creator_fullname": creator_fullname.toString(),
      "creator_borndate": creator_borndate.toString(),
      "creator_bornplace": creator_bornplace.toString(),
      "creator_gender": creator_gender.toString(),
      "creator_religion": creator_religion.toString(),
      "creator_wedding_status": creator_wedding_status.toString(),
      "creator_ktp_img": creator_ktp_img.toString(),
      "creator_ktp_num": creator_ktp_num.toString(),
      "creator_kk_img": creator_kk_img.toString(),
      "creator_kk_num": creator_kk_num.toString(),
      "creator_job": creator_job.toString(),
      "creator_nationality": creator_nationality.toString(),
      "creator_address": creator_address.toString(),
      "data_rt_num": data_rt_num.toString(),
      "data_rw_num": data_rw_num.toString(),
      "data_kelurahan_id": data_kelurahan_id.toString(),
      "data_kelurahan_name": data_kelurahan_name.toString(),
      "data_kecamatan_id": data_kecamatan_id.toString(),
      "data_kecamatan_name": data_kecamatan_name.toString(),
      "data_letter_num": data_letter_num.toString(),
      "confirmater_id": confirmater_id.toString(),
      "confirmater_fullname": confirmater_fullname.toString(),
      "confirmater_sign_img": confirmater_sign_img.toString(),
      "confirmation_status": confirmation_status.toString(),
      "confirmation_at": confirmation_at.toString(),
      "confirmation_rejected_reason": confirmation_rejected_reason.toString(),
      "created_at": created_at.toString(),
      "creator_additional_datetime": creator_additional_datetime.toString(),
      "creator_age": creator_age.toString(),
      "creator_notes": creator_notes.toString(),
      "creator_anak_ke": creator_anak_ke.toString(),
      "creator_dad_name": creator_dad_name.toString(),
      "creator_dad_bornplace": creator_dad_bornplace.toString(),
      "creator_dad_borndate": creator_dad_borndate.toString(),
      "creator_dad_religion": creator_dad_religion.toString(),
      "creator_dad_job": creator_dad_job.toString(),
      "creator_dad_address": creator_dad_address.toString(),
      "creator_dad_ktp_num": creator_dad_ktp_num.toString(),
      "creator_dad_ktp_img": creator_dad_ktp_img.toString(),
      "creator_mom_name": creator_mom_name.toString(),
      "creator_mom_bornplace": creator_mom_bornplace.toString(),
      "creator_mom_borndate": creator_mom_borndate.toString(),
      "creator_mom_religion": creator_mom_religion.toString(),
      "creator_mom_job": creator_mom_job.toString(),
      "creator_mom_address": creator_mom_address.toString(),
      "creator_mom_ktp_num": creator_mom_ktp_num.toString(),
      "creator_mom_ktp_img": creator_mom_ktp_img.toString(),
      "creator_relation_with_parent": creator_relation_with_parent.toString(),
      "data_creator": data_creator,
    };
  }
}
