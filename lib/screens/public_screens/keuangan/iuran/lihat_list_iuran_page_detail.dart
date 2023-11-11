import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_semua_bulan_page.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_semua_pembayar_page.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';

class LihatListIuranPageDetailArguments {
  int index;
  LihatListIuranPageDetailArguments({required this.index});
}

class LihatListIuranPageDetail extends StatefulWidget {
  static const String id = 'LihatListIuranPageDetail';
  LihatListIuranPageDetailArguments args;
  LihatListIuranPageDetail({Key? key, required this.args}) : super(key: key);

  @override
  State<LihatListIuranPageDetail> createState() =>
      _LihatListIuranPageDetailState();
}

class _LihatListIuranPageDetailState extends State<LihatListIuranPageDetail> {
  void nonAktifkanIuran(BuildContext context, AreaBill bill) async {
    // show confirmasi
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menonaktifkan Iuran ${bill.name}?',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Batal');
                },
                child: Text(
                  'Batal',
                  style: smartRTTextNormal.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  bool success = await context
                      .read<AreaBillProvider>()
                      .nonAktifkanIuran(bill: bill);
                  if (success) {
                    SmartRTSnackbar.show(context,
                        message: 'Berhasil menonaktifkan iuran!',
                        backgroundColor: smartRTSuccessColor);
                    Navigator.pop(context);
                  } else {
                    SmartRTSnackbar.show(context,
                        message: 'Gagal menonaktifkan iuran',
                        backgroundColor: smartRTErrorColor);
                  }
                },
                child: Text(
                  'NONAKTIFKAN',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold, color: smartRTErrorColor2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.args.index;
    AreaBill dataIuran = context.watch<AreaBillProvider>().listAreaBill[index];

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: paddingScreen,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'DETAIL'.toUpperCase(),
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              Text(
                '"IURAN ${dataIuran.name}"'.toUpperCase(),
                style: smartRTTextTitleCard,
                textAlign: TextAlign.center,
              ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              ListTileData1(
                  txtLeft: 'Dibuat Tanngal',
                  txtRight:
                      StringFormat.formatDate(dateTime: dataIuran.created_at)),
              ListTileData1(
                  txtLeft: 'Dibuat Oleh',
                  txtRight: dataIuran.created_by!.full_name),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              ListTileData1(
                  txtLeft: 'Tipe',
                  txtRight: dataIuran.is_repeated == 0
                      ? 'Tagihan Sekali Bayar'
                      : 'Tagihan Bulanan'),
              ListTileData1(
                  txtLeft: 'Nominal Tagihan',
                  txtRight:
                      CurrencyFormat.convertToIdr(dataIuran.bill_amount, 2)),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              Text(
                dataIuran.is_repeated == 0
                    ? 'DATA PEMBAYARAN'
                    : 'DATA PEMBAYARAN BULAN INI',
                style: smartRTTextTitleCard,
                textAlign: TextAlign.left,
              ),
              SB_height5,
              ListTileData1(
                  txtLeft: 'Total Pembayar',
                  txtRight:
                      '${dataIuran.payer_count} dari ${dataIuran.payer_total} orang sudah bayar'),
              ListTileData1(
                  txtLeft: 'Jumlah Uang Diterima',
                  txtRight: CurrencyFormat.convertToIdr(
                      dataIuran.total_paid_amount, 2)),
              SB_height15,
              if (dataIuran.is_repeated == 0)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, LihatSemuaPembayarPage.id,
                          arguments: LihatSemuaPembayarPageArguments(
                              dataAreaBill: dataIuran));
                    },
                    child: Text(
                      'LIHAT SEMUA PEMBAYAR',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
              if (dataIuran.is_repeated == 1) ...[
                if (dataIuran.status == 1) ...[
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        nonAktifkanIuran(context, dataIuran);
                      },
                      child: Text(
                        'NONAKTIFKAN IURAN',
                        style: smartRTTextLargeBold_Secondary,
                      ),
                    ),
                  ),
                  SB_height15
                ],
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, LihatSemuaBulanPage.id,
                          arguments: LihatSemuaBulanPageArguments(
                              dataAreaBill: dataIuran));
                    },
                    child: Text(
                      'LIHAT SEMUA BULAN',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
