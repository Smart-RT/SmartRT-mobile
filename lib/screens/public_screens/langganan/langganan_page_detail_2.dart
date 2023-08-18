import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/subscribe/pro_subscribe_bill.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/subscribe_provider.dart';
import 'package:smart_rt/screens/public_screens/langganan/langganan_page.dart';
import 'package:smart_rt/screens/public_screens/langganan/langganan_page_detail_1.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:provider/provider.dart';

class LanggananPageDetail2Arguments {
  int index;
  LanggananPageDetail2Arguments({
    required this.index,
  });
}

class LanggananPageDetail2 extends StatefulWidget {
  static const String id = 'LanggananPageDetail2';
  LanggananPageDetail2Arguments args;
  LanggananPageDetail2({Key? key, required this.args}) : super(key: key);

  @override
  State<LanggananPageDetail2> createState() => _LanggananPageDetail2State();
}

class _LanggananPageDetail2State extends State<LanggananPageDetail2> {
  User user = AuthProvider.currentUser!;
  void konfirmasiBatalkanPembayaran(
      {required ProSubscribeBill dataTagihan, required int index}) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin untuk membatalkan metode pembayaran ini?',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(
                  'Tidak',
                  style:
                      smartRTTextNormal.copyWith(color: smartRTStatusRedColor),
                ),
              ),
              TextButton(
                onPressed: () async {
                  batalkanPembayaran(dataTagihan: dataTagihan, index: index);
                },
                child: Text(
                  'IYA',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void batalkanPembayaran(
      {required ProSubscribeBill dataTagihan, required int index}) async {
    bool isSuccess = await context
        .read<SubscribeProvider>()
        .batalkanMetodePembayaran(
            idProSubscribeBill: dataTagihan.id, index: index);
    if (isSuccess) {
      await context
          .read<SubscribeProvider>()
          .getRiwayatTagihanByAreaID(areaID: user.area!.id);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, LanggananPageDetail1.id,
          arguments: LanggananPageDetail1Arguments(index: index));
      SmartRTSnackbar.show(context,
          message: 'Berhasil membatalkan metode pembayaran!',
          backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: 'Error! Cobalah beberapa saat lagi!',
          backgroundColor: smartRTErrorColor);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.args.index;
    ProSubscribeBill dataTagihan =
        context.watch<SubscribeProvider>().riwayatTagihan[index];
    debugPrint('dataTagihan.midtrans_expired_at.toString()');
    debugPrint(dataTagihan.midtrans_expired_at.toString());
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
                'PEMBAYARAN SMART RT PRO',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              Text(
                'TAGIHAN ${DateFormat('MMMM y', 'id_ID').format(dataTagihan.created_at)}',
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
                    StringFormat.formatDate(
                        dateTime:
                            dataTagihan.midtrans_expired_at ?? DateTime.now()),
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
                    CurrencyFormat.convertToIdr(dataTagihan.bill_amount, 2),
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
                        dataTagihan.va_num!,
                        style: smartRTTextTitle,
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.copy,
                          color: smartRTPrimaryColor,
                        ),
                        onTap: () {
                          Clipboard.setData(
                              ClipboardData(text: dataTagihan.va_num!));
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
                'Status : ${dataTagihan.midtrans_transaction_status == 'pending' ? 'Menunggu Pembayaran' : '-'}',
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
                    Response<dynamic> resp = await NetUtil()
                        .dioClient
                        .get('/subscribe-pro/bill/get/${dataTagihan.id}');
                    ProSubscribeBill dataBaru =
                        ProSubscribeBill.fromData(resp.data);
                    if (dataBaru.midtrans_transaction_status == 'settlement') {
                      // ignore: use_build_context_synchronously
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(
                            'Hai Sobat Pintar,',
                            style: smartRTTextTitleCard,
                          ),
                          content: Text(
                            'Pembayaran anda telah berhasil dan lunas pada tanggal ${DateFormat('d MMMM y HH:mm', 'id_ID').format(dataBaru.updated_at ?? DateTime.now())}',
                            style: smartRTTextNormal.copyWith(
                                fontWeight: FontWeight.normal),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                                Navigator.pushNamed(context, LanggananPage.id);
                              },
                              child: Text(
                                'OK',
                                style: smartRTTextNormal.copyWith(
                                    fontWeight: FontWeight.bold),
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
                            'Anda belum membayar tagihan anda!',
                            style: smartRTTextNormal.copyWith(
                                fontWeight: FontWeight.normal),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
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
                    konfirmasiBatalkanPembayaran(
                        dataTagihan: dataTagihan, index: index);
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
