import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:ui' as ui;

class LaporanKesehatanAdmin extends StatefulWidget {
  static const String id = 'LaporanKesehatanAdmin';
  const LaporanKesehatanAdmin({super.key});

  @override
  State<LaporanKesehatanAdmin> createState() => _LaporanKesehatanAdminState();
}

class _LaporanKesehatanAdminState extends State<LaporanKesehatanAdmin> {
  DateTime? _selectedMonthYear = DateTime.now();
  List<Map<String, dynamic>> dataJumlahWilayah = [];
  List<Map<String, dynamic>> dataJumlahPenyakit = [];
  List<Map<String, dynamic>> dataPenyakitPerWilayah = [];
  GlobalKey<SfCartesianChartState> _chartPenyakitWilayah = GlobalKey();
  GlobalKey<SfCartesianChartState> _chartPenyakitKategori = GlobalKey();
  GlobalKey<SfCartesianChartState> _chartPenyakitWilayahKategori = GlobalKey();
  Future<void> getData() async {
    try {
      Response<dynamic> resp = await NetUtil().dioClient.get(
          '/health/healthreport/${DateFormat('MM-yyyy').format(_selectedMonthYear!)}');
      if (resp.statusCode.toString() == '200') {
        setState(() {
          dataJumlahWilayah =
              resp.data['dataJumlahWilayah'].map<Map<String, dynamic>>((data) {
            return {"nama": data['nama'], "jumlah": data['jumlah']};
          }).toList();
          dataJumlahPenyakit =
              resp.data['dataJumlahPenyakit'].map<Map<String, dynamic>>((data) {
            return {"nama": data['nama'], "jumlah": data['jumlah']};
          }).toList();
          dataPenyakitPerWilayah = resp.data['dataPenyakitPerWilayah']
              .map<Map<String, dynamic>>((data) {
            return {
              "wilayah": data['wilayah'],
              "dataJumlahPenyakit": data['dataJumlahPenyakit'].map((p) {
                return {"nama": p['nama'], "jumlah": p['jumlah']};
              }).toList(),
            };
          }).toList();
        });
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  void exportPDF() async {
    final pdf = pw.Document();

    // Ambil image per chart
    ui.Image imageDataWilayah =
        await _chartPenyakitWilayah.currentState!.toImage(pixelRatio: 3.0);
    ui.Image imageDataKategori =
        await _chartPenyakitKategori.currentState!.toImage(pixelRatio: 3.0);
    ui.Image imageDataWilayahKategori = await _chartPenyakitWilayahKategori
        .currentState!
        .toImage(pixelRatio: 3.0);
    ByteData? bytesDataWilayah =
        await imageDataWilayah.toByteData(format: ui.ImageByteFormat.png);
    ByteData? bytesDataKategori =
        await imageDataKategori.toByteData(format: ui.ImageByteFormat.png);
    ByteData? bytesDataWilayahKategori = await imageDataWilayahKategori
        .toByteData(format: ui.ImageByteFormat.png);
    Uint8List imageBytesDataWilayah = bytesDataWilayah!.buffer.asUint8List(
        bytesDataWilayah.offsetInBytes, bytesDataWilayah.lengthInBytes);
    Uint8List imageBytesDataKategori = bytesDataKategori!.buffer.asUint8List(
        bytesDataKategori.offsetInBytes, bytesDataKategori.lengthInBytes);
    Uint8List imageBytesDataWilayahKategori = bytesDataWilayahKategori!.buffer
        .asUint8List(bytesDataWilayahKategori.offsetInBytes,
            bytesDataWilayahKategori.lengthInBytes);

    pw.MemoryImage chartImageDataWilayah =
        pw.MemoryImage(imageBytesDataWilayah);
    pw.MemoryImage chartImageDataKategori =
        pw.MemoryImage(imageBytesDataKategori);
    pw.MemoryImage chartImageDataWilayahKategori =
        pw.MemoryImage(imageBytesDataWilayahKategori);

    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return [
          pw.Column(
            mainAxisSize: pw.MainAxisSize.max,
            children: [
              pw.Image(chartImageDataWilayah),
              pw.Image(chartImageDataKategori),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: dataJumlahPenyakit.map((e) {
                  int index = dataJumlahPenyakit.indexOf(e);
                  String huruf = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index];
                  return pw.Text('$huruf: ${e['nama']}');
                }).toList(),
              ),
              pw.Image(chartImageDataWilayahKategori),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: dataJumlahPenyakit.map((e) {
                  int index = dataJumlahPenyakit.indexOf(e);
                  String huruf = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index];
                  return pw.Text('$huruf: ${e['nama']}');
                }).toList(),
              )
            ],
          ),
        ];
      },
    ));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Kesehatan'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: paddingScreen,
                child: Column(
                  children: [
                    Text(
                      'Tanggal Terpilih: ${DateFormat('MMMM y', 'id_ID').format(_selectedMonthYear!)}',
                      style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ))),
                        onPressed: () async {
                          DateTime? temp = await showMonthYearPicker(
                              context: context,
                              initialDate: _selectedMonthYear!,
                              firstDate: DateTime(2000),
                              lastDate: DateTime.now());
                          if (temp != null) {
                            setState(() {
                              _selectedMonthYear = temp;
                            });
                            getData();
                          }
                        },
                        child: Text(
                          'Pilih Bulan dan Tahun',
                          style: smartRTTextLargeBold_Secondary,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SfCartesianChart(
                        key: _chartPenyakitWilayah,
                        title: ChartTitle(
                            text: 'Jumlah Penyakit Berdasarkan Wilayah',
                            textStyle: smartRTTextLargeBold_Primary),
                        primaryXAxis: CategoryAxis(labelRotation: 15),
                        primaryYAxis: NumericAxis(),
                        series: [
                          ColumnSeries(
                              dataSource: dataJumlahWilayah,
                              xValueMapper:
                                  (Map<String, dynamic> datum, index) =>
                                      datum['nama'],
                              yValueMapper:
                                  (Map<String, dynamic> datum, index) =>
                                      datum['jumlah'],
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true, showZeroValue: false))
                        ],
                      ),
                      SfCartesianChart(
                        key: _chartPenyakitKategori,
                        title: ChartTitle(
                            text: 'Jumlah Penyakit Berdasarkan Kategori',
                            textStyle: smartRTTextLargeBold_Primary),
                        primaryXAxis: CategoryAxis(),
                        series: [
                          ColumnSeries(
                              dataSource: dataJumlahPenyakit,
                              xValueMapper:
                                  (Map<String, dynamic> datum, index) =>
                                      'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index],
                              yValueMapper:
                                  (Map<String, dynamic> datum, index) =>
                                      datum['jumlah'],
                              dataLabelSettings: DataLabelSettings(
                                  isVisible: true, showZeroValue: false))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: dataJumlahPenyakit.map((e) {
                          int index = dataJumlahPenyakit.indexOf(e);
                          String huruf = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index];
                          return Text('$huruf: ${e['nama']}');
                        }).toList(),
                      ),
                      SfCartesianChart(
                          key: _chartPenyakitWilayahKategori,
                          title: ChartTitle(
                              text:
                                  'Jumlah Penyakit Berdasarkan Kategori Per Wilayah',
                              textStyle: smartRTTextLargeBold_Primary),
                          primaryXAxis: CategoryAxis(),
                          primaryYAxis: NumericAxis(),
                          legend: Legend(
                              isVisible: true,
                              position: LegendPosition.bottom,
                              overflowMode: LegendItemOverflowMode.wrap,
                              width: '100%',
                              height: '100%'),
                          series: dataPenyakitPerWilayah.map((wilayah) {
                            return StackedColumnSeries(
                                name: wilayah['wilayah'],
                                dataSource: wilayah['dataJumlahPenyakit'],
                                xValueMapper: (dynamic datum, index) =>
                                    'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index],
                                yValueMapper: (dynamic datum, index) =>
                                    datum['jumlah'],
                                dataLabelSettings: DataLabelSettings(
                                    isVisible: true, showZeroValue: false));
                          }).toList()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: dataJumlahPenyakit.map((e) {
                          int index = dataJumlahPenyakit.indexOf(e);
                          String huruf = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'[index];
                          return Text('$huruf: ${e['nama']}');
                        }).toList(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            exportPDF();
          },
          child: Text(
            'Cetak Laporan',
            style: smartRTTextLargeBold_Secondary,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
