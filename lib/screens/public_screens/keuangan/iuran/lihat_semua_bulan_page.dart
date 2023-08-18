import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_repeat_detail.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_transaction.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_semua_pembayar_page.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_2.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_semua_pembayar_page_detail.dart';

class LihatSemuaBulanPageArguments {
  AreaBill dataAreaBill;
  LihatSemuaBulanPageArguments({
    required this.dataAreaBill,
  });
}

class LihatSemuaBulanPage extends StatefulWidget {
  static const String id = 'LihatSemuaBulanPage';
  LihatSemuaBulanPageArguments args;
  LihatSemuaBulanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<LihatSemuaBulanPage> createState() => _LihatSemuaBulanPageState();
}

class _LihatSemuaBulanPageState extends State<LihatSemuaBulanPage> {
  User user = AuthProvider.currentUser!;

  void getData() async {
    AreaBill dataAreaBill = widget.args.dataAreaBill;
    await context
        .read<AreaBillProvider>()
        .getAreaBillRepeatDetailByAreaBillID(areaBillID: dataAreaBill.id);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AreaBillRepeatDetail> listBulanan =
        context.watch<AreaBillProvider>().listBulanan;
    AreaBill dataAreaBill = widget.args.dataAreaBill;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Container(
            color: smartRTSecondaryColor,
            width: double.infinity,
            padding: paddingScreen,
            child: Column(
              children: [
                Text(
                  'IURAN'.toUpperCase(),
                  style: smartRTTextTitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '"${dataAreaBill.name}"'.toUpperCase(),
                  style: smartRTTextTitleCard,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, int) {
                return Divider(
                  color: smartRTPrimaryColor,
                  height: 5,
                  thickness: 5,
                );
              },
              itemCount: listBulanan.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: paddingCard,
                      child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                                context, LihatSemuaPembayarPage.id,
                                arguments: LihatSemuaPembayarPageArguments(
                                    dataAreaBill: dataAreaBill,
                                    areaBillRepeatDetailID:
                                        listBulanan[index].id));
                          },
                          title: Text(
                            StringFormat.formatDate(
                                    dateTime: listBulanan[index].month_year,
                                    formatDate: 'MMMM y')
                                .toUpperCase(),
                            style: smartRTTextTitleCard,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                  'Tagihan : ${CurrencyFormat.convertToIdr(listBulanan[index].bill_amount, 2)}'),
                              Text((listBulanan[index].payer_total -
                                          listBulanan[index].payer_count !=
                                      0)
                                  ? '${listBulanan[index].payer_total - listBulanan[index].payer_count} dari ${listBulanan[index].payer_total} orang belum bayar'
                                  : 'Semua sudah bayar'),
                              Text(dataAreaBill.status == 1
                                  ? 'Tagihan Bulanan (Aktif)'
                                  : 'Tagihan Bulanan (Tidak Aktif)'),
                            ],
                          )),
                    ),
                    if (index == listBulanan.length - 1)
                      Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
