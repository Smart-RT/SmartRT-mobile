class DataPatientGroupingByDiseaseGroup {
  String? disease_group_name;
  int total_patient = 0;

  DataPatientGroupingByDiseaseGroup.fromData(Map<String, dynamic> data) {
    disease_group_name = data['disease_group'];
    total_patient = int.parse(data['total_patient'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "diseaseGroup": disease_group_name,
      "total_patient": total_patient.toString(),
    };
  }
}
