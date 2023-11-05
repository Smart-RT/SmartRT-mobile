import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_arisan/pembayaran_iuran_arisan_page_2.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class PembayaranIuranArisanPage1Arguments {
  LotteryClubPeriodDetail dataPertemuan;
  String periodeKe;
  String pertemuanKe;
  String typeFrom;
  PembayaranIuranArisanPage1Arguments({
    required this.dataPertemuan,
    required this.periodeKe,
    required this.pertemuanKe,
    required this.typeFrom,
  });
}

class PembayaranIuranArisanPage1 extends StatefulWidget {
  static const String id = 'PembayaranIuranArisanPage1';
  PembayaranIuranArisanPage1Arguments args;
  PembayaranIuranArisanPage1({Key? key, required this.args}) : super(key: key);

  @override
  State<PembayaranIuranArisanPage1> createState() =>
      _PembayaranIuranArisanPage1State();
}

class _PembayaranIuranArisanPage1State
    extends State<PembayaranIuranArisanPage1> {
  String periodeKe = '';
  String pertemuanKe = '';
  String totalTagihan = '0';
  LotteryClubPeriodDetailBill? dataPembayaran;
  LotteryClubPeriodDetail? dataPertemuan;

  void getData() async {
    dataPertemuan = widget.args.dataPertemuan;
    periodeKe = widget.args.periodeKe;
    pertemuanKe = widget.args.pertemuanKe;

    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getDataTagihan/${dataPertemuan!.id}');
    dataPembayaran = LotteryClubPeriodDetailBill.fromData(resp.data);
    totalTagihan = CurrencyFormat.convertToIdr(dataPembayaran!.bill_amount, 2);

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
      body: Padding(
        padding: paddingScreen,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'PEMBAYARAN ARISAN',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              Text(
                'PERIODE $periodeKe PERTEMUAN $pertemuanKe',
                style: smartRTTextLarge,
                textAlign: TextAlign.center,
              ),
              SB_height50,
              Column(
                children: [
                  Text(
                    'Total Tagihan',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    totalTagihan,
                    style: smartRTTextTitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SB_height50,
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'METODE PEMBAYARAN',
                    style: smartRTTextTitleCard.copyWith(
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '* Anda dapat membayar secara langsung ke bendahara / Ketua RT. Jika anda sudah membayar secara langsung namun belum dikonfirmasi, maka anda dapat menemui bendahara / Ketua RT untuk mengonfirmasi.',
                    style: smartRTTextSmall,
                    textAlign: TextAlign.center,
                  ),
                  SB_height30,
                  Text(
                    'Bank Transfer (Virtual Account)',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SB_height15,
                  Divider(
                    color: smartRTPrimaryColor,
                    height: 0,
                    thickness: 1,
                  ),
                  ListTileArisan(
                    title: 'BCA',
                    onTap: () async {
                      Response<dynamic> resp = await NetUtil()
                          .dioClient
                          .post('/lotteryClubs/payment', data: {
                        'payment_type': 'bank_transfer',
                        'bank': 'bca',
                        'id_bill': dataPembayaran!.id,
                      });
                      LotteryClubPeriodDetailBill data =
                          LotteryClubPeriodDetailBill.fromData(resp.data);
                      PembayaranIuranArisanPage2Arguments args =
                          PembayaranIuranArisanPage2Arguments(
                              typeFrom: widget.args.typeFrom,
                              periodeKe: periodeKe,
                              pertemuanKe: pertemuanKe,
                              dataPembayaran: data,
                              dataPertemuan: dataPertemuan!);

                      Navigator.popAndPushNamed(
                          context, PembayaranIuranArisanPage2.id,
                          arguments: args);
                    },
                  ),
                  Divider(
                    color: smartRTPrimaryColor,
                    height: 0,
                    thickness: 1,
                  ),
                  ListTileArisan(
                    title: 'BNI',
                    onTap: () async {
                      Response<dynamic> resp = await NetUtil()
                          .dioClient
                          .post('/lotteryClubs/payment', data: {
                        'payment_type': 'bank_transfer',
                        'bank': 'bni',
                        'id_bill': dataPembayaran!.id,
                      });
                      LotteryClubPeriodDetailBill data =
                          LotteryClubPeriodDetailBill.fromData(resp.data);
                      PembayaranIuranArisanPage2Arguments args =
                          PembayaranIuranArisanPage2Arguments(
                              typeFrom: widget.args.typeFrom,
                              periodeKe: periodeKe,
                              pertemuanKe: pertemuanKe,
                              dataPembayaran: data,
                              dataPertemuan: dataPertemuan!);

                      Navigator.popAndPushNamed(
                          context, PembayaranIuranArisanPage2.id,
                          arguments: args);
                    },
                  ),
                  Divider(
                    color: smartRTPrimaryColor,
                    height: 0,
                    thickness: 1,
                  ),
                  ListTileArisan(
                    title: 'BRI',
                    onTap: () async {
                      Response<dynamic> resp = await NetUtil()
                          .dioClient
                          .post('/lotteryClubs/payment', data: {
                        'payment_type': 'bank_transfer',
                        'bank': 'bri',
                        'id_bill': dataPembayaran!.id,
                      });
                      LotteryClubPeriodDetailBill data =
                          LotteryClubPeriodDetailBill.fromData(resp.data);
                      PembayaranIuranArisanPage2Arguments args =
                          PembayaranIuranArisanPage2Arguments(
                              typeFrom: widget.args.typeFrom,
                              periodeKe: periodeKe,
                              pertemuanKe: pertemuanKe,
                              dataPembayaran: data,
                              dataPertemuan: dataPertemuan!);

                      Navigator.popAndPushNamed(
                          context, PembayaranIuranArisanPage2.id,
                          arguments: args);
                    },
                  ),
                  Divider(
                    color: smartRTPrimaryColor,
                    height: 0,
                    thickness: 1,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
