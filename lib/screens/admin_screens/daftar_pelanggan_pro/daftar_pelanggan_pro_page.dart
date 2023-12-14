import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/models/area/sub_district.dart';
import 'package:smart_rt/models/area/urban_village.dart';
import 'package:smart_rt/models/subscribe/pro_subscribe_bill.dart';
import 'package:smart_rt/providers/subscribe_provider.dart';
import 'package:smart_rt/screens/admin_screens/daftar_pelanggan_pro/daftar_pelanggan_pro_page_detail.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/cards/card_list_subscribe.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:ui' as ui;

class DaftarPelangganProPage extends StatefulWidget {
  static const String id = 'DaftarPelangganProPage';
  const DaftarPelangganProPage({Key? key}) : super(key: key);

  @override
  State<DaftarPelangganProPage> createState() => _DaftarPelangganProPageState();
}

class _DaftarPelangganProPageState extends State<DaftarPelangganProPage> {
  List<Area> listAreaFiltered = [];
  List<Area> listArea = [];
  void getData() async {
    await context.read<SubscribeProvider>().getListAreaLangganan();
  }

  final List<SubDistrict> _listKecamatan = [];
  final List<UrbanVillage> _listKelurahan = [];
  List<UrbanVillage> _listKelurahanFiltered = [];

  final textEditingControllerKelurahan = TextEditingController();
  final textEditingControllerKecamatan = TextEditingController();
  final textEditingControllerRT = TextEditingController();
  final textEditingControllerRW = TextEditingController();

  String _kecamatanSelectedValue = '';
  String? _kelurahanSelectedValue = '';

  Future<void> loadKecamatan() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get("/addresses/subDistricts");

