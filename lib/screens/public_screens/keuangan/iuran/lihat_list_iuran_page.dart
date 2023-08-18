import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_list_iuran_page_detail.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_4.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_1.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';

class LihatListIuranPage extends StatefulWidget {
  static const String id = 'LihatListIuranPage';
  const LihatListIuranPage({Key? key}) : super(key: key);

  @override
  State<LihatListIuranPage> createState() => LihatListIuranPageState();
}

class LihatListIuranPageState extends State<LihatListIuranPage> {
  User user = AuthProvider.currentUser!;

  void getData() async {
    await context
        .read<AreaBillProvider>()
        .getAreaBillByAreaID(areaID: user.area_id!);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AreaBill> listIuran = context.watch<AreaBillProvider>().listAreaBill;
    return Scaffold(
      appBar: AppBar(
        title: Text('Lihat Semua Iuran'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, int) {
          return Divider(
            color: smartRTPrimaryColor,
            height: 5,
            thickness: 1,
          );
        },
        itemCount: listIuran.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: paddingCard,
                child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, LihatListIuranPageDetail.id,
                          arguments:
                              LihatListIuranPageDetailArguments(index: index));
                    },
                    title: Text(
                      'Iuran ${listIuran[index].name}',
                      style: smartRTTextTitleCard,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                            'Tagihan : ${CurrencyFormat.convertToIdr(listIuran[index].bill_amount, 2)}'),
                        Text(listIuran[index].is_repeated == 0
                            ? 'Tagihan Sekali Bayar (${listIuran[index].payer_total - listIuran[index].payer_count != 0 ? '${listIuran[index].payer_total - listIuran[index].payer_count} orang belum bayar' : 'Semua sudah bayar'})'
                            : listIuran[index].status == 1
                                ? 'Tagihan Bulanan (Aktif)'
                                : 'Tagihan Bulanan (Tidak Aktif)'),
                      ],
                    )),
              ),
              if (index == listIuran.length - 1)
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 1,
                  height: 5,
                ),
            ],
          );
        },
      ),
    );
  }
}
