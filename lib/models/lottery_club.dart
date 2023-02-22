class LotteryClub {
  int id = -1;
  int? area_id;
  int last_period = 0;
  int kas_amount = 0;
  DateTime created_at = DateTime.now();
  int? created_by;

  LotteryClub.fromData(Map<String, dynamic> data) {
    id = int.parse(data['id'].toString());
    area_id = int.parse(data['area_id'].toString());
    last_period = int.parse(data['last_period'].toString());
    kas_amount = int.parse(data['kas_amount'].toString());
    created_at = DateTime.parse(data['created_at']);
    created_by = int.parse(data['created_by'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "area_id": area_id.toString(),
      "last_period": last_period.toString(),
      "kas_amount": kas_amount.toString(),
      "created_at": created_at.toString(),
      "created_by": created_by.toString(),
    };
  }
}
