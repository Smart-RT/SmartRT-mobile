import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/subscribe/pro_subscribe_bill.dart';
import 'package:smart_rt/providers/subscribe_provider.dart';
import 'package:smart_rt/screens/public_screens/langganan/langganan_page_detail_2.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class LanggananPageDetail1Arguments {
  int index;
  LanggananPageDetail1Arguments({required this.index});
}

class LanggananPageDetail1 extends StatefulWidget {
  static const String id = 'LanggananPageDetail1';
  LanggananPageDetail1Arguments args;
  LanggananPageDetail1({Key? key, required this.args}) : super(key: key);

  @override
  State<LanggananPageDetail1> createState() => _LanggananPageDetail1State();
}

class _LanggananPageDetail1State extends State<LanggananPageDetail1> {
  void getData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.args.index;
    ProSubscribeBill dataTagihan =
        context.watch<SubscribeProvider>().riwayatTagihan[index];

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
                'PEMBAYARAN SMART RT PRO',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              Text(
                'TAGIHAN ${DateFormat('MMMM y', 'id_ID').format(dataTagihan.created_at)}'
                    .toUpperCase(),
                style: smartRTTextLarge,
                textAlign: TextAlign.center,
              ),
              SB_height15,
              Text(
                '*Anda harus membayarkan tagihan sebelum tanggal ${StringFormat.formatDate(dateTime: dataTagihan.created_at.add(Duration(days: 7)), isWithTime: false)}',
                style: smartRTTextNormal,
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
                    CurrencyFormat.convertToIdr(dataTagihan.bill_amount, 2),
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
                      bool isSuccess = await context
                          .read<SubscribeProvider>()
                          .pilihMetodePembayaran(
                              paymentType: 'bank_transfer',
                              bank: 'bca',
                              idProSubscribeBill: dataTagihan.id,
                              index: index);
                      if (isSuccess) {
                        Navigator.popAndPushNamed(
                            context, LanggananPageDetail2.id,
                            arguments:
                                LanggananPageDetail2Arguments(index: index));
                      } else {
                        SmartRTSnackbar.show(context,
                            message: 'Error! Cobalah beberapa saat lagi!',
                            backgroundColor: smartRTErrorColor);
                      }
                    },
                  ),
                  const Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  ListTileArisan(
                    title: 'BNI',
                    onTap: () async {
                      bool isSuccess = await context
                          .read<SubscribeProvider>()
                          .pilihMetodePembayaran(
                              paymentType: 'bank_transfer',
                              bank: 'bni',
                              idProSubscribeBill: dataTagihan.id,
                              index: index);
                      if (isSuccess) {
                        Navigator.pushNamed(context, LanggananPageDetail2.id,
                            arguments:
                                LanggananPageDetail2Arguments(index: index));
                      } else {
                        SmartRTSnackbar.show(context,
                            message: 'Error! Cobalah beberapa saat lagi!',
                            backgroundColor: smartRTErrorColor);
                      }
                    },
                  ),
                  const Divider(
                    height: 0,
                    thickness: 2,
                  ),
                  ListTileArisan(
                    title: 'BRI',
                    onTap: () async {
                      bool isSuccess = await context
                          .read<SubscribeProvider>()
                          .pilihMetodePembayaran(
                              paymentType: 'bank_transfer',
                              bank: 'bri',
                              idProSubscribeBill: dataTagihan.id,
                              index: index);
                      if (isSuccess) {
                        Navigator.pushNamed(context, LanggananPageDetail2.id,
                            arguments:
                                LanggananPageDetail2Arguments(index: index));
                      } else {
                        SmartRTSnackbar.show(context,
                            message: 'Error! Cobalah beberapa saat lagi!',
                            backgroundColor: smartRTErrorColor);
                      }
                    },
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
