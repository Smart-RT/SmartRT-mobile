import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/models/user/user.dart';

class EventTaskDetail {
  int id = -1;
  int user_id = -1;
  int task_id = -1;
  int status = 0;
  int created_by = -1;
  String? rating_avg;
  int rating_ctr = 0;
  DateTime created_at = DateTime.now();
  User? dataUser;
  String? notes;
  EventTask? dataTask;

  EventTaskDetail.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['user_id'] != null) {
      user_id = int.parse(data['user_id'].toString());
    }
    if (data['task_id'] != null) {
      task_id = int.parse(data['task_id'].toString());
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['created_by'] != null) {
      created_by = int.parse(data['created_by'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['dataUser'] != null) {
      dataUser = User.fromData(data['dataUser']);
    }
    if (data['rating_avg'] != null) {
      rating_avg = data['rating_avg'].toString();
    }
    if (data['rating_ctr'] != null) {
      rating_ctr = int.parse(data['rating_ctr'].toString());
    }
    if (data['notes'] != null) {
      notes = data['notes'].toString();
    }
    if (data['dataTask'] != null) {
      dataTask = EventTask.fromData(data['dataTask']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": user_id,
      "task_id": task_id,
      "status": status,
      "created_by": created_by,
      "created_at": created_at,
      "dataUser": dataUser,
      "rating_avg": rating_avg,
      "rating_ctr": rating_ctr,
      "notes": notes,
      "dataTask": dataTask,
    };
  }
}