    setState(() {
      _listKecamatan.addAll(resp.data.map<SubDistrict>((request) {
        return SubDistrict.fromData(request);
      }));
    });
  }

  Future<void> loadKelurahan() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get("/addresses/urbanVillages");

    setState(() {
      _listKelurahan.addAll(resp.data.map<UrbanVillage>((request) {
        return UrbanVillage.fromData(request);
      }));
    });
  }

  void filterDialog() async {
    // Buat Data yang akan dilempar ke widget Filter
    DaftarWilayahFilterState last = DaftarWilayahFilterState(
        currentKecamatan: _kecamatanSelectedValue,
        currentKelurahan: _kelurahanSelectedValue ?? "",
        currentRT: textEditingControllerRT.text,
        currentRW: textEditingControllerRW.text);

    showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FILTER',
                style: smartRTTextTitleCard,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close)),
            ],
          ),
          content: DaftarWilayahFilter(
            lastState: last,
            listKecamatan: _listKecamatan,
            listKelurahan: _listKelurahan,
            filterCallback:
                (String kecamatan, String kelurahan, String RT, String RW) {
              setState(() {
                _kecamatanSelectedValue = kecamatan;
                _kelurahanSelectedValue = kelurahan;
                textEditingControllerRT.text = RT;
                textEditingControllerRW.text = RW;
              });
            },
          ),
        );
      },
    );
  }

  void filter() async {
    debugPrint('-----------------0');
    if (_kecamatanSelectedValue == '' &&
        _kelurahanSelectedValue == '' &&
        textEditingControllerRT.text == '' &&
        textEditingControllerRW.text == '') {
      listAreaFiltered = listArea;
      debugPrint('-----------------1');
      debugPrint(listAreaFiltered.length.toString());
    } else {
      debugPrint('textEditingControllerKecamatan.text');
      debugPrint(_kecamatanSelectedValue);
      listAreaFiltered = listArea
          .where((x) =>
              (_kecamatanSelectedValue == '' ||
                  x.data_kecamatan!.id
                      .toString()
                      .contains(_kecamatanSelectedValue)) &&
              (_kelurahanSelectedValue == '' ||
                  x.data_kelurahan!.id
                      .toString()
                      .contains(_kelurahanSelectedValue ?? '')) &&
              (textEditingControllerRT.text == '' ||
                  x.rt_num.toString().contains(textEditingControllerRT.text)) &&
              (textEditingControllerRW.text == '' ||
                  x.rw_num.toString().contains(textEditingControllerRW.text)))
          .toList();
    }
    debugPrint('aaaaaaaaaaaaaaaaaaaaa');
    debugPrint(listAreaFiltered.length.toString());
    setState(() {});
  }

  void exportPDF() async {
    final pdf = pw.Document();
    List<Area> dataArea = [];
    List<ProSubscribeBill> dataTagihan = [];
    Response<dynamic> resp =
        await NetUtil().dioClient.get("/subscribe-pro/laporan");
    if (resp.data != null) {
      dataArea.clear();
      dataArea
          .addAll(resp.data['data_area'].map<Area>((a) => Area.fromData(a)));
      dataTagihan.clear();
      dataTagihan.addAll(resp.data['data_tagihan']
          .map<ProSubscribeBill>((psb) => ProSubscribeBill.fromData(psb)));
      pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text('LAPORAN DAFTAR LANGGANAN PRO',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Jumlah Wilayah Terdaftar',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            )))),
                pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child:
                            pw.Text(': ${resp.data['jumlah_area']} Wilayah'))),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Jumlah Wilayah Langganan Pro',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            )))),
                pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            ': ${resp.data['jumlah_area_pro']} Wilayah'))),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text('Jumlah Wilayah Belum Langganan Pro',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            )))),
                pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            ': ${resp.data['jumlah_area_belum_pro']} Wilayah'))),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child:
                            pw.Text('Jumlah Wilayah Pro Sudah Lunas Bulan ini',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )))),
                pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            ': ${resp.data['jumlah_pro_sudah_bayar']} Wilayah'))),
              ],
            ),
            pw.SizedBox(height: 5),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Expanded(
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child:
                            pw.Text('Jumlah Wilayah Pro Belum Lunas Bulan ini',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                )))),
                pw.Expanded(
                    flex: 2,
                    child: pw.Align(
                        alignment: pw.Alignment.centerLeft,
                        child: pw.Text(
                            ': ${resp.data['jumlah_pro_belum_bayar']} Wilayah'))),
              ],
            ),
            pw.SizedBox(height: 25),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text('DAFTAR WILAYAH LANGGANAN PRO',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
              ],
            ),
            ...listArea.where((e) => e.is_subscribe_pro == 1).map(
              (e) {
                return [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                  'o Kec. ${e.data_kecamatan!.name}, Kel. ${e.data_kelurahan!.name}, RW ${e.rw_num} / RT ${e.rt_num}',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 1,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('Status Tagihan Bulan Ini',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                ': ${e.dataSubscribe!.status == 0 ? 'Menunggu Pembayaran' : e.dataSubscribe!.status == 1 ? 'Sudah Membayar' : 'Berhenti Berlangganan'}',
                              ))),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 1,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('Total Populasi',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                ': ${e.total_population} pengguna aplikasi',
                              ))),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 1,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('Data Ketua RT',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                ': ${e.ketua_id!.full_name} ${e.ketua_id?.born_date != null ? '(${StringFormat.ageNow(bornDate: e.ketua_id!.born_date!)})' : ''}',
                              ))),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 1,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                ': ${e.ketua_id!.address ?? '-'}',
                              ))),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 1,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                ': ${e.ketua_id!.phone}',
                              ))),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 1,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('Pembayaran Terakhir',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                ': ${e.dataSubscribe!.latest_payment_at != null ? StringFormat.formatDate(dateTime: e.dataSubscribe!.latest_payment_at!, isWithTime: true) : '-'}',
                              ))),
                    ],
                  ),
                  if (e.dataSubscribe!.latest_payment_at != null)
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('Pembayaran Selanjutnya',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  ': ${StringFormat.formatDate(dateTime: e.dataSubscribe!.latest_payment_at!.add(Duration(days: 30)), isWithTime: false)}',
                                ))),
                      ],
                    ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 1,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text('Batas Akhir Pembayaran',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                  )))),
                      pw.Expanded(
                          flex: 5,
                          child: pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                ': ${e.dataSubscribe!.latest_payment_at != null ? StringFormat.formatDate(dateTime: e.dataSubscribe!.latest_payment_at!.add(Duration(days: 37)), isWithTime: false) : StringFormat.formatDate(dateTime: e.dataSubscribe!.created_at.add(Duration(days: 7)), isWithTime: false)}',
                              ))),
                    ],
                  ),
                  if (dataTagihan.where((dt) => dt.area_id == e.id).length >
                      0) ...[
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('Data Tagihan:',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  '',
                                ))),
                      ],
                    ),
                    ...dataTagihan.where((dt) => dt.area_id == e.id).map((pbs) {
                      return pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Expanded(
                              flex: 1,
                              child: pw.Align(
                                  alignment: pw.Alignment.centerLeft,
                                  child: pw.Text('',
                                      style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                      )))),
                          pw.Expanded(
                              flex: 10,
                              child: pw.Align(
                                  alignment: pw.Alignment.centerLeft,
                                  child: pw.Text(
                                    'o Tagihan ${DateFormat('MMMM y', 'id_ID').format(pbs.created_at)}, ${CurrencyFormat.convertToIdr(pbs.bill_amount, 2)} (${pbs.status == 0 ? 'Menunggu Pembayaran' : 'Selesai'})',
                                  ))),
                        ],
                      );
                    })
                  ],
                  pw.SizedBox(height: 15),
                ];
              },
            ).reduce((a, b) => [...a, ...b]),
            pw.SizedBox(height: 25),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text('DAFTAR WILAYAH BELUM PRO',
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
              ],
            ),
            if (listArea.where((e) => e.is_subscribe_pro == 0).length > 0)
              ...listArea.where((e) => e.is_subscribe_pro == 0).map(
                (e) {
                  return [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Expanded(
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                    'o Kec. ${e.data_kecamatan!.name}, Kel. ${e.data_kelurahan!.name}, RW ${e.rw_num} / RT ${e.rt_num}',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('Total Populasi',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                    ': ${e.total_population} pengguna aplikasi',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('Data Ketua RT',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                    ': ${e.ketua_id!.full_name} ${e.ketua_id?.born_date != null ? '(${StringFormat.ageNow(bornDate: e.ketua_id!.born_date!)})' : ''}',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child:
                                    pw.Text(': ${e.ketua_id!.address ?? '-'}',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                        )))),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.Expanded(
                            flex: 1,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text('',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                        pw.Expanded(
                            flex: 5,
                            child: pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(': ${e.ketua_id!.phone}',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                    )))),
                      ],
                    ),
                    pw.SizedBox(height: 15),
                  ];
                },
              ).reduce((a, b) => [...a, ...b])
            else ...[
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Expanded(
                      child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text('Belum Ada Data',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              )))),
                ],
              ),
            ]
          ];
        },
      ));

      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save());
    }
  }

  @override
  void initState() {
    loadKecamatan();
    loadKelurahan();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    listArea = context.watch<SubscribeProvider>().listAreaLangganan;
    listAreaFiltered = listArea.where(
      (element) {
        return ((_kecamatanSelectedValue == "" ||
                element.data_kecamatan!.id.toString() ==
                    _kecamatanSelectedValue) &&
            (_kelurahanSelectedValue == "" ||
                element.data_kelurahan!.id.toString() ==
                    _kelurahanSelectedValue) &&
            (textEditingControllerRT.text == "" ||
                element.rt_num.toString() == textEditingControllerRT.text) &&
            (textEditingControllerRW.text == "" ||
                element.rw_num.toString() == textEditingControllerRW.text));
      },
    ).toList();

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Langganan Pro'),
          actions: [
            GestureDetector(
                onTap: () {
                  filterDialog();
                },
                child: Icon(Icons.filter_alt)),
            SB_width15,
            GestureDetector(
                onTap: () {
                  exportPDF();
                },
                child: Icon(Icons.picture_as_pdf)),
            SB_width15,
          ],
        ),
        body: listAreaFiltered.isNotEmpty
            ? ListView.separated(
                separatorBuilder: (context, int) {
                  return Divider(
                    color: smartRTPrimaryColor,
                    thickness: 1,
                    height: 5,
                  );
                },
                itemCount: listAreaFiltered.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CardListSubscribe(
                          kecamatan: StringFormat.kecamatanFormat(
                              kecamatan:
                                  listAreaFiltered[index].data_kecamatan!.name),
                          kelurahan: StringFormat.kelurahanFormat(
                              kelurahan:
                                  listAreaFiltered[index].data_kelurahan!.name),
                          rtNum: listAreaFiltered[index].rt_num.toString(),
                          rwNum: listAreaFiltered[index].rw_num.toString(),
                          status:
                              listAreaFiltered[index].dataSubscribe!.status == 0
                                  ? 'Menunggu Pembayaran'
                                  : listAreaFiltered[index]
                                              .dataSubscribe!
                                              .status ==
                                          1
                                      ? 'Telah Membayar'
                                      : 'Berhenti Berlangganan',
                          onTap: () {
                            Navigator.pushNamed(
                                context, DaftarPelangganProPageDetail.id,
                                arguments:
                                    DaftarPelangganProPageDetailArguments(
                                        index: index));
                          }),
                      if (index == listArea.length - 1)
                        Divider(
                          color: smartRTPrimaryColor,
                          thickness: 1,
                          height: 5,
                        ),
                    ],
                  );
                },
              )
            : Center(
                child: Text(
                  "Tidak ada Wilayah Terdaftar",
                  style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}

class DaftarWilayahFilterState {
  final String currentKecamatan;
  final String currentKelurahan;
  final String currentRT;
  final String currentRW;

  DaftarWilayahFilterState(
      {required this.currentKecamatan,
      required this.currentKelurahan,
      required this.currentRT,
      required this.currentRW});
}

class DaftarWilayahFilter extends StatefulWidget {
  final DaftarWilayahFilterState lastState;
  final List<SubDistrict> listKecamatan;
  final List<UrbanVillage> listKelurahan;
  final Function filterCallback;

  const DaftarWilayahFilter(
      {super.key,
      required this.lastState,
      required this.listKecamatan,
      required this.listKelurahan,
      required this.filterCallback});

  @override
  State<DaftarWilayahFilter> createState() => _DaftarWilayahFilterState();
}

class _DaftarWilayahFilterState extends State<DaftarWilayahFilter> {
  final TextEditingController textEditingControllerKecamatan =
      TextEditingController();
  final TextEditingController textEditingControllerKelurahan =
      TextEditingController();
  final TextEditingController textEditingControllerRT = TextEditingController();
  final TextEditingController textEditingControllerRW = TextEditingController();

  List<UrbanVillage> _filteredKelurahan = [];

  String selectedKecamatan = "";
  String selectedKelurahan = "";

  @override
  void initState() {
    super.initState();
    selectedKecamatan = widget.lastState.currentKecamatan;
    selectedKelurahan = widget.lastState.currentKelurahan;
    textEditingControllerRT.text = widget.lastState.currentRT;
    textEditingControllerRW.text = widget.lastState.currentRW;
  }

  @override
  Widget build(BuildContext context) {
    // Ambil data kelurahan yang kecamatannya = selectedKecamatan
    _filteredKelurahan = widget.listKelurahan
        .where((kelurahan) =>
            kelurahan.idKecamatan.toString() == selectedKecamatan)
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonFormField2(
            style: smartRTTextLargeBold_Primary,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            dropdownMaxHeight: 200,
            searchController: textEditingControllerKecamatan,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                controller: textEditingControllerKecamatan,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: smartRTTextLargeBold_Primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              List<String> ids = widget.listKecamatan
                  .where(
                    (element) => element.name
                        .toUpperCase()
                        .contains(searchValue.toUpperCase()),
                  )
                  .map(
                    (e) => e.id.toString(),
                  )
                  .toList();
              return ids.contains(item.value.toString());
            },
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingControllerKecamatan.clear();
              }
            },
            isExpanded: true,
            hint: Text(
              'Kecamatan',
              style: smartRTTextLargeBold_Primary,
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: smartRTPrimaryColor,
            ),
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 25, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            items: widget.listKecamatan
                .map((item) => DropdownMenuItem<String>(
                      value: item.id.toString(),
                      child: Text(
                        item.name,
                        style: smartRTTextNormal_Primary,
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Kecamatan tidak boleh kosong';
              }
              return null;
            },
            value: selectedKecamatan.isNotEmpty ? selectedKecamatan : null,
            onChanged: (value) {
              setState(() {
                selectedKecamatan = value.toString();
                selectedKelurahan = "";
              });
            },
          ),
        ),
        SB_height15,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButtonFormField2(
            style: smartRTTextLargeBold_Primary,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            dropdownMaxHeight: 200,
            searchController: textEditingControllerKelurahan,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                controller: textEditingControllerKelurahan,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: smartRTTextLargeBold_Primary,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              debugPrint(item.toString());
              List<String> ids = _filteredKelurahan
                  .where(
                    (element) => element.name
                        .toUpperCase()
                        .contains(searchValue.toUpperCase()),
                  )
                  .map(
                    (e) => e.id.toString(),
                  )
                  .toList();
              return ids.contains(item.value.toString());
            },
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingControllerKelurahan.clear();
              }
            },
            isExpanded: true,
            hint: Text(
              'Kelurahan',
              style: smartRTTextLargeBold_Primary,
            ),
            disabledHint: Text(
              'Kelurahan',
              style: smartRTTextLargeBold_Primary.copyWith(
                  color: smartRTDisabledColor),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconDisabledColor: smartRTDisabledColor,
            iconEnabledColor: smartRTPrimaryColor,
            iconSize: 30,
            buttonHeight: 60,
            buttonPadding: const EdgeInsets.only(left: 25, right: 10),
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            items: _filteredKelurahan
                .map((item) => DropdownMenuItem<String>(
                      value: item.id.toString(),
                      child: Text(
                        item.name,
                        style: smartRTTextNormal_Primary,
                      ),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'Kelurahan tidak boleh kosong';
              }
              return null;
            },
            value: selectedKelurahan.isNotEmpty ? selectedKelurahan : null,
            onChanged: _filteredKelurahan.isNotEmpty
                ? (value) {
                    setState(() {
                      selectedKelurahan = value.toString();
                    });
                  }
                : null,
          ),
        ),
        SB_height15,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: textEditingControllerRW,
                  autocorrect: false,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'RW',
                  ),
                ),
              ),
              SB_width15,
              Expanded(
                child: TextFormField(
                  controller: textEditingControllerRT,
                  autocorrect: false,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'RT',
                  ),
                ),
              ),
            ],
          ),
        ),
        SB_height15,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                widget.filterCallback("", "", "", "");
                Navigator.pop(context);
              },
              child: Text(
                'Clear',
                style: smartRTTextNormal,
              ),
            ),
            TextButton(
              onPressed: () {
                widget.filterCallback(selectedKecamatan, selectedKelurahan,
                    textEditingControllerRT.text, textEditingControllerRW.text);
                Navigator.pop(context);
              },
              child: Text(
                'CARI SEKARANG!',
                style: smartRTTextNormal.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
