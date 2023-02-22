import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';

class PembayaranIuranArisanPage2Arguments {
  LotteryClubPeriodDetailBill dataPembayaran;
  String periodeKe;
  String pertemuanKe;
  PembayaranIuranArisanPage2Arguments({
    required this.periodeKe,
    required this.pertemuanKe,
    required this.dataPembayaran,
  });
}

class PembayaranIuranArisanPage2 extends StatefulWidget {
  static const String id = 'PembayaranIuranArisanPage2';
  PembayaranIuranArisanPage2Arguments args;
  PembayaranIuranArisanPage2({Key? key, required this.args}) : super(key: key);

  @override
  State<PembayaranIuranArisanPage2> createState() =>
      _PembayaranIuranArisanPage2State();
}

class _PembayaranIuranArisanPage2State
    extends State<PembayaranIuranArisanPage2> {
  String periodeKe = '';
  String pertemuanKe = '';
  String totalTagihan = '0';
  String vaNum = '';
  String status = '';
  String datetimeBayarSebelum = '';
  LotteryClubPeriodDetailBill? dataPembayaran;

  void getData() async {
    dataPembayaran = widget.args.dataPembayaran;
    periodeKe = widget.args.periodeKe;
    pertemuanKe = widget.args.pertemuanKe;

    datetimeBayarSebelum =
        DateFormat('d MMMM y H:m').format(dataPembayaran!.midtrans_expired_at!);
    vaNum = dataPembayaran!.va_num ?? '';
    totalTagihan = CurrencyFormat.convertToIdr(dataPembayaran!.bill_amount, 2);
    status = (dataPembayaran!.midtrans_transaction_status == 'pending')
        ? 'Menunggu Pembayaran'
        : '';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: paddingScreen,
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
                        'BAYAR SEBELUM',
                        style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        datetimeBayarSebelum,
                        style: smartRTTextTitleCard,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SB_height50,
                  Column(
                    children: [
                      Text(
                        'TOTAL TAGIHAN',
                        style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold),
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
                    children: [
                      Text(
                        'VIRTUAL ACCOUNT',
                        style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            vaNum,
                            style: smartRTTextTitle,
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.copy,
                              color: smartRTPrimaryColor,
                            ),
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: vaNum));
                              SmartRTSnackbar.show(context,
                                  message: 'Berhasil menyalin Virtual Account!',
                                  backgroundColor: smartRTSuccessColor);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SB_height50,
                  Text(
                    'Status : $status',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              onPressed: () async {},
              child: Text(
                'CEK STATUS PEMBAYARAN',
                style: smartRTTextLargeBold_Secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
