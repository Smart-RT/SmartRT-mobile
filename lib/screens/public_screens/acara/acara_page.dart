import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/syncfusion_calendar/event_data_source.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:smart_rt/screens/public_screens/acara/form_acara/form_acara_page.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_page_detail.dart';

class AcaraPage extends StatefulWidget {
  static const String id = 'AcaraPage';
  const AcaraPage({Key? key}) : super(key: key);

  @override
  State<AcaraPage> createState() => _AcaraPageState();
}

class _AcaraPageState extends State<AcaraPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  User user = AuthProvider.currentUser!;
  List<EventCard> listEventCard = <EventCard>[];
  double sizeAgendaItemHeight = 75;
  Widget actionWidget = SizedBox();
  bool showCFMonth = true;
  bool showCFDay = false;
  DateTime daySelectionDate = DateTime.now();

  void getData() async {
    await context.read<EventProvider>().getDataListEvent();
    setActionMonth();
  }

  void setActionSchedule() async {
    showCFDay = true;
    showCFMonth = false;

    actionWidget = ElevatedButton(
      onPressed: () async {
        setActionMonth();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      )),
      child: const Icon(Icons.date_range),
    );
    setState(() {});
  }

  void setActionMonth() async {
    showCFDay = false;
    showCFMonth = true;
    actionWidget = ElevatedButton(
      onPressed: () async {
        setActionSchedule();
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      )),
      child: const Icon(Icons.list_alt_outlined),
    );
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
    var padding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height - 105;
    List<Event> listEvent = context.watch<EventProvider>().dataListEvent;
    listEventCard.clear();

    for (var i = 0; i < listEvent.length; i++) {
      DateTime startTime = listEvent[i].event_date_start_at;
      DateTime endTime = listEvent[i].event_date_end_at;
      String eventName = '${listEvent[i].title}\n${listEvent[i].detail}';

      listEventCard.add(EventCard(eventName, startTime, endTime,
          smartRTPrimaryColor, false, listEvent[i]));
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Acara'),
          actions: [
            if (user.user_role == Role.Ketua_RT ||
                user.user_role == Role.Wakil_RT ||
                user.user_role == Role.Sekretaris)
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, FormAcaraPage.id,
                      arguments: FormAcaraPageArgument(type: 'create'));
                },
                child: const Icon(Icons.add),
              ),
            if (user.user_role == Role.Ketua_RT ||
                user.user_role == Role.Wakil_RT ||
                user.user_role == Role.Sekretaris)
              SB_width15,
          ],
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          color: smartRTSecondaryColor,
          backgroundColor: smartRTPrimaryColor,
          strokeWidth: 4.0,
          onRefresh: () async {
            return context.read<EventProvider>().getDataListEvent();
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: height,
              child: Stack(
                children: [
                  Visibility(
                    visible: showCFDay,
                    child: SfCalendar(
                      minDate: user.created_at,
                      todayHighlightColor: smartRTPrimaryColor,
                      initialSelectedDate: daySelectionDate,
                      selectionDecoration: BoxDecoration(
                        border:
                            Border.all(color: smartRTPrimaryColor, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        shape: BoxShape.rectangle,
                      ),
                      headerStyle: CalendarHeaderStyle(
                        textAlign: TextAlign.center,
                        backgroundColor: smartRTActiveColor2,
                        textStyle:
                            smartRTTextTitleCard.copyWith(letterSpacing: 3),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                          backgroundColor: smartRTActiveColor,
                          dayTextStyle: smartRTTextLarge,
                          dateTextStyle: smartRTTextLarge),
                      backgroundColor: smartRTQuaternaryColor,
                      view: CalendarView.schedule,
                      dataSource: EventDataSource(listEventCard),
                      scheduleViewSettings: ScheduleViewSettings(
                        hideEmptyScheduleWeek: true,
                        monthHeaderSettings: MonthHeaderSettings(
                          height: 75,
                          backgroundColor: smartRTActiveColor,
                          monthTextStyle: smartRTTextTitleCard,
                        ),
                      ),
                      onTap: (calendarTapDetails) {
                        if (calendarTapDetails.targetElement ==
                            CalendarElement.appointment) {
                          Event data =
                              calendarTapDetails.appointments![0].dataEvent!;

                          int index = listEvent.indexOf(data);

                          Navigator.pushNamed(context, AcaraPageDetail.id,
                              arguments:
                                  AcaraPageDetailArgument(dataEventIdx: index));
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: showCFMonth,
                    child: SfCalendar(
                      onSelectionChanged: (calendarSelectionDetails) {
                        daySelectionDate = calendarSelectionDetails.date!;
                        debugPrint(daySelectionDate.toString());
                      },
                      minDate: user.created_at,
                      todayHighlightColor: smartRTPrimaryColor,
                      initialSelectedDate: daySelectionDate,
                      selectionDecoration: BoxDecoration(
                        border:
                            Border.all(color: smartRTPrimaryColor, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        shape: BoxShape.rectangle,
                      ),
                      headerStyle: CalendarHeaderStyle(
                        textAlign: TextAlign.center,
                        backgroundColor: smartRTActiveColor,
                        textStyle:
                            smartRTTextTitleCard.copyWith(letterSpacing: 3),
                      ),
                      viewHeaderStyle: ViewHeaderStyle(
                          backgroundColor: smartRTActiveColor2,
                          dayTextStyle: smartRTTextLarge,
                          dateTextStyle: smartRTTextLarge),
                      backgroundColor: smartRTSecondaryColor,
                      view: CalendarView.month,
                      dataSource: EventDataSource(listEventCard),
                      monthViewSettings: MonthViewSettings(
                        showAgenda: true,
                        agendaViewHeight: 300,
                        agendaItemHeight: sizeAgendaItemHeight,
                      ),
                      onTap: (calendarTapDetails) {
                        if (calendarTapDetails.targetElement ==
                            CalendarElement.appointment) {
                          Event data =
                              calendarTapDetails.appointments![0].dataEvent!;

                          int index = listEvent.indexOf(data);

                          Navigator.pushNamed(context, AcaraPageDetail.id,
                              arguments:
                                  AcaraPageDetailArgument(dataEventIdx: index));
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    right: 25,
                    child: SizedBox(height: 75, width: 75, child: actionWidget),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
