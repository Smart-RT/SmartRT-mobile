import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class RiwayatKesehatankuPage extends StatefulWidget {
  static const String id = 'RiwayatKesehatankuPage';
  const RiwayatKesehatankuPage({Key? key}) : super(key: key);

  @override
  State<RiwayatKesehatankuPage> createState() => _RiwayatKesehatankuPageState();
}

class _RiwayatKesehatankuPageState extends State<RiwayatKesehatankuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Kesehatanku'),
      ),
      body: SfCalendar(
      view: CalendarView.month,
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    )
    );
  }
}
