import 'package:smart_rt/models/event/event_task_detail.dart';
import 'package:smart_rt/models/user/user.dart';

class EventTaskDetailRating {
  int id = -1;
  int rating = 0;
  String? review;
  int rated_for = -1;
  int event_task_detail_id = -1;
  User? created_by;
  DateTime created_at = DateTime.now();

  EventTaskDetailRating.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['rating'] != null) {
      rating = int.parse(data['rating'].toString());
    }
    if (data['review'] != null) {
      review = data['review'].toString();
    }
    if (data['rated_for'] != null) {
      rated_for = int.parse(data['rated_for'].toString());
    }
    if (data['event_task_detail_id'] != null) {
      event_task_detail_id = int.parse(data['event_task_detail_id'].toString());
    }
    if (data['created_by'] != null) {
      created_by = User.fromData(data['created_by']);
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "rating": rating.toString(),
      "review": review.toString(),
      "rated_for": rated_for.toString(),
      "event_task_detail_id": event_task_detail_id.toString(),
      "created_by": created_by.toString(),
      "created_at": created_at.toString(),
    };
  }
}
