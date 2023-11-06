import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_member.dart';
import 'package:smart_rt/screens/public_screens/arisan/absensi_pertemuan_arisan/absensi_pertemuan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_arisan/pembayaran_iuran_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_arisan/pembayaran_iuran_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/list_iuran_pertemuan_dan_detail/list_iuran_pertemuan_page.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_2.dart';

class RiwayatArisanPertemuanDetailArguments {
  LotteryClubPeriodDetail dataPertemuan;
  String periodeKe;
  String pertemuanKe;
  String typeFrom;
  LotteryClubPeriod dataPeriodeArisan;
  RiwayatArisanPertemuanDetailArguments({
    required this.dataPertemuan,
    required this.periodeKe,
    required this.pertemuanKe,
    required this.typeFrom,
    required this.dataPeriodeArisan,
  });
}

class RiwayatArisanPertemuanDetailPage extends StatefulWidget {
  static const String id = 'RiwayatArisanPertemuanDetailPage';
  RiwayatArisanPertemuanDetailArguments args;
  RiwayatArisanPertemuanDetailPage({Key? key, required this.args})
      : super(key: key);

  @override
  State<RiwayatArisanPertemuanDetailPage> createState() =>
      _RiwayatArisanPertemuanDetailPageState();
}

class _RiwayatArisanPertemuanDetailPageState
    extends State<RiwayatArisanPertemuanDetailPage> {
  LotteryClubPeriodDetail? dataPertemuan;
  String periodeKe = '';
  String pertemuanKe = '';
  String tanggalPertemuan = '';
  String waktuPertemuan = '';
  String tempatPertemuan = '';
  String totalKehadiran = '';
  String pemenangKe1 = '';
  String pemenangKe2 = '';
  String status = '';
  String statusPembayaran = 'Lunas';
  String iuranPertemuan = '';
  String belumBayarCTR = '';
  String belumBayarTotal = '';
  String sudahBayarCTR = '';
  String sudahBayarTotal = '';
  Color statusColor = smartRTPrimaryColor;
  Color statusPembayaranColor = smartRTPrimaryColor;

  List<LotteryClubPeriodMember> listPemenang = [];

  void restartPage() async {
    if (widget.args.typeFrom.toLowerCase() == 'riwayat') {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, ArisanPage.id);
    } else {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, ArisanPage.id);
    }
  }

  void showConfirmationToStart() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin memulai pertemuan dengan mengundi pemenang pada pertemuan ini? \n*Pastikan sudah melakukan absensi dengan benar sesuai dengan kehadiran.',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text(
                  'Tidak',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold, color: smartRTErrorColor2),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  startLottery();
                },
                child: Text(
                  'SAYA YAKIN',
                  style: smartRTTextNormal.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startLottery() async {
    listPemenang.clear();
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .patch('/lotteryClubs/periode/pertemuan/start', data: {
      'lottery_club_period_detail_ID': dataPertemuan!.id,
    });

    listPemenang.addAll((resp.data).map<LotteryClubPeriodMember>((request) {
      return LotteryClubPeriodMember.fromData(request);
    }));
    Timer(Duration(seconds: 7), () async {
      Navigator.pop(context);
      showWinner();
    });
    // ignore: use_build_context_synchronously
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Kira - kira siapa ya sobat terpilih?',
            style: smartRTTextTitleCard,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                      width: 75,
                      child: Lottie.asset(
                        'assets/lotties/arisan/gold-cracking.json',
                        fit: BoxFit.fitWidth,
                        repeat: true,
                      )),
                ),
                Center(
                    child: Text(
                  'Mohon Menunggu ...',
                  style: smartRTTextNormal,
                )),
                SB_height30,
              ],
            ),
          ],
        );
      },
    );
  }

  void showWinner() async {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Selamat Kepada Pemenang Terpilih !',
            style: smartRTTextTitleCard,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  listPemenang[0].user_id!.full_name,
                  style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  listPemenang[0].user_id!.address!,
                  style: smartRTTextNormal,
                  textAlign: TextAlign.center,
                ),
                SB_height30,
                if (listPemenang.length == 2)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        listPemenang[1].user_id!.full_name,
                        style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        listPemenang[1].user_id!.address!,
                        style: smartRTTextNormal,
                        textAlign: TextAlign.center,
                      ),
                      SB_height30,
                    ],
                  ),
                Text(
                  '*Hai Pengurus RT, jangan lupa untuk memberikan hadiah kepada pemenang sebesar ${CurrencyFormat.convertToIdr(widget.args.dataPeriodeArisan.winner_bill_amount, 2)}',
                  style: smartRTTextNormal,
                  textAlign: TextAlign.center,
                ),
                SB_height30,
                TextButton(
                  onPressed: () async {
                    restartPage();
                  },
                  child: Text(
                    'OK !',
                    style: smartRTTextNormal.copyWith(
                        fontWeight: FontWeight.bold,
                        color: smartRTStatusGreenColor),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void bayarIuranAction() async {
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getDataTagihan/${dataPertemuan!.id}');
    LotteryClubPeriodDetailBill dataPembayaran =
        LotteryClubPeriodDetailBill.fromData(resp.data);

    if (dataPembayaran.payment_type == null ||
        dataPembayaran.payment_type == '' ||
        dataPembayaran.midtrans_transaction_status == 'failure') {
      PembayaranIuranArisanPage1Arguments args =
          PembayaranIuranArisanPage1Arguments(
              typeFrom: widget.args.typeFrom,
              periodeKe: periodeKe,
              pertemuanKe: pertemuanKe,
              dataPertemuan: dataPertemuan!);
      Navigator.pushNamed(context, PembayaranIuranArisanPage1.id,
          arguments: args);
    } else if (dataPembayaran.midtrans_transaction_status == 'pending') {
      PembayaranIuranArisanPage2Arguments args =
          PembayaranIuranArisanPage2Arguments(
        typeFrom: widget.args.typeFrom,
        periodeKe: periodeKe,
        pertemuanKe: pertemuanKe,
        dataPembayaran: dataPembayaran,
        dataPertemuan: dataPertemuan!,
      );
      Navigator.pushNamed(context, PembayaranIuranArisanPage2.id,
          arguments: args);
    }
  }

  void getData() async {
    dataPertemuan = widget.args.dataPertemuan;
    periodeKe = widget.args.periodeKe;
    pertemuanKe = widget.args.pertemuanKe;
    tanggalPertemuan =
        DateFormat('d MMMM y', 'id_ID').format(dataPertemuan!.meet_date);
    waktuPertemuan =
        '${DateFormat('H:m').format(dataPertemuan!.meet_date)} WIB';
    tempatPertemuan = dataPertemuan!.meet_at.toString();
    totalKehadiran = dataPertemuan!.total_attendance.toString();
    pemenangKe1 = dataPertemuan!.winner_1_id == null
        ? '-'
        : '${dataPertemuan!.winner_1_id!.full_name}\n${dataPertemuan!.winner_1_id!.address!}';
    pemenangKe2 = dataPertemuan!.winner_2_id == null
        ? '-'
        : '${dataPertemuan!.winner_2_id!.full_name}\n${dataPertemuan!.winner_2_id!.address!}';
    status = dataPertemuan!.status.toString();

    if (status == 'Unpublished') {
      statusColor = smartRTStatusYellowColor;
    } else if (status == 'Published') {
      statusColor = smartRTStatusGreenColor;
    } else if (status == 'Done') {
      statusColor = smartRTPrimaryColor;
    }

    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getDataTagihan/${dataPertemuan!.id.toString()}');
    LotteryClubPeriodDetailBill dataPembayaran =
        LotteryClubPeriodDetailBill.fromData(resp.data);
    statusPembayaran = dataPembayaran.status == 0 ? 'Belum Bayar' : 'Lunas';
    statusPembayaranColor = dataPembayaran.status == 0
        ? smartRTStatusRedColor
        : smartRTStatusGreenColor;
    iuranPertemuan = CurrencyFormat.convertToIdr(dataPembayaran.bill_amount, 2);

    resp = await NetUtil().dioClient.get(
        '/lotteryClubs/getDataTagihanWilayah/${dataPertemuan!.id.toString()}');

    belumBayarCTR = (resp.data["belumBayarCTR"] ?? 0).toString();
    belumBayarTotal =
        CurrencyFormat.convertToIdr((resp.data["belumBayarTotal"] ?? 0), 2);
    sudahBayarCTR = (resp.data["sudahBayarCTR"] ?? 0).toString();
    sudahBayarTotal =
        CurrencyFormat.convertToIdr((resp.data["sudahBayarTotal"] ?? 0), 2);
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
        title: const Text(''),
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
                  Column(
                    children: [
                      Text(
                        'DETAIL PERTEMUAN KE $pertemuanKe',
                        style: smartRTTextTitleCard.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'PERIODE KE $periodeKe',
                        style: smartRTTextLarge,
                        textAlign: TextAlign.center,
                      ),
                      SB_height15,
                      ListTileData2(
                        txtLeft: 'Status',
                        txtRight: status,
                        txtStyleRight:
                            smartRTTextLarge.copyWith(color: statusColor),
                      ),
                      SB_height15,
                      ListTileData2(
                        txtLeft: 'Tanggal Pertemuan',
                        txtRight: tanggalPertemuan,
                      ),
                      ListTileData2(
                        txtLeft: 'Waktu Pertemuan',
                        txtRight: waktuPertemuan,
                      ),
                      ListTileData2(
                        txtLeft: 'Tempat Pertemuan',
                        txtRight: tempatPertemuan,
                      ),
                      SB_height15,
                      ListTileData2(
                        txtLeft: 'Anggota Hadir',
                        txtRight: '$totalKehadiran orang',
                      ),
                      ListTileData2(
                        txtLeft: 'Pemenang Pertama',
                        txtRight: pemenangKe1,
                      ),
                      ListTileData2(
                        txtLeft: 'Pemenang Kedua',
                        txtRight: pemenangKe2,
                      ),
                    ],
                  ),
                  SB_height30,
                  Column(
                    children: [
                      Text(
                        'IURAN WILAYAH',
                        style: smartRTTextTitleCard.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SB_height15,
                      ListTileData2(
                        txtLeft: 'Anggota Belum Bayar',
                        txtRight: '$belumBayarCTR Orang\n($belumBayarTotal)',
                      ),
                      ListTileData2(
                        txtLeft: 'Anggota Sudah Bayar',
                        txtRight: '$sudahBayarCTR Orang\n($sudahBayarTotal)',
                      ),
                    ],
                  ),
                  SB_height30,
                  Column(
                    children: [
                      Text(
                        'IURANKU',
                        style: smartRTTextTitleCard.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SB_height15,
                      ListTileData2(
                        txtLeft: 'Iuran Pertemuan',
                        txtRight: iuranPertemuan,
                      ),
                      ListTileData2(
                        txtLeft: 'Status',
                        txtRight: statusPembayaran,
                        txtStyleRight: smartRTTextLarge.copyWith(
                            color: statusPembayaranColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (DateTime.now().compareTo(dataPertemuan!.meet_date) > 0 &&
                status == "Published")
              Column(
                children: [
                  Divider(
                    color: smartRTPrimaryColor,
                    height: 25,
                    thickness: 1,
                  ),
                  ListTileArisan(
                    title: 'Mulai Sekarang',
                    onTap: () async {
                      showConfirmationToStart();
                    },
                  ),
                ],
              ),
            if (statusPembayaran.toLowerCase() != 'lunas')
              Column(
                children: [
                  Divider(
                    color: smartRTPrimaryColor,
                    height: 25,
                    thickness: 1,
                  ),
                  ListTileArisan(
                    title: 'Bayar Iuran Sekarang',
                    onTap: () async {
                      bayarIuranAction();
                    },
                  ),
                ],
              ),
            Divider(
              color: smartRTPrimaryColor,
              height: 25,
              thickness: 1,
            ),
            ListTileArisan(
              title: 'Lihat Absensi',
              onTap: () async {
                DateTime dateTimeNow = DateTime.now();
                if (dateTimeNow.compareTo(dataPertemuan!.meet_date
                        .subtract(const Duration(minutes: 30))) >
                    0) {
                  if (status == "Published" || status == "Done") {
                    AbsensiPertemuanArisanArgument args =
                        AbsensiPertemuanArisanArgument(
                            typeFrom: widget.args.typeFrom,
                            dataPertemuan: dataPertemuan!);
                    Navigator.pushNamed(context, AbsensiPertemuanArisanPage.id,
                        arguments: args);
                  }
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Hai Sobat Pintar,',
                        style: smartRTTextTitleCard,
                      ),
                      content: Text(
                        'Anda hanya dapat melakukan absensi dari waktu 30 menit sebelum waktu pertemuan Arisan hingga pemenang telah terpilih.',
                        style: smartRTTextNormal.copyWith(
                            fontWeight: FontWeight.normal),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: Text(
                            'OK',
                            style: smartRTTextNormal.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              height: 25,
              thickness: 1,
            ),
            ListTileArisan(
              title: 'Lihat Iuran Arisan',
              onTap: () async {
                ListIuranPertemuanArgument args = ListIuranPertemuanArgument(
                    dataPertemuan: widget.args.dataPertemuan,
                    typeFrom: widget.args.typeFrom,
                    idPertemuan: dataPertemuan!.id.toString(),
                    pertemuanKe: pertemuanKe);
                Navigator.pushNamed(context, ListIuranPertemuanPage.id,
                    arguments: args);
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
