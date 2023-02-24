import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:smart_rt/models/syncfusion_calendar/event_data_source.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RiwayatKesehatankuPage extends StatefulWidget {
  static const String id = 'RiwayatKesehatankuPage';
  const RiwayatKesehatankuPage({Key? key}) : super(key: key);

  @override
  State<RiwayatKesehatankuPage> createState() => _RiwayatKesehatankuPageState();
}

class _RiwayatKesehatankuPageState extends State<RiwayatKesehatankuPage> {
  User user = AuthProvider.currentUser!;
  List<UserHealthReport> listRiwayatSakit = <UserHealthReport>[];
  List<Event> listSakit = <Event>[];

  void getData() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get('/health/userReported');
    listRiwayatSakit.addAll((resp.data).map<UserHealthReport>((request) {
      return UserHealthReport.fromData(request);
    }));
    for (var i = 0; i < listRiwayatSakit.length; i++) {
      DateTime startTime = listRiwayatSakit[i].created_at;
      DateTime endTime = listRiwayatSakit[i].healed_at ?? DateTime.now();
      Color bg = listRiwayatSakit[i].disease_level == 1
          ? smartRTSickLevel1Color
          : listRiwayatSakit[i].disease_level == 2
              ? smartRTSickLevel2Color
              : smartRTSickLevel3Color;
      listSakit.add(Event(
          '${listRiwayatSakit[i].disease_group!.name}\nDetail : ${listRiwayatSakit[i].disease_notes}\n\n',
          startTime,
          endTime,
          bg,
          true));
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
          title: Text('Riwayat Kesehatanku'),
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
                dataSource: EventDataSource(listSakit),
                monthViewSettings: MonthViewSettings(
                    showAgenda: true,
                    agendaViewHeight: 300,
                    agendaItemHeight: 75),
              ),
            ),
          ],
        ));
  }
}
