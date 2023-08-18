import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/subscribe/pro_subscribe_bill.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/role_request_provider.dart';
import 'package:smart_rt/providers/subscribe_provider.dart';
import 'package:smart_rt/screens/admin_screens/request_role/detail_request_role_page.dart';
import 'package:smart_rt/screens/public_screens/langganan/langganan_page_detail_1.dart';
import 'package:smart_rt/screens/public_screens/langganan/langganan_page_detail_2.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';

class DaftarPelangganProBillPageArguments {
  int idArea;
  DaftarPelangganProBillPageArguments({required this.idArea});
}

class DaftarPelangganProBillPage extends StatefulWidget {
  static const String id = 'DaftarPelangganProBillPage';
  DaftarPelangganProBillPageArguments args;
  DaftarPelangganProBillPage({Key? key, required this.args}) : super(key: key);

  @override
  State<DaftarPelangganProBillPage> createState() =>
      _DaftarPelangganProBillPageState();
}

class _DaftarPelangganProBillPageState
    extends State<DaftarPelangganProBillPage> {
  User user = AuthProvider.currentUser!;
  void getData() async {
    await context
        .read<SubscribeProvider>()
        .getRiwayatTagihanByProSubscribeID(proSubscribeID: widget.args.idArea);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProSubscribeBill> listRiwayatTagihan = [];
    listRiwayatTagihan = context.watch<SubscribeProvider>().riwayatTagihan;

    return Scaffold(
        appBar: AppBar(
          title: Text('Riwayat Tagihan dan Pembayaran'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, int) {
            return Divider(
              color: smartRTPrimaryColor,
              thickness: 1,
              height: 5,
            );
          },
          itemCount: listRiwayatTagihan.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                CardListTileWithStatusColor(
                    title:
                        'Tagihan ${DateFormat('MMMM y', 'id_ID').format(listRiwayatTagihan[index].created_at)}',
                    subtitle:
                        'Jumlah : ${CurrencyFormat.convertToIdr(listRiwayatTagihan[index].bill_amount, 2)}',
                    bottomText: listRiwayatTagihan[index].status == 0
                        ? 'Menunggu Pembayaran'
                        : 'Selesai',
                    statusColor: listRiwayatTagihan[index].status == 0
                        ? smartRTStatusRedColor
                        : smartRTStatusGreenColor,
                    onTap: () {
                      if (listRiwayatTagihan[index]
                              .midtrans_transaction_status ==
                          'pending') {
                        // Navigator.pushNamed(context, DaftarPelangganProBillPageDetail2.id,
                        //     arguments:
                        //         DaftarPelangganProBillPageDetail2Arguments(index: index));
                      } else if (listRiwayatTagihan[index]
                              .midtrans_transaction_status ==
                          'settlement') {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              'Hai Sobat Pintar,',
                              style: smartRTTextTitleCard,
                            ),
                            content: Text(
                              'Pembayaran anda telah berhasil dan lunas pada tanggal ${DateFormat('d MMMM y HH:mm', 'id_ID').format(listRiwayatTagihan[index].updated_at ?? DateTime.now())}',
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
                      } else {
                        // Navigator.pushNamed(context, DaftarPelangganProBillPageDetail1.id,
                        //     arguments:
                        //         DaftarPelangganProBillPageDetail1Arguments(index: index));
                      }
                    }),
                if (index == listRiwayatTagihan.length - 1)
                  Divider(
                    color: smartRTPrimaryColor,
                    thickness: 1,
                    height: 5,
                  ),
              ],
            );
          },
        ));
  }
}
