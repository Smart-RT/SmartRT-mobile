import 'package:smart_rt/models/user/user.dart';

class Candidate {
  String nama = '';
  String alamat = '';
  int totalVote = 0;

  Candidate.fromData(Map<String, dynamic> data) {
    nama = data['nama'].toString();
    alamat = data['alamat'].toString();
    totalVote = data['total'];
  }

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "alamat": alamat,
      "totalVote": totalVote,
    };
  }
}
