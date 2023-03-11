class AdministrationType {
  int id = -1;
  String name = '';

  AdministrationType.fromData(Map<String, dynamic> data) {
    id = int.parse(data['id'].toString());
    name = data['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": name.toString(),
    };
  }
}
