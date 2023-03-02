import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:smart_rt/models/syncfusion_calendar/event_data_source.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

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
  Widget actionWidget = SizedBox();
  DateTime? _selected;
  DateTime monthYearCreated = DateTime(2023);

  // PDF
  Future<void> _createPDF() async {
    // try {
    //   final pdf = pw.Document();

    //   pdf.addPage(
    //     pw.Page(
    //       pageFormat: PdfPageFormat.a4,
    //       build: (pw.Context context) {
    //         return pw.Center(
    //           child: pw.Text("Hello World"),
    //         );
    //       },
    //     ),
    //   );

    //   final bytes = await pdf.save();
    //   final dir = await getApplicationDocumentsDirectory();
    //   final file = File('$dir/example.pdf');

    //   await file.writeAsBytes(bytes);
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }
  // ===

  Future<void> _onPressedMonthYearPicker({
    required BuildContext context,
    String? locale,
  }) async {
    final localeObj = locale != null ? Locale(locale) : null;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: _selected ?? DateTime.now(),
      firstDate: monthYearCreated,
      lastDate: DateTime.now(),
      locale: localeObj,
    );
    if (selected != null) {
      setState(() {
        _selected = selected;
        Navigator.pop(context);
        chooseDateForReport();
      });
    }
  }

  void chooseDateForReport() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Silahkan memilih bulan dan tahun yang anda inginkan !',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Center(
            child: Column(
              children: [
                if (_selected == null)
                  Text(
                    'Belum memilih Bulan dan Tahun.',
                    style: smartRTTextNormal.copyWith(
                        fontWeight: FontWeight.bold,
                        color: smartRTStatusRedColor),
                  )
                else
                  Text(
                    DateFormat('MMMM y').format(_selected!),
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                  ),
                SB_height15,
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ))),
                    onPressed: () =>
                        _onPressedMonthYearPicker(context: context),
                    child: Text(
                      'Pilih Bulan dan Tahun',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
                SB_height30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () async {
                        Navigator.pop(context, 'Batal');
                        _selected = null;
                        // _createPDF();
                      },
                      child: Text(
                        'Batal',
                        style: smartRTTextNormal.copyWith(
                            fontWeight: FontWeight.bold,
                            color: smartRTTertiaryColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_selected == null) {
                          SmartRTSnackbar.show(context,
                              message: 'Wajib memilih bulan dan tahun !',
                              backgroundColor: smartRTErrorColor);
                        } else {}
                      },
                      child: Text(
                        'EXPORT PDF',
                        style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getData() async {
    type = widget.args.type;
    Response<dynamic> resp;

    monthYearCreated = user.created_at;

    if (type.toUpperCase() == 'RIWAYAT KESEHATANKU') {
      resp = await NetUtil().dioClient.get('/health/userReported');
    } else {
      resp = await NetUtil().dioClient.get('/health/userReported/all');
      sizeAgendaItemHeight = 125;

      actionWidget = Row(
        children: [
          GestureDetector(
            onTap: () {
              chooseDateForReport();
            },
            child: Icon(Icons.picture_as_pdf),
          ),
          SB_width15,
        ],
      );
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
          actions: [actionWidget],
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
