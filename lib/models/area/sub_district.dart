enum WilayahSurabaya { Pusat, Timur, Barat, Utara, Selatan, Lainnya }

class SubDistrict {
  int id = -1;
  String name = "";
  WilayahSurabaya wilayah = WilayahSurabaya.Lainnya;
  int total_population = 0;

  SubDistrict.fromData(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    wilayah = wilayahFromId(data['wilayah']);
    total_population = int.parse(data['total_population'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "wilayah": WilayahSurabaya.values.indexOf(wilayah),
      "total_population": total_population,
    };
  }

  WilayahSurabaya wilayahFromId(int id) {
    try {
      return WilayahSurabaya.values.elementAt(id);
    } catch (e) {
      return WilayahSurabaya.Lainnya;
    }
  }
}
