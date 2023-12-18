import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_transaction.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/pembayaran_tf/pembayaran_tf_page_2.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class PembayaranTfPage1Arguments {
  int index;
  AreaBill dataAreaBill;
  PembayaranTfPage1Arguments({
    required this.index,
    required this.dataAreaBill,
  });
}

class PembayaranTfPage1 extends StatefulWidget {
  static const String id = 'PembayaranTfPage1';
  PembayaranTfPage1Arguments args;
  PembayaranTfPage1({Key? key, required this.args}) : super(key: key);

  @override
  State<PembayaranTfPage1> createState() => _PembayaranTfPage1State();
}

class _PembayaranTfPage1State extends State<PembayaranTfPage1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.args.index;
    AreaBill dataAreaBill = widget.args.dataAreaBill;
    AreaBillTransaction dataTagihan =
        context.watch<AreaBillProvider>().listPembayar[index];
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
                'PEMBAYARAN IURAN',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              Text(
                '"${dataAreaBill.name.toUpperCase()}"',
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
                      bool isSuccess = await context
                          .read<AreaBillProvider>()
                          .bayarTF(
                              areaBillID: dataTagihan.area_bill_id,
                              areaBillTransactionID: dataTagihan.id,
                              areaID: dataAreaBill.area_id,
                              bank: 'bca',
                              paymentType: 'bank_transfer');
                      if (isSuccess) {
                        Navigator.pop(context);

                        Navigator.pushNamed(context, PembayaranTfPage2.id,
                            arguments: PembayaranTfPage2Arguments(
                                index: index, dataAreaBill: dataAreaBill));
                      } else {
                        // ignore: use_build_context_synchronously
                        SmartRTSnackbar.show(context,
                            message: 'Gagal! Cobalah beberapa saat lagi!',
                            backgroundColor: smartRTErrorColor);
                      }
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
                      bool isSuccess = await context
                          .read<AreaBillProvider>()
                          .bayarTF(
                              areaBillID: dataTagihan.area_bill_id,
                              areaBillTransactionID: dataTagihan.id,
                              areaID: dataAreaBill.area_id,
                              bank: 'bni',
                              paymentType: 'bank_transfer');
                      if (isSuccess) {
                        Navigator.pop(context);

                        Navigator.pushNamed(context, PembayaranTfPage2.id,
                            arguments: PembayaranTfPage2Arguments(
                                index: index, dataAreaBill: dataAreaBill));
                      } else {
                        // ignore: use_build_context_synchronously
                        SmartRTSnackbar.show(context,
                            message: 'Gagal! Cobalah beberapa saat lagi!',
                            backgroundColor: smartRTErrorColor);
                      }
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
                      bool isSuccess = await context
                          .read<AreaBillProvider>()
                          .bayarTF(
                              areaBillID: dataTagihan.area_bill_id,
                              areaBillTransactionID: dataTagihan.id,
                              areaID: dataAreaBill.area_id,
                              bank: 'bri',
                              paymentType: 'bank_transfer');
                      if (isSuccess) {
                        Navigator.pop(context);

                        Navigator.pushNamed(context, PembayaranTfPage2.id,
                            arguments: PembayaranTfPage2Arguments(
                                index: index, dataAreaBill: dataAreaBill));
                      } else {
                        // ignore: use_build_context_synchronously
                        SmartRTSnackbar.show(context,
                            message: 'Gagal! Cobalah beberapa saat lagi!',
                            backgroundColor: smartRTErrorColor);
                      }
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
