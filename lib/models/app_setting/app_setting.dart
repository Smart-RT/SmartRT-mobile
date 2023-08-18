class AppSetting {
  int id = -1;
  String about = "";
  String detail = "";

  AppSetting.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }

    if (data['about'] != null) {
      about = data['about'].toString();
    }

    if (data['detail'] != null) {
      detail = data['detail'].toString();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "about": about,
      "detail": detail,
    };
  }
}
