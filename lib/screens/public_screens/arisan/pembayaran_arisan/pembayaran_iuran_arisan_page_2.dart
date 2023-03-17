import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_arisan/pembayaran_iuran_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_detail_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';

class PembayaranIuranArisanPage2Arguments {
  LotteryClubPeriodDetailBill dataPembayaran;
  LotteryClubPeriodDetail dataPertemuan;
  String periodeKe;
  String pertemuanKe;
  String typeFrom;
  PembayaranIuranArisanPage2Arguments({
    required this.periodeKe,
    required this.pertemuanKe,
    required this.dataPembayaran,
    required this.dataPertemuan,
    required this.typeFrom,
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
  LotteryClubPeriodDetail? dataPertemuan;

  void batalkanPembayaran() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.patch('/lotteryClubs/payment/cancel', data: {
      "id_bill": dataPembayaran!.id,
    });
    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);

      PembayaranIuranArisanPage1Arguments args =
          PembayaranIuranArisanPage1Arguments(
              typeFrom: widget.args.typeFrom,
              periodeKe: periodeKe,
              pertemuanKe: pertemuanKe,
              dataPertemuan: dataPertemuan!);
      Navigator.pushNamed(context, PembayaranIuranArisanPage1.id,
          arguments: args);

      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  void cekStatusPembayaran() async {
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/payment/idPayment/${dataPembayaran!.id}');
    LotteryClubPeriodDetailBill dataPembayaranNew =
        LotteryClubPeriodDetailBill.fromData(resp.data);

    if (dataPembayaranNew.midtrans_transaction_status == 'settlement') {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Pembayaran anda telah berhasil dan lunas pada tanggal ${DateFormat('d MMMM y HH:mm', 'id_ID').format(dataPembayaranNew.updated_at!)}',
            style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                if (widget.args.typeFrom.toLowerCase() == 'riwayat') {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  RiwayatArisanPertemuanArguments arguments =
                      RiwayatArisanPertemuanArguments(
                    idPeriode:
                        dataPertemuan!.lottery_club_period_id!.id.toString(),
                    periodeKe: dataPertemuan!.lottery_club_period_id!.period
                        .toString(),
                    dataPeriodeArisan: dataPertemuan!.lottery_club_period_id!,
                  );
                  Navigator.pushNamed(context, RiwayatArisanPertemuanPage.id,
                      arguments: arguments);
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }

                Response<dynamic> respPertemuanBaru = await NetUtil().dioClient.get(
                    '/lotteryClubs/get/meet/id-pertemuan/${dataPertemuan!.id}');
                LotteryClubPeriodDetail dataPertemuanBaru =
                    LotteryClubPeriodDetail.fromData(respPertemuanBaru.data);

                RiwayatArisanPertemuanDetailArguments arguments2 =
                    RiwayatArisanPertemuanDetailArguments(
                  dataPertemuan: dataPertemuanBaru,
                  periodeKe: dataPertemuanBaru.period_ke.toString(),
                  pertemuanKe: dataPertemuanBaru.pertemuan_ke.toString(),
                  typeFrom: widget.args.typeFrom,
                  dataPeriodeArisan: dataPertemuanBaru.lottery_club_period_id!,
                );
                Navigator.pushNamed(
                    context, RiwayatArisanPertemuanDetailPage.id,
                    arguments: arguments2);
              },
              child: Text(
                'OK',
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Pembayaran anda belum diterima! Segera bayarkan tagihan anda!',
            style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    }
  }

  void getData() async {
    setState(() {
      dataPembayaran = widget.args.dataPembayaran;
      dataPertemuan = widget.args.dataPertemuan;
      periodeKe = widget.args.periodeKe;
      pertemuanKe = widget.args.pertemuanKe;

      datetimeBayarSebelum = DateFormat('d MMMM y H:m', 'id_ID')
          .format(dataPembayaran!.midtrans_expired_at!);
      vaNum = dataPembayaran!.va_num ?? '';
      totalTagihan =
          CurrencyFormat.convertToIdr(dataPembayaran!.bill_amount, 2);
      status = (dataPembayaran!.midtrans_transaction_status == 'pending')
          ? 'Menunggu Pembayaran'
          : '';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
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
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
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
                children: [
                  Text(
                    'VIRTUAL ACCOUNT',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
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
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SB_height50,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    cekStatusPembayaran();
                  },
                  child: Text(
                    'CEK STATUS PEMBAYARAN',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
              SB_height15,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: smartRTTertiaryColor,
                  ),
                  onPressed: () async {
                    batalkanPembayaran();
                  },
                  child: Text(
                    'BATALKAN PEMBAYARAN',
                    style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: smartRTSecondaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
