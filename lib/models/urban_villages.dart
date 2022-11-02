class UrbanVillages {
  int id = -1;
  String name = "";
  int idKecamatan = -1;

  UrbanVillages.fromData(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    idKecamatan = data['kecamatan']['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "urbanVillages": {
        "id": id,
        "name": name,
        "idKecamatan": idKecamatan,
      }
    };
  }
}
