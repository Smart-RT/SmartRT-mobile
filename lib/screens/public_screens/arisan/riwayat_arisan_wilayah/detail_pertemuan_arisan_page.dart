import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/screens/public_screens/arisan/absen_anggota_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_iuran_arisan_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_absensi_pertemuan_arisan_page.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';

class DetailPertemuanArisanPageArguments {
  LotteryClubPeriodDetail dataPertemuan;
  String periodeKe;
  String pertemuanKe;
  DetailPertemuanArisanPageArguments(
      {required this.dataPertemuan,
      required this.periodeKe,
      required this.pertemuanKe});
}

class DetailPertemuanArisanPage extends StatefulWidget {
  static const String id = 'DetailPertemuanArisanPage';
  DetailPertemuanArisanPageArguments args;
  DetailPertemuanArisanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<DetailPertemuanArisanPage> createState() =>
      _DetailPertemuanArisanPageState();
}

class _DetailPertemuanArisanPageState extends State<DetailPertemuanArisanPage> {
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
  String statusPembayaran = '';
  String iuranPertemuan = '';
  String belumBayarCTR = '';
  String belumBayarTotal = '';
  String sudahBayarCTR = '';
  String sudahBayarTotal = '';

  void getData() async {
    dataPertemuan = widget.args.dataPertemuan;
    periodeKe = widget.args.periodeKe;
    pertemuanKe = widget.args.pertemuanKe;
    tanggalPertemuan = DateFormat('d MMMM y').format(dataPertemuan!.meet_date);
    waktuPertemuan =
        '${DateFormat('H:m').format(dataPertemuan!.meet_date)} WIB';
    tempatPertemuan = dataPertemuan!.meet_at.toString();
    totalKehadiran = dataPertemuan!.total_attendance.toString();
    pemenangKe1 = dataPertemuan!.winner_1_id == null
        ? '-'
        : dataPertemuan!.winner_1_id!.full_name;
    pemenangKe2 = dataPertemuan!.winner_2_id == null
        ? '-'
        : dataPertemuan!.winner_2_id!.full_name;
    status = dataPertemuan!.status.toString();

    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getDataTagihan/${dataPertemuan!.id.toString()}');
    LotteryClubPeriodDetailBill dataPembayaran =
        LotteryClubPeriodDetailBill.fromData(resp.data);
    statusPembayaran = dataPembayaran.status.toString();
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
        title: Text(''),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            status,
                            style: smartRTTextLarge.copyWith(
                                color: status == 'Unpublished'
                                    ? smartRTErrorColor2
                                    : status == 'Published'
                                        ? smartRTSuccessColor2
                                        : smartRTPrimaryColor),
                          ),
                        ],
                      ),
                      SB_height15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tanggal Pertemuan',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            tanggalPertemuan,
                            style: smartRTTextLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Waktu Pertemuan',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            waktuPertemuan,
                            style: smartRTTextLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tempatPertemuan,
                            style: smartRTTextLarge,
                          ),
                          Text(
                            'Rumah Pak RT',
                            style: smartRTTextLarge,
                          ),
                        ],
                      ),
                      SB_height15,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jumlah Anggota Hadir',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            '10 Orang',
                            style: smartRTTextLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pemenang Pertama',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            pemenangKe1,
                            style: smartRTTextLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pemenang Kedua',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            pemenangKe2,
                            style: smartRTTextLarge,
                          ),
                        ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Anggota Belum Bayar',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            '${belumBayarCTR} Orang\n(${belumBayarTotal})',
                            style: smartRTTextLarge.copyWith(
                                color: smartRTErrorColor2),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Anggota Sudah Bayar',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            '${sudahBayarCTR} Orang\n(${sudahBayarTotal})',
                            style: smartRTTextLarge.copyWith(
                                color: smartRTSuccessColor2),
                            textAlign: TextAlign.right,
                          ),
                        ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Iuran Pertemuan',
                            style: smartRTTextLarge,
                          ),
                          Text(
                            iuranPertemuan,
                            style: smartRTTextLarge,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Status Pembayaranku',
                            style: smartRTTextLarge,
                          ),
                          (statusPembayaran == '0')
                              ? Text(
                                  'Belum Bayar',
                                  style: smartRTTextLarge.copyWith(
                                      color: smartRTErrorColor2),
                                )
                              : Text(
                                  'Lunas',
                                  style: smartRTTextLarge.copyWith(
                                      color: smartRTSuccessColor2),
                                ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
                title: 'Bayar Iuran Sekarang',
                onTapDestination: PembayaranIuranArisan.id),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
              title: 'Lihat Absensi',
              onTap: () async {
                debugPrint('YOLOO : $status');
                if (status == "Published") {
                  AbsenAnggotaPageArguments args = AbsenAnggotaPageArguments(
                      idPertemuan: dataPertemuan!.id.toString());
                  Navigator.pushNamed(context, AbsenAnggotaPage.id,
                      arguments: args);
                }
              },
            ),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
                title: 'Lihat Iuran Arisan',
                onTapDestination: LihatIuranArisanPertemuanPage.id),
            Divider(
              height: 25,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
