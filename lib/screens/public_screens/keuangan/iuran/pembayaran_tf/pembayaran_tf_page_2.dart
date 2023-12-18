import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_transaction.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';

class PembayaranTfPage2Arguments {
  int index;
  AreaBill dataAreaBill;
  bool fromTagihanSaya;
  PembayaranTfPage2Arguments(
      {required this.index,
      required this.dataAreaBill,
      required this.fromTagihanSaya});
}

class PembayaranTfPage2 extends StatefulWidget {
  static const String id = 'PembayaranTfPage2';
  PembayaranTfPage2Arguments args;
  PembayaranTfPage2({Key? key, required this.args}) : super(key: key);

  @override
  State<PembayaranTfPage2> createState() => _PembayaranTfPage2State();
}

class _PembayaranTfPage2State extends State<PembayaranTfPage2> {
  void batalkanPembayaran(
      {required AreaBillTransaction dataTagihan, required int areaID}) async {
    bool isSuccess = await context.read<AreaBillProvider>().batalkanMetodeTF(
          areaBillID: dataTagihan.area_bill_id,
          areaID: areaID,
        );
    if (isSuccess) {
      Navigator.pop(context);
    } else {
      // ignore: use_build_context_synchronously
      SmartRTSnackbar.show(context,
          message: 'Gagal! Cobalah beberapa saat lagi!',
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
    AreaBill dataAreaBill = widget.args.dataAreaBill;
    AreaBillTransaction dataTagihan = widget.args.fromTagihanSaya
        ? context.watch<AreaBillProvider>().listTagihanKu[index]
        : context.watch<AreaBillProvider>().listPembayar[index];
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
                    'BAYAR SEBELUM',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    StringFormat.formatDate(
                        dateTime: dataTagihan.midtrans_expired_at!),
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
                        dataTagihan.va_num ?? '',
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
                              ClipboardData(text: dataTagihan.va_num));
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
                'Status : ${(dataTagihan.midtrans_transaction_status == 'pending') ? 'Menunggu Pembayaran' : ''}',
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
                    // cekStatusPembayaran();
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
                    batalkanPembayaran(
                        dataTagihan: dataTagihan, areaID: dataAreaBill.area_id);
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
