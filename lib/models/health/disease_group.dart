class DiseaseGroup {
  int id = -1;
  String name = '';
  String? example_notes;

  DiseaseGroup.fromData(Map<String, dynamic> data) {
    id = int.parse(data['id'].toString());
    name = data['name'];
    if (data['example_notes'] != null) {
      example_notes = data['example_notes'];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "name": name.toString(),
      "example_notes": example_notes.toString(),
    };
  }
}
