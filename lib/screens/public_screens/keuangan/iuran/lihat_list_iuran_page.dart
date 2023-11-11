import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_list_iuran_page_detail.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class LihatListIuranPage extends StatefulWidget {
  static const String id = 'LihatListIuranPage';
  const LihatListIuranPage({Key? key}) : super(key: key);

  @override
  State<LihatListIuranPage> createState() => LihatListIuranPageState();
}

class LihatListIuranPageState extends State<LihatListIuranPage> {
  User user = AuthProvider.currentUser!;
  int popupval = 0;

  Future<void> getData() async {
    context.read<AreaBillProvider>().futures[LihatListIuranPage.id] = context
        .read<AreaBillProvider>()
        .getAreaBillByAreaID(areaID: user.area_id!);
    context.read<AreaBillProvider>().updateListener();
    await context.read<AreaBillProvider>().futures[LihatListIuranPage.id];
  }

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
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lihat Semua Iuran'),
      ),
      body: RefreshIndicator(
        onRefresh: () => getData(),
        child: FutureBuilder(
            future: context
                .watch<AreaBillProvider>()
                .futures[LihatListIuranPage.id],
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  margin: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Text('Terjadi kesalahan, mohon refresh data...'),
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Text('Sedang mengambil data, mohon tunggu...'),
                    ],
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done &&
                  context.watch<AreaBillProvider>().listAreaBill.isEmpty) {
                return Container(
                  margin: EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Text('Belum ada iuran'),
                    ],
                  ),
                );
              }

              List<AreaBill> listIuran =
                  context.watch<AreaBillProvider>().listAreaBill;
              return ListView.separated(
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
                            trailing: listIuran[index].is_repeated == 1 &&
                                    listIuran[index].status == 1
                                ? PopupMenuButton(
                                    initialValue: popupval,
                                    onSelected: (value) {
                                      nonAktifkanIuran(
                                          context, listIuran[index]);
                                    },
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        child: Text('Nonaktifkan Iuran'),
                                        value: 1,
                                      )
                                    ],
                                  )
                                : null,
                            onTap: () {
                              Navigator.pushNamed(
                                  context, LihatListIuranPageDetail.id,
                                  arguments: LihatListIuranPageDetailArguments(
                                      index: index));
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
              );
            }),
      ),
    );
  }
}
