import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_absence.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_member.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/anggota_periode/anggota_periode_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_2.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

class RiwayatArisanPeriodeDetailArguments {
  LotteryClubPeriod dataPeriodeArisan;
  RiwayatArisanPeriodeDetailArguments({required this.dataPeriodeArisan});
}

class RiwayatArisanPeriodeDetailPage extends StatefulWidget {
  static const String id = 'RiwayatArisanPeriodeDetailPage';
  RiwayatArisanPeriodeDetailArguments args;
  RiwayatArisanPeriodeDetailPage({Key? key, required this.args})
      : super(key: key);

  @override
  State<RiwayatArisanPeriodeDetailPage> createState() =>
      _RiwayatArisanPeriodeDetailPageState();
}

class _RiwayatArisanPeriodeDetailPageState
    extends State<RiwayatArisanPeriodeDetailPage> {
  LotteryClubPeriod? dataPeriodeArisan;
  String periodeKe = '';
  String pertemuanPertama = '';
  String pertemuanTerakhir = '';
  String jumlahPertemuan = '';
  String yearLimit = '';
  String jumlahAnggota = '';
  String iuranPertemuan = '';
  String hadiahPemenang = '';
  String status = '';
  Color statusColor = smartRTPrimaryColor;
  User user = AuthProvider.currentUser!;
  String belumBayarCTR = '0';
  String belumBayarTotal = '0';
  String sudahBayarCTR = '0';
  String sudahBayarTotal = '0';

  void getData() async {
    dataPeriodeArisan = widget.args.dataPeriodeArisan;
    periodeKe = dataPeriodeArisan!.period.toString();
    DateTime date = dataPeriodeArisan!.started_at;
    DateTime pertemuanTerakhirDate = dataPeriodeArisan!.year_limit == 0
        ? DateTime(date.year, date.month + 6, date.day)
        : DateTime(
            date.year + dataPeriodeArisan!.year_limit, date.month, date.day);
    pertemuanPertama =
        DateFormat('d MMMM y', 'id_ID').format(dataPeriodeArisan!.started_at);
    pertemuanTerakhir =
        DateFormat('MMMM y', 'id_ID').format((pertemuanTerakhirDate));
    yearLimit = dataPeriodeArisan!.year_limit == 0
        ? '6 bulan'
        : '${dataPeriodeArisan!.year_limit.toString()} tahun';
    jumlahPertemuan =
        '${dataPeriodeArisan!.total_meets.toString()}x (${yearLimit})';
    jumlahAnggota = '${dataPeriodeArisan!.total_members} orang';
    iuranPertemuan =
        CurrencyFormat.convertToIdr(dataPeriodeArisan!.bill_amount, 2);
    hadiahPemenang =
        CurrencyFormat.convertToIdr(dataPeriodeArisan!.winner_bill_amount, 2);
    status = dataPeriodeArisan!.meet_ctr < dataPeriodeArisan!.total_meets
        ? 'Berlangsung'
        : 'Selesai';

    if (status.toLowerCase() == 'berlangsung') {
      statusColor = smartRTStatusYellowColor;
    }
    setState(() {});
  }

  // PDF
  Future<void> _createPDF() async {
    String wilayah =
        'Kec. ${user.data_sub_district!.name}, Kel. ${user.data_urban_village!.name.substring(10)}\nRW ${user.rw_num} / RT ${user.rt_num}';

    List<LotteryClubPeriodMember> listMember = [];
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getListMemberArisan/${dataPeriodeArisan!.id}');
    listMember.addAll((resp.data).map<LotteryClubPeriodMember>((request) {
      return LotteryClubPeriodMember.fromData(request);
    }));

    List<LotteryClubPeriodDetail> listPertemuan = [];
    Response<dynamic> resp2 = await NetUtil()
        .dioClient
        .get('/lotteryClubs/get/meets/id-periode/${dataPeriodeArisan!.id}');
    listPertemuan.addAll((resp2.data).map<LotteryClubPeriodDetail>((request) {
      return LotteryClubPeriodDetail.fromData(request);
    }));

    //  var detailPertemuanWidgets =
    //     await Future.wait(listPertemuan.map((meet) async {
    //   await getDataPertemuan(idPertemuan: meet.id);
    //   return [
    //     pw.Row(
    //         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: pw.CrossAxisAlignment.start,
    //         children: [
    //           pw.Expanded(child: pw.Text('o')),
    //           pw.Expanded(
    //             flex: 10,
    //             child: pw.Column(
    //                 crossAxisAlignment: pw.CrossAxisAlignment.start,
    //                 children: []),
    //           ),
    //         ]),
    //     pw.SizedBox(height: 5)
    //   ];
    // }));

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text('RIWAYAT ARISAN PERIODE KE-$periodeKe',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Text(wilayah,
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
                pw.Row(children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Status',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      status,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.SizedBox(height: 15),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Pertemuan Pertama',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      pertemuanPertama,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Pertemuan Terakhir',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      pertemuanTerakhir,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.SizedBox(height: 15),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Jumlah Pertemuan',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      jumlahPertemuan,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Jumlah Anggota',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      jumlahAnggota,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.SizedBox(height: 15),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Iuran Pertemuan',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      iuranPertemuan,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Expanded(
                    flex: 2,
                    child: pw.Text(
                      'Nominal Pemenang',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      hadiahPemenang,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Divider(
                  height: 30,
                  thickness: 1,
                  color: PdfColor.fromHex('#000000'),
                ),
                pw.Text(
                  'ANGGOTA PERIODE',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 15),
                ...listMember.map((member) {
                  return [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Expanded(child: pw.Text('o')),
                          pw.Expanded(
                            flex: 10,
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    member.user_id!.full_name,
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                  pw.Text(
                                    member.user_id!.address ?? '',
                                    style: pw.TextStyle(
                                      fontSize: 15,
                                    ),
                                    textAlign: pw.TextAlign.left,
                                  ),
                                ]),
                          ),
                        ]),
                    pw.SizedBox(height: 5)
                  ];
                }).reduce((a, b) => [...a, ...b]),
              ],
            ),
          ];
        },
      ),
    );

    for (var meet in listPertemuan) {
      if (meet.status != 'Unpublished') {
        Response<dynamic> resp = await NetUtil()
            .dioClient
            .get('/lotteryClubs/getDataTagihanWilayah/${meet.id}');
        belumBayarCTR = (resp.data["belumBayarCTR"] ?? 0).toString();
        belumBayarTotal =
            CurrencyFormat.convertToIdr((resp.data["belumBayarTotal"] ?? 0), 2);
        sudahBayarCTR = (resp.data["sudahBayarCTR"] ?? 0).toString();
        sudahBayarTotal =
            CurrencyFormat.convertToIdr((resp.data["sudahBayarTotal"] ?? 0), 2);

        List<LotteryClubPeriodDetailAbsence> listAbsensiAnggotaArisan = [];

        resp = await NetUtil()
            .dioClient
            .get('/lotteryClubs/getListAbsensiPertemuan/${meet.id}');
        listAbsensiAnggotaArisan
            .addAll((resp.data).map<LotteryClubPeriodDetailAbsence>((request) {
          return LotteryClubPeriodDetailAbsence.fromData(request);
        }));

        List<LotteryClubPeriodDetailBill> listDataPembayaran = [];
        resp = await NetUtil()
            .dioClient
            .get('/lotteryClubs/payment/all/${meet.id}');

        listDataPembayaran
            .addAll((resp.data).map<LotteryClubPeriodDetailBill>((request) {
          return LotteryClubPeriodDetailBill.fromData(request);
        }));

        pdf.addPage(
          pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    pw.Text('RIWAYAT ARISAN PERIODE KE-$periodeKe',
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                        textAlign: pw.TextAlign.center),
                    pw.Text('PERTEMUAN KE-${meet.pertemuan_ke}',
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
                    pw.Text(
                      'TEMPAT DAN WAKTU',
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.left,
                    ),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Tipe Pertemuan',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          meet.is_offline_meet == 1
                              ? 'Pertemuan Offline'
                              : 'Pertemuan Online',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Tanggal Waktu',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          StringFormat.formatDate(dateTime: meet.meet_date),
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Tempat',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          meet.meet_at ?? "-",
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                    pw.Divider(
                      height: 30,
                      thickness: 1,
                      color: PdfColor.fromHex('#000000'),
                    ),
                    pw.Text(
                      'TOTAL KEHADIRAN DAN PEMENANG',
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.left,
                    ),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Total Anggota Hadir',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          '${meet.total_attendance} Orang',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Pemenang Pertama',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          meet.winner_1_id == null
                              ? "-"
                              : meet.winner_1_id!.full_name,
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Pemenang Kedua',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          meet.winner_2_id == null
                              ? "-"
                              : meet.winner_2_id!.full_name,
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                    pw.SizedBox(height: 15),
                    pw.Text(
                      'ANGGOTA TIDAK HADIR',
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    if (listAbsensiAnggotaArisan.isNotEmpty)
                      ...listAbsensiAnggotaArisan.map((absen) {
                        if (absen.is_present == 1) {
                          return [];
                        }
                        return [
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(child: pw.Text('o')),
                                pw.Expanded(
                                  flex: 10,
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          absen.user_id!.full_name,
                                          style: pw.TextStyle(
                                            fontSize: 15,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                          textAlign: pw.TextAlign.left,
                                        ),
                                        pw.Text(
                                          absen.user_id!.address ?? '',
                                          style: pw.TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: pw.TextAlign.left,
                                        ),
                                      ]),
                                ),
                              ]),
                        ];
                      }).reduce((a, b) => [...a, ...b]),
                    pw.Divider(
                      height: 30,
                      thickness: 1,
                      color: PdfColor.fromHex('#000000'),
                    ),
                    pw.Text(
                      'IURAN',
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.left,
                    ),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Anggota Belum Bayar',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          '$belumBayarCTR Orang ($belumBayarTotal)',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                    pw.Row(children: [
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          'Anggota Sudah Bayar',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          '$sudahBayarCTR Orang ($sudahBayarTotal)',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                    pw.SizedBox(height: 15),
                    pw.Text(
                      'ANGGOTA BELUM BAYAR',
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    if (listDataPembayaran.isNotEmpty)
                      ...listDataPembayaran.map((data) {
                        if (data.status == 1) {
                          return [];
                        }
                        return [
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(child: pw.Text('o')),
                                pw.Expanded(
                                  flex: 10,
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          data.data_user!.full_name,
                                          style: pw.TextStyle(
                                            fontSize: 15,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                          textAlign: pw.TextAlign.left,
                                        ),
                                        pw.Text(
                                          data.data_user!.address ?? '',
                                          style: pw.TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: pw.TextAlign.left,
                                        ),
                                        pw.SizedBox(height: 5)
                                      ]),
                                ),
                              ]),
                        ];
                      }).reduce((a, b) => [...a, ...b]),
                    pw.SizedBox(height: 15),
                    pw.Text(
                      'ANGGOTA SUDAH BAYAR',
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    if (listDataPembayaran.isNotEmpty)
                      ...listDataPembayaran.map((data) {
                        if (data.status != 1) {
                          return [];
                        }
                        return [
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(child: pw.Text('o')),
                                pw.Expanded(
                                  flex: 10,
                                  child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Text(
                                          data.data_user!.full_name,
                                          style: pw.TextStyle(
                                            fontSize: 15,
                                            fontWeight: pw.FontWeight.bold,
                                          ),
                                          textAlign: pw.TextAlign.left,
                                        ),
                                        pw.Text(
                                          data.data_user!.address ?? '',
                                          style: pw.TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: pw.TextAlign.left,
                                        ),
                                        pw.Text(
                                          'Transaksi via ${data.payment_type ?? 'Bank Tranfer'}',
                                          style: pw.TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: pw.TextAlign.left,
                                        ),
                                        pw.Text(
                                          'Transaksi dilakukan tanggal ${StringFormat.formatDate(dateTime: data.updated_at!)}',
                                          style: pw.TextStyle(
                                            fontSize: 15,
                                          ),
                                          textAlign: pw.TextAlign.left,
                                        ),
                                        pw.SizedBox(height: 5)
                                      ]),
                                ),
                              ]),
                        ];
                      }).reduce((a, b) => [...a, ...b]),
                  ],
                ),
              ];
            },
          ),
        );
      }
    }

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
  // ===

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
        title: const Text(''),
        actions: [Role.Ketua_RT, Role.Wakil_RT, Role.Sekretaris]
                .contains(AuthProvider.currentUser!.user_role)
            ? [
                GestureDetector(
                  onTap: () {
                    _createPDF();
                  },
                  child: Icon(Icons.picture_as_pdf),
                ),
                SB_width15,
              ]
            : [],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: paddingScreen,
              child: Column(
                children: [
                  Text(
                    'DETAIL PERIODE KE-${periodeKe}',
                    style: smartRTTextTitleCard.copyWith(
                      color: smartRTPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SB_height15,
                  ListTileData2(
                    txtLeft: 'Status',
                    txtRight: status,
                    txtStyleRight: smartRTTextLarge.copyWith(
                        color: statusColor, fontWeight: FontWeight.bold),
                  ),
                  SB_height15,
                  ListTileData2(
                    txtLeft: 'Pertemuan Pertama',
                    txtRight: pertemuanPertama,
                  ),
                  ListTileData2(
                    txtLeft: 'Pertemuan Terakhir',
                    txtRight: pertemuanTerakhir,
                  ),
                  SB_height15,
                  ListTileData2(
                    txtLeft: 'Jumlah Pertemuan',
                    txtRight: jumlahPertemuan,
                  ),
                  ListTileData2(
                    txtLeft: 'Jumlah Anggota',
                    txtRight: jumlahAnggota,
                  ),
                  SB_height15,
                  ListTileData2(
                    txtLeft: 'Iuran Pertemuan',
                    txtRight: iuranPertemuan,
                  ),
                  ListTileData2(
                    txtLeft: 'Nominal Pemenang',
                    txtRight: hadiahPemenang,
                  ),
                ],
              ),
            ),
            Divider(
              color: smartRTPrimaryColor,
              height: 25,
              thickness: 1,
            ),
            ListTileArisan(
              title: 'Lihat Semua Anggota',
              onTap: () {
                AnggotaPeriodeArgument arguments = AnggotaPeriodeArgument(
                    idPeriode: dataPeriodeArisan!.id.toString(),
                    periodeKe: periodeKe);
                Navigator.pushNamed(context, AnggotaPeriodePage.id,
                    arguments: arguments);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              height: 25,
              thickness: 1,
            ),
            ListTileArisan(
              title: 'Lihat Semua Pertemuan',
              onTap: () async {
                RiwayatArisanPertemuanArguments arguments =
                    RiwayatArisanPertemuanArguments(
                  idPeriode: dataPeriodeArisan!.id.toString(),
                  periodeKe: periodeKe,
                  dataPeriodeArisan: dataPeriodeArisan!,
                );
                Navigator.pushNamed(context, RiwayatArisanPertemuanPage.id,
                    arguments: arguments);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              height: 25,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
