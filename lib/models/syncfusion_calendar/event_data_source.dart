import 'package:flutter/material.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Event {
  Event(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class HealthyDataSource extends CalendarDataSource {
  HealthyDataSource(List<HealthyCard> source) {
    appointments = source;
  }

  UserHealthReport getDataUserHealthReport(int index) {
    return appointments![index].dataUserHealthReport;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class HealthyCard {
  HealthyCard(this.eventName, this.from, this.to, this.background,
      this.isAllDay, this.dataUserHealthReport);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  UserHealthReport? dataUserHealthReport;
}
