import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/syncfusion_calendar/meeting_data_source.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RiwayatKesehatankuPage extends StatefulWidget {
  static const String id = 'RiwayatKesehatankuPage';
  const RiwayatKesehatankuPage({Key? key}) : super(key: key);

  @override
  State<RiwayatKesehatankuPage> createState() => _RiwayatKesehatankuPageState();
}

class _RiwayatKesehatankuPageState extends State<RiwayatKesehatankuPage> {
  User user = AuthProvider.currentUser!;
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting('Conference', startTime, endTime,
        Color.fromARGB(255, 216, 255, 233), false));
    return meetings;
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
              flex: 3,
              child: SfCalendar(
                minDate: user.created_at,
                maxDate: DateTime.now(),
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
                dataSource: MeetingDataSource(_getDataSource()),
                monthViewSettings: MonthViewSettings(showAgenda: false),
              ),
            ),
            Expanded(flex: 2, child: Text('')),
          ],
        ));
  }
}
