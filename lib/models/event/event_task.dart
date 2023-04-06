import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/event/event_task_detail.dart';
import 'package:smart_rt/models/user/user.dart';

class EventTask {
  int id = -1;
  String title = '';
  String detail = '';
  int event_id = -1;
  int total_worker_needed = -1;
  int total_worker_now = -1;
  int is_general = -1;
  DateTime created_at = DateTime.now();
  int created_by = -1;
  int status = -1;
  List<EventTaskDetail> listPetugas = [];
  Event? dataEvent;

  EventTask.fromData(Map<String, dynamic> data) {
    if (data['id'] != null) {
      id = int.parse(data['id'].toString());
    }
    if (data['title'] != null) {
      title = data['title'].toString();
    }
    if (data['detail'] != null) {
      detail = data['detail'].toString();
    }
    if (data['event_id'] != null) {
      event_id = int.parse(data['event_id'].toString());
    }
    if (data['total_worker_needed'] != null) {
      total_worker_needed = int.parse(data['total_worker_needed'].toString());
    }
    if (data['total_worker_now'] != null) {
      total_worker_now = int.parse(data['total_worker_now'].toString());
    }
    if (data['is_general'] != null) {
      is_general = int.parse(data['is_general'].toString());
    }
    if (data['created_at'] != null) {
      created_at = DateTime.parse(data['created_at'].toString());
    }
    if (data['created_by'] != null) {
      created_by = int.parse(data['created_by'].toString());
    }
    if (data['status'] != null) {
      status = int.parse(data['status'].toString());
    }
    if (data['listPetugas'] != null) {
      listPetugas.addAll((data['listPetugas']).map<EventTaskDetail>((request) {
        return EventTaskDetail.fromData(request);
      }));
    }
    if (data['dataEvent'] != null) {
      dataEvent = Event.fromData(data['dataEvent']);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "title": title.toString(),
      "detail": detail.toString(),
      "event_id": event_id.toString(),
      "total_worker_needed": total_worker_needed.toString(),
      "total_worker_now": total_worker_now.toString(),
      "is_general": is_general.toString(),
      "created_at": created_at.toString(),
      "created_by": created_by.toString(),
      "status": status.toString(),
      "listPetugas": listPetugas,
      "dataEvent": dataEvent,
    };
  }
}
