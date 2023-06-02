class UrbanVillage {
  int id = -1;
  String name = "";
  int idKecamatan = -1;
  int total_population = 0;

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
    if (data['total_population'] != null) {
      total_population = int.parse(data['total_population'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "idKecamatan": idKecamatan,
      "total_population": total_population,
    };
  }
}
