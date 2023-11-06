import 'dart:typed_data';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/data_patient_grouping_by_disease_group.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:smart_rt/models/syncfusion_calendar/healthy_data_source.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

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
  List<UserHealthReport> listRiwayatSakit = <UserHealthReport>[];
  List<HealthyCard> listSakit = <HealthyCard>[];
  String type = '';
  double sizeAgendaItemHeight = 75;
  Widget actionWidget = SizedBox();
  DateTime? _selected;
  DateTime monthYearCreated = DateTime(2023);
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  List<DataPatientGroupingByDiseaseGroup>
      listDataPatientGroupingByDiseaseGroup = [];
  late GlobalKey<SfCartesianChartState> _cartesianChartKey;
  // = GlobalKey();
  Uint8List mem = Uint8List(1);

  // PDF
  Future<void> _createPDF() async {
    String monthYear =
        DateFormat('MMMM y', 'id_ID').format(_selected!).toUpperCase();
    String kecamatan = user.data_sub_district!.name;
    String kelurahan = user.data_urban_village!.name;
    String RWRT = 'RW ${user.rw_num} / RT ${user.rt_num}';
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/users/getCountAnggota/wilayah/${user.area!.id}');
    String totalWarga = '${resp.data} Orang';

    final ui.Image data =
        await _cartesianChartKey.currentState!.toImage(pixelRatio: 3.0);
    final ByteData? bytes =
        await data.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    final chartImage = pw.MemoryImage(imageBytes);

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text('LAPORAN KESEHATAN WILAYAH',
                  style: pw.TextStyle(
                    fontSize: 20,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center),
              pw.Text(monthYear,
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center),
              pw.Divider(
                height: 30,
                thickness: 5,
                color: PdfColor.fromHex('#000000'),
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      'Kecamatan',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      ':',
                      style: const pw.TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 15,
                    child: pw.Text(
                      kecamatan,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      'Kelurahan',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      ':',
                      style: const pw.TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 15,
                    child: pw.Text(
                      kelurahan,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      'RW / RT',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      ':',
                      style: const pw.TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 15,
                    child: pw.Text(
                      RWRT,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      'Total Warga',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      ':',
                      style: const pw.TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    flex: 15,
                    child: pw.Text(
                      totalWarga,
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Divider(
                height: 30,
                thickness: 1,
                color: PdfColor.fromHex('#000000'),
              ),
              pw.Center(
                  child: pw.SizedBox(
                width: 500,
                height: 500,
                child: pw.Image(chartImage),
              )),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
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
        String tempDate = DateFormat('yyyy-MM', 'id_ID').format(_selected!);
        debugPrint(tempDate);
        getDataPatientGroupingByDiseaseGroup(tempDate);
        Navigator.pop(context);

        chooseDateForReport();
      });
    }
  }

  void getDataPatientGroupingByDiseaseGroup(String date) async {
    listDataPatientGroupingByDiseaseGroup.clear();
    Response<dynamic> respDataPDF = await NetUtil().dioClient.get(
        '/health/getDataPatientGroupingByDiseaseGroup/area/${user.area!.id}/monthYear/$date');
    listDataPatientGroupingByDiseaseGroup.addAll(
        (respDataPDF.data).map<DataPatientGroupingByDiseaseGroup>((request) {
      return DataPatientGroupingByDiseaseGroup.fromData(request);
    }));
    setState(() {});
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
                    DateFormat('MMMM y', 'id_ID').format(_selected!),
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
                        } else {
                          _createPDF();
                        }
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
      Response<dynamic> respDataPDF = await NetUtil().dioClient.get(
          '/health/getDataPatientGroupingByDiseaseGroup/area/${user.area!.id}/monthYear/2023-02');
      listDataPatientGroupingByDiseaseGroup.addAll(
          (respDataPDF.data).map<DataPatientGroupingByDiseaseGroup>((request) {
        return DataPatientGroupingByDiseaseGroup.fromData(request);
      }));

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
    _cartesianChartKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(type),
          actions: [actionWidget],
        ),
        body: Stack(
          children: [
            SfCartesianChart(
              key: _cartesianChartKey,
              primaryXAxis: CategoryAxis(
                // labelPlacement: LabelPlacement.onTicks,
                // rangePadding: ChartRangePadding.auto,
                labelRotation: 90,
              ),
              title: ChartTitle(
                  text: 'Grafik Berdasarkan Golongan Penyakit',
                  textStyle:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold)),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <ColumnSeries<DataPatientGroupingByDiseaseGroup, String>>[
                ColumnSeries<DataPatientGroupingByDiseaseGroup, String>(
                    color: smartRTPrimaryColor,
                    xAxisName: 'Golongan Penyakit',
                    yAxisName: 'Jumlah Penderita',
                    name: 'Jumlah Penderita',
                    dataSource: listDataPatientGroupingByDiseaseGroup,
                    xValueMapper: (DataPatientGroupingByDiseaseGroup data, _) =>
                        data.disease_group_name,
                    yValueMapper: (DataPatientGroupingByDiseaseGroup data, _) =>
                        data.total_patient,
                    // Enable data label
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ],
            ),
            SfCalendar(
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
                  UserHealthReport data =
                      calendarTapDetails.appointments![0].dataUserHealthReport!;
                  DetailRiwayatKesehatanArguments arguments =
                      DetailRiwayatKesehatanArguments(dataReport: data);
                  Navigator.pushNamed(context, DetailRiwayatKesehatanPage.id,
                      arguments: arguments);
                }
              },
            ),
          ],
        ));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
