import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/event/event_task_detail_rating.dart';
import 'package:smart_rt/utilities/net_util.dart';

class EventProvider extends ChangeNotifier {
  List<Event> dataListEvent = [];
  List<Event> get event => dataListEvent;
  set event(List<Event> value) {
    dataListEvent = value;
  }

  List<EventTaskDetailRating> dataListRating = [];
  List<EventTaskDetailRating> get rating => dataListRating;
  set rating(List<EventTaskDetailRating> value) {
    dataListRating = value;
  }

  void updateListener() => notifyListeners();

  Future<void> getDataListEvent() async {
    try {
      List<Event> listEvent = <Event>[];
      Response<dynamic> resp = await NetUtil().dioClient.get('/event/get/all');
      listEvent.addAll((resp.data).map<Event>((request) {
        return Event.fromData(request);
      }));
      dataListEvent = listEvent;
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> deleteEvent({
    required int idEvent,
  }) async {
    try {
      await NetUtil().dioClient.patch('/event/delete', data: {
        "event_id": idEvent,
      });
      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> updateEvent({
    required int idEvent,
    required String title,
    required String detail,
  }) async {
    try {
      await NetUtil().dioClient.patch('/event/update',
          data: {"title": title, "detail": detail, "event_id": idEvent});

      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> createEvent({
    required String title,
    required String detail,
    required String dateStart,
    required String dateEnd,
  }) async {
    try {
      await NetUtil().dioClient.post('/event/add', data: {
        "title": title,
        "detail": detail,
        "datetime_start": dateStart,
        "datetime_end": dateEnd
      });

      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> createTask({
    required int idEvent,
    required String title,
    required String detail,
    required String jumlahWorker,
    required String isGeneral,
  }) async {
    try {
      await NetUtil().dioClient.post('/event/task/add', data: {
        "title": title,
        "detail": detail,
        "event_id": idEvent,
        "total_worker_needed": jumlahWorker,
        "is_general": isGeneral,
      });

      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> takeTask({
    required int idTask,
  }) async {
    try {
      await NetUtil()
          .dioClient
          .post('/event/task/detail/take-task', data: {"task_id": idTask});

      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> confirmationTaskDetail(
      {required int idTaskDetail, required int status}) async {
    try {
      await NetUtil().dioClient.patch('/event/task/detail/confirmation',
          data: {"task_detail_id": idTaskDetail, "status": status});

      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> giveTask(
      {required int idTask, required List<int> listUserID}) async {
    try {
      await NetUtil().dioClient.post('/event/task/detail/give-task',
          data: {"list_user_id": listUserID, "task_id": idTask});

      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> kickOutWorker(
      {required int idTaskDetail, required String alasan}) async {
    try {
      await NetUtil().dioClient.patch('/event/task/detail/kick-out',
          data: {"task_detail_id": idTaskDetail, "alasan": alasan});

      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> getRating({
    required int idTaskDetail,
  }) async {
    try {
      dataListRating.clear();
      List<EventTaskDetailRating> listRating = <EventTaskDetailRating>[];
      Response<dynamic> resp = await NetUtil().dioClient.get(
          '/event/task/detail/rating/get/id-event-task-detail/$idTaskDetail');
      listRating.addAll((resp.data).map<EventTaskDetailRating>((request) {
        return EventTaskDetailRating.fromData(request);
      }));
      dataListRating = listRating;
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  Future<void> giveRating({
    required int idTaskDetail,
    required double rating,
    required String review,
  }) async {
    try {
      await NetUtil().dioClient.post('/event/task/detail/rating/add', data: {
        "rating": rating,
        "review": review,
        "task_detail_id": idTaskDetail
      });
      getRating(idTaskDetail: idTaskDetail);
      getDataListEvent();
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }
}
