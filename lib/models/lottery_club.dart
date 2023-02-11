import 'package:smart_rt/models/area.dart';
import 'package:smart_rt/models/user.dart';

class LotteryClub {
  int id = -1;
  int? area_id;
  int last_period = 0;
  int kas_amount = 0;
  DateTime created_at = DateTime.now();
  int? created_by;

  LotteryClub.fromData(Map<String, dynamic> data) {
    id = data['id'];
    area_id = data['area_id'];
    last_period = data['last_period'];
    kas_amount = data['kas_amount'];
    created_at = DateTime.parse(data['created_at']);
    created_by = data['created_by'];
  }

  Map<String, dynamic> toJson() {
    return {
      "LotteryClub": {
        "id": id.toString(),
        "area_id": area_id.toString(),
        "last_period": last_period.toString(),
        "kas_amount": kas_amount.toString(),
        "created_at": created_at.toString(),
        "created_by": created_by.toString(),
      }
    };
  }
}
