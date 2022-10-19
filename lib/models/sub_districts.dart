enum WilayahSurabaya{
  Pusat,
  Timur,
  Barat,
  Utara,
  Selatan,
  Lainnya
}

class SubDistricts {
  int id = -1;
  String name = "";
  WilayahSurabaya wilayah = WilayahSurabaya.Lainnya;

  SubDistricts.fromData(Map<String, dynamic> data) {
    Map<String, dynamic> subDistrictData = data['sub_districts'];
    id = subDistrictData['id'];
    name = subDistrictData['name'];
    wilayah = wilayahFromId(subDistrictData['wilayah']);
  }

  Map<String, dynamic> toJson() {
    return {
      "subDistricts": {
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
