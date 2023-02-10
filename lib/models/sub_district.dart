enum WilayahSurabaya { Pusat, Timur, Barat, Utara, Selatan, Lainnya }

class SubDistrict {
  int id = -1;
  String name = "";
  WilayahSurabaya wilayah = WilayahSurabaya.Lainnya;

  SubDistrict.fromData(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    wilayah = wilayahFromId(data['wilayah']);
  }

  Map<String, dynamic> toJson() {
    return {
      "subDistrict": {
        "id": id,
        "name": name,
        "wilayah": WilayahSurabaya.values.indexOf(wilayah),
      }
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
