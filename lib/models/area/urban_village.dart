class UrbanVillage {
  int id = -1;
  String name = "";
  int idKecamatan = -1;

  UrbanVillage.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    name = data['name'];
    if (data['kecamatan'] != null) {
      idKecamatan = int.parse(data['kecamatan']['id'].toString());
    } else if (data['idKecamatan'] != null) {
      idKecamatan = int.parse(data['idKecamatan'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "idKecamatan": idKecamatan,
    };
  }
}
