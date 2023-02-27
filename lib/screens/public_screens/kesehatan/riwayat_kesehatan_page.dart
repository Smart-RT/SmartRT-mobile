import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:smart_rt/models/syncfusion_calendar/event_data_source.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RiwayatKesehatanArguments {
  String type;

  RiwayatKesehatanArguments({required this.type});
}

class RiwayatKesehatanPage extends StatefulWidget {
  static const String id = 'RiwayatKesehatanPage';
  RiwayatKesehatanArguments args;
  RiwayatKesehatanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<RiwayatKesehatanPage> createState() => _RiwayatKesehatanPageState();
}

class _RiwayatKesehatanPageState extends State<RiwayatKesehatanPage> {
  User user = AuthProvider.currentUser!;
  String type = '';
  double sizeAgendaItemHeight = 75;
  List<UserHealthReport> listRiwayatSakit = <UserHealthReport>[];
  List<HealthyCard> listSakit = <HealthyCard>[];

  void getData() async {
    type = widget.args.type;
    Response<dynamic> resp;

    if (type.toUpperCase() == 'RIWAYAT KESEHATANKU') {
      resp = await NetUtil().dioClient.get('/health/userReported');
    } else {
      resp = await NetUtil().dioClient.get('/health/userReported/all');
      sizeAgendaItemHeight = 125;
    }

    listRiwayatSakit.addAll((resp.data).map<UserHealthReport>((request) {
      return UserHealthReport.fromData(request);
    }));

    String dataCard = '';
    for (var i = 0; i < listRiwayatSakit.length; i++) {
      DateTime startTime = listRiwayatSakit[i].created_at;
      DateTime endTime = listRiwayatSakit[i].healed_at ?? DateTime.now();
      Color bg = listRiwayatSakit[i].disease_level == 1
          ? smartRTSickLevel1Color
          : listRiwayatSakit[i].disease_level == 2
              ? smartRTSickLevel2Color
              : smartRTSickLevel3Color;
      if (type.toUpperCase() == 'RIWAYAT KESEHATANKU') {
        dataCard =
            '${listRiwayatSakit[i].disease_group!.name}\nDetail: ${listRiwayatSakit[i].disease_notes}\n\n';
      } else {
        dataCard =
            '${listRiwayatSakit[i].reported_data_user!.full_name}\n${listRiwayatSakit[i].reported_data_user!.address}\n\n${listRiwayatSakit[i].disease_group!.name}\nDetail: ${listRiwayatSakit[i].disease_notes}\n\n';
      }

      listSakit.add(HealthyCard(
          dataCard, startTime, endTime, bg, true, listRiwayatSakit[i]));
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(type),
        ),
        body: Column(
          children: [
            Expanded(
              child: SfCalendar(
                minDate: user.created_at,
                maxDate: DateTime.now(),
                todayHighlightColor: smartRTTertiaryColor,
                initialSelectedDate: DateTime.now(),
                selectionDecoration: BoxDecoration(
                  border: Border.all(color: smartRTTertiaryColor, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  shape: BoxShape.rectangle,
                ),
                headerStyle: CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                  backgroundColor: smartRTTertiaryColor,
                  textStyle: smartRTTextTitleCard.copyWith(
                      letterSpacing: 3, color: smartRTQuaternaryColor),
                ),
                viewHeaderStyle: ViewHeaderStyle(
                    backgroundColor: smartRTSuccessColor,
                    dayTextStyle: smartRTTextLarge,
                    dateTextStyle: smartRTTextLarge),
                backgroundColor: smartRTQuaternaryColor,
                view: CalendarView.month,
                dataSource: HealthyDataSource(listSakit),
                monthViewSettings: MonthViewSettings(
                  showAgenda: true,
                  agendaViewHeight: 300,
                  agendaItemHeight: sizeAgendaItemHeight,
                ),
                onTap: (calendarTapDetails) {
                  if (calendarTapDetails.targetElement ==
                          CalendarElement.appointment &&
                      type.toUpperCase() != 'RIWAYAT KESEHATANKU') {
                    UserHealthReport data = calendarTapDetails
                        .appointments![0].dataUserHealthReport!;
                    DetailRiwayatKesehatanArguments arguments =
                        DetailRiwayatKesehatanArguments(dataReport: data);
                    Navigator.pushNamed(context, DetailRiwayatKesehatanPage.id,
                        arguments: arguments);
                  }
                },
              ),
            ),
          ],
        ));
  }
}
