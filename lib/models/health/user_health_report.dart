import 'package:smart_rt/models/health/disease_group.dart';
import 'package:smart_rt/models/user.dart';

class UserHealthReport {
  int id = -1;
  int reported_id_for = -1; //user_id
  User? reported_data_user;
  User? created_by_data_user;
  User? confirmation_by_data_user;
  int area_reported_id = -1;
  DiseaseGroup? disease_group;
  int disease_level = 0;
  String disease_notes = '';
  int created_by = -1;
  DateTime created_at = DateTime.now();
  int? confirmation_by;
  DateTime? confirmation_at;
  int? confirmation_status;
  DateTime? healed_at;

  UserHealthReport.fromData(Map<String, dynamic> data) {
    id = int.parse(data['id'].toString());
    reported_id_for = int.parse(data['reported_id_for'].toString());
    if (data['reported_data_user'] != null) {
      reported_data_user = User.fromData(data['reported_data_user']);
    }
    if (data['created_by_data_user'] != null) {
      created_by_data_user = User.fromData(data['created_by_data_user']);
    }
    if (data['confirmation_by_data_user'] != null) {
      confirmation_by_data_user =
          User.fromData(data['confirmation_by_data_user']);
    }
    area_reported_id = int.parse(data['area_reported_id'].toString());
    if (data['disease_group_id'] != null) {
      disease_group = DiseaseGroup.fromData(data['disease_group_id']);
    }
    disease_level = int.parse(data['disease_level'].toString());
    disease_notes = data['disease_notes'].toString();
    created_by = int.parse(data['created_by'].toString());
    created_at = DateTime.parse(data['created_at'].toString());
    if (data['confirmation_by'] != null) {
      confirmation_by = int.parse(data['confirmation_by'].toString());
    }
    if (data['confirmation_at'] != null) {
      confirmation_at = DateTime.parse(data['confirmation_at'].toString());
    }
    if (data['confirmation_status'] != null) {
      confirmation_status = int.parse(data['confirmation_status'].toString());
    }
    if (data['healed_at'] != null) {
      healed_at = DateTime.parse(data['healed_at'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "reported_id_for": reported_id_for.toString(),
      "reported_data_user": reported_data_user,
      "created_by_data_user": created_by_data_user,
      "confirmation_by_data_user": confirmation_by_data_user,
      "area_reported_id": area_reported_id.toString(),
      "disease_group": disease_group,
      "disease_level": disease_level.toString(),
      "disease_notes": disease_notes.toString(),
      "created_by": created_by.toString(),
      "created_at": created_at.toString(),
      "confirmation_by": confirmation_by.toString(),
      "confirmation_at": confirmation_at.toString(),
      "confirmation_status": confirmation_status.toString(),
      "healed_at": healed_at.toString(),
    };
  }
}
