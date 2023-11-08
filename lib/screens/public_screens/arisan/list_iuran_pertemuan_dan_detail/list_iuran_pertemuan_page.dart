import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/screens/public_screens/arisan/list_iuran_pertemuan_dan_detail/list_iuran_pertemuan_detail_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_2.dart';

class ListIuranPertemuanArgument {
  String idPertemuan;
  String pertemuanKe;
  String typeFrom;
  LotteryClubPeriodDetail dataPertemuan;
  ListIuranPertemuanArgument({
    required this.idPertemuan,
    required this.pertemuanKe,
    required this.typeFrom,
    required this.dataPertemuan,
  });
}

class ListIuranPertemuanPage extends StatefulWidget {
  static const String id = 'ListIuranPertemuanPage';
  ListIuranPertemuanArgument args;
  ListIuranPertemuanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<ListIuranPertemuanPage> createState() => _ListIuranPertemuanPageState();
}

class _ListIuranPertemuanPageState extends State<ListIuranPertemuanPage> {
  String idPertemuan = '';
  String pertemuanKe = '';
  List<LotteryClubPeriodDetailBill> listDataPembayaran = [];
  User user = AuthProvider.currentUser!;

  // filters
  TextEditingController _nameFilter = TextEditingController();
  bool sudahBayarFilter = true;
  bool belumBayarFilter = true;

  void getData() async {
    idPertemuan = widget.args.idPertemuan;
    pertemuanKe = widget.args.pertemuanKe;

    Response<dynamic> resp =
        await NetUtil().dioClient.get('/lotteryClubs/payment/all/$idPertemuan');

    listDataPembayaran
        .addAll((resp.data).map<LotteryClubPeriodDetailBill>((request) {
      return LotteryClubPeriodDetailBill.fromData(request);
    }));

    debugPrint(listDataPembayaran[0].status.toString());
    debugPrint(listDataPembayaran[0].midtrans_transaction_status);
    debugPrint(listDataPembayaran[0].payment_type);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<LotteryClubPeriodDetailBill> listDataPembayaranFiltered = [];
    listDataPembayaran.forEach((element) {
      if (((sudahBayarFilter && element.updated_at != null) ||
              (belumBayarFilter && element.updated_at == null)) &&
          (_nameFilter.text.isNotEmpty &&
                  element.data_user!.full_name
                      .toUpperCase()
                      .contains(_nameFilter.text.toUpperCase()) ||
              _nameFilter.text.isEmpty)) {
        listDataPembayaranFiltered.add(element);
      }
    });
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
                  'IURAN ARISAN',
                  style: smartRTTextTitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'PERTEMUAN KE $pertemuanKe',
                  style: smartRTTextLarge,
                  textAlign: TextAlign.center,
                ),
                SB_height15,
                Container(
                  width: double.infinity,
                  child: Text('Filter:', style: smartRTTextNormalBold_Primary),
                ),
                Container(
                  width: double.infinity,
                  child: Wrap(
                    spacing: 15,
                    children: [
                      Container(
                          child: TextField(
                              controller: _nameFilter,
                              onChanged: (value) => setState(() {}),
                              decoration: InputDecoration(hintText: 'Nama'))),
                      GestureDetector(
                        onTap: () => setState(
                            () => sudahBayarFilter = !sudahBayarFilter),
                        child: Chip(
                          label: Text('Sudah Bayar'),
                          backgroundColor: sudahBayarFilter
                              ? smartRTActiveColor
                              : Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(
                            () => belumBayarFilter = !belumBayarFilter),
                        child: Chip(
                          label: Text('Belum Bayar'),
                          backgroundColor: belumBayarFilter
                              ? smartRTActiveColor
                              : Colors.grey,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: listDataPembayaranFiltered.length <= 0
                ? Container(
                    child: Text("Tidak ada data..."),
                  )
                : ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        height: 5,
                        thickness: 5,
                      );
                    },
                    itemCount: listDataPembayaranFiltered.length,
                    itemBuilder: (context, index) {
                      return ListTileUser2(
                        photoPathURL:
                            '${backendURL}/public/uploads/users/${listDataPembayaranFiltered[index].data_user!.id}/profile_picture/',
                        photo: listDataPembayaranFiltered[index]
                            .data_user!
                            .photo_profile_img,
                        initialName: StringFormat.initialName(
                            listDataPembayaranFiltered[index]
                                .data_user!
                                .full_name),
                        fullName: listDataPembayaranFiltered[index]
                            .data_user!
                            .full_name,
                        address: listDataPembayaranFiltered[index]
                            .data_user!
                            .address
                            .toString(),
                        tileColor: listDataPembayaranFiltered[index].status == 0
                            ? smartRTErrorColor
                            : smartRTSuccessColor,
                        paymentDate: listDataPembayaranFiltered[index]
                                    .updated_at ==
                                null
                            ? ''
                            : DateFormat('d MMMM y', 'id_ID').format(
                                listDataPembayaranFiltered[index].updated_at!),
                        via: listDataPembayaranFiltered[index].status == 0
                            ? ''
                            : listDataPembayaranFiltered[index].payment_type ==
                                    'bank_transfer'
                                ? 'Transfer Bank (${listDataPembayaranFiltered[index].acquiring_bank!.toUpperCase()})'
                                : 'Tunai',
                        onTap: () {
                          ListIuranPertemuanDetailArgument arguments =
                              ListIuranPertemuanDetailArgument(
                                  dataPertemuan: widget.args.dataPertemuan,
                                  typeFrom: widget.args.typeFrom,
                                  dataPembayaran:
                                      listDataPembayaranFiltered[index],
                                  pertemuanKe: pertemuanKe);
                          Navigator.pushNamed(
                              context, ListIuranPertemuanDetailPage.id,
                              arguments: arguments);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
