import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page_2.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class PembayaranIuranArisanArguments {
  String pertemuanID;
  String periodeKe;
  String pertemuanKe;
  PembayaranIuranArisanArguments(
      {required this.pertemuanID,
      required this.periodeKe,
      required this.pertemuanKe});
}

class PembayaranIuranArisan extends StatefulWidget {
  static const String id = 'PembayaranIuranArisan';
  PembayaranIuranArisanArguments args;
  PembayaranIuranArisan({Key? key, required this.args}) : super(key: key);

  @override
  State<PembayaranIuranArisan> createState() => _PembayaranIuranArisanState();
}

class _PembayaranIuranArisanState extends State<PembayaranIuranArisan> {
  String pertemuanID = '';
  String periodeKe = '';
  String pertemuanKe = '';
  String totalTagihan = '0';
  LotteryClubPeriodDetailBill? dataPembayaran;

  void getData() async {
    pertemuanID = widget.args.pertemuanID;
    periodeKe = widget.args.periodeKe;
    pertemuanKe = widget.args.pertemuanKe;

    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getDataTagihan/$pertemuanID');
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
                  const Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  ListTileArisan(
                    title: 'BCA',
                    onTap: () async {
                      Response<dynamic> resp = await NetUtil()
                          .dioClient
                          .post('/lotteryClubs/payment', data: {
                        'payment_type': 'bank_transfer',
                        'bank': 'bca',
                        'id_bill': dataPembayaran!.id.toString(),
                      });
                      LotteryClubPeriodDetailBill data =
                          LotteryClubPeriodDetailBill.fromData(resp.data);
                      PembayaranIuranArisanPage2Arguments args =
                          PembayaranIuranArisanPage2Arguments(
                              periodeKe: periodeKe,
                              pertemuanKe: pertemuanKe,
                              dataPembayaran: dataPembayaran!);
                      Navigator.popAndPushNamed(
                          context, PembayaranIuranArisanPage2.id,
                          arguments: args);
                    },
                  ),
                  const Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  ListTileArisan(
                    title: 'BNI',
                    onTap: () {},
                  ),
                  const Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  ListTileArisan(
                    title: 'BRI',
                    onTap: () {},
                  ),
                  const Divider(
                    height: 0,
                    thickness: 2,
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
