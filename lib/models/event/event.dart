import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/models/user/user.dart';

class Event {
  int id = -1;
  String title = '';
  String detail = '';
  int area_id = -1;
  int is_dividing_up_task = 0;
  DateTime event_date_start_at = DateTime.now();
  DateTime event_date_end_at = DateTime.now();
  DateTime created_at = DateTime.now();
  User? created_by;
  int status = 0;
  List<EventTask> tasks = [];

  Event.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['title'] != null) {
      title = data['title'].toString();
    }
    if (data['detail'] != null) {
      detail = data['detail'].toString();
    }
    if (data['area_id'] != null) {
      area_id = int.parse(data['area_id'].toString());
    }
    if (data['is_dividing_up_task'] != null) {
      is_dividing_up_task = int.parse(data['is_dividing_up_task'].toString());
    }
    if (data['event_date_start_at'] != null) {
      event_date_start_at =
          DateTime.parse(data['event_date_start_at'].toString());
    }
    if (data['event_date_end_at'] != null) {
      event_date_end_at = DateTime.parse(data['event_date_end_at'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['created_by'] != null) {
      created_by = User.fromData(data['created_by']);
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['tasks'] != null) {
      tasks.addAll((data['tasks']).map<EventTask>((request) {
        return EventTask.fromData(request);
      }));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "title": title.toString(),
      "detail": detail.toString(),
      "area_id": area_id.toString(),
      "is_dividing_up_task": is_dividing_up_task.toString(),
      "event_date_start_at": event_date_start_at.toString(),
      "event_date_end_at": event_date_end_at.toString(),
      "created_at": created_at.toString(),
      "created_by": created_by,
      "status": status.toString(),
      "tasks": tasks,
    };
  }
}
