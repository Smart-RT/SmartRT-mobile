class UserHealthReport {
  int id = -1;
  int reported_id_for = -1; //user_id
  int area_reported_id = -1;
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
    area_reported_id = int.parse(data['area_reported_id'].toString());
    disease_level = int.parse(data['disease_level'].toString());
    disease_notes = data['disease_notes'].toString();
    created_by = int.parse(data['created_by'].toString());
    created_at = DateTime.parse(data['created_at'].toString());
    confirmation_by = int.parse(data['confirmation_by'].toString());
    confirmation_at = DateTime.parse(data['confirmation_at'].toString());
    confirmation_status = int.parse(data['confirmation_status'].toString());
    healed_at = DateTime.parse(data['healed_at'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "reported_id_for": reported_id_for.toString(),
      "area_reported_id": area_reported_id.toString(),
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
