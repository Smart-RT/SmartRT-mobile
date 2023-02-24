import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/health/user_health_report.dart';

class StatusHealthTaskHelp {
  int id = 0;
  String name = '';
  Color color = smartRTPrimaryColor;

  StatusHealthTaskHelp.fromData(int status) {
    id = status;
    if (status == -2) {
      name = 'Permintaan Dibatalkan';
      color = smartRTStatusRedColor;
    } else if (status == -1) {
      name = 'Permintaan Ditolak';
      color = smartRTStatusRedColor;
    } else if (status == 0) {
      name = 'Menunggu Konfirmasi';
      color = smartRTStatusYellowColor;
    } else if (status == 1) {
      name = 'Permintaan Diproses';
      color = smartRTStatusYellowColor;
    } else if (status == 2) {
      name = 'Selesai';
      color = smartRTStatusGreenColor;
    }
  }

  Map<String, dynamic> toJson() {
    return {"id": id.toString(), "name": name.toString(), "color": color};
  }
}

class HealthTaskHelp {
  int id = -1;
  int area_id = -1;
  UserHealthReport? user_health_report_id;
  int urgent_level = 1;
  String notes = '';
  int help_type = 1;
  StatusHealthTaskHelp? status;
  DateTime created_at = DateTime.now();
  int created_by = -1;
  DateTime? confirmation_at;
  int? confirmation_by;
  String? rejected_reason;
  DateTime? solved_at;
  int? solved_by;

  HealthTaskHelp.fromData(Map<String, dynamic> data) {
    id = int.parse(data['id'].toString());
    area_id = int.parse(data['area_id'].toString());
    if (data['user_health_report_id'] != null) {
      user_health_report_id =
          UserHealthReport.fromData(data['user_health_report_id']);
    }
    urgent_level = int.parse(data['urgent_level'].toString());
    notes = data['notes'].toString();
    help_type = int.parse(data['help_type'].toString());
    status = StatusHealthTaskHelp.fromData(data['status']);
    created_at = DateTime.parse(data['created_at'].toString());
    created_by = int.parse(data['created_by'].toString());
    if (data['confirmation_at'] != null) {
      confirmation_at = DateTime.parse(data['confirmation_at'].toString());
    }
    if (data['confirmation_by'] != null) {
      confirmation_by = int.parse(data['confirmation_by'].toString());
    }
    if (data['rejected_reason'] != null) {
      rejected_reason = data['rejected_reason'].toString();
    }
    if (data['solved_at'] != null) {
      solved_at = DateTime.parse(data['solved_at'].toString());
    }
    if (data['solved_by'] != null) {
      solved_by = int.parse(data['solved_by'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id.toString(),
      "area_id": area_id.toString(),
      "user_health_report_id": user_health_report_id,
      "urgent_level": urgent_level.toString(),
      "notes": notes.toString(),
      "help_type": help_type.toString(),
      "status": status,
      "created_at": created_at.toString(),
      "created_by": created_by.toString(),
      "confirmation_at": confirmation_at.toString(),
      "confirmation_by": confirmation_by.toString(),
      "rejected_reason": rejected_reason.toString(),
      "solved_at": solved_at.toString(),
      "solved_by": solved_by.toString(),
    };
  }
}
