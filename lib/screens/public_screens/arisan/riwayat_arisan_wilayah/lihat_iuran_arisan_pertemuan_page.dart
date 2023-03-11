import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/screens/public_screens/arisan/detail_iuran_arisan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_2.dart';

class LihatIuranArisanPageArguments {
  String idPertemuan;
  String pertemuanKe;
  LihatIuranArisanPageArguments(
      {required this.idPertemuan, required this.pertemuanKe});
}

class LihatIuranArisanPertemuanPage extends StatefulWidget {
  static const String id = 'LihatIuranArisanPertemuanPage';
  LihatIuranArisanPageArguments args;
  LihatIuranArisanPertemuanPage({Key? key, required this.args})
      : super(key: key);

  @override
  State<LihatIuranArisanPertemuanPage> createState() =>
      _LihatIuranArisanPertemuanPageState();
}

class _LihatIuranArisanPertemuanPageState
    extends State<LihatIuranArisanPertemuanPage> {
  String idPertemuan = '';
  String pertemuanKe = '';
  List<LotteryClubPeriodDetailBill> listDataPembayaran = [];

  void getData() async {
    idPertemuan = widget.args.idPertemuan;
    pertemuanKe = widget.args.pertemuanKe;

    Response<dynamic> resp =
        await NetUtil().dioClient.get('/lotteryClubs/payment/all/$idPertemuan');

    listDataPembayaran
        .addAll((resp.data).map<LotteryClubPeriodDetailBill>((request) {
      return LotteryClubPeriodDetailBill.fromData(request);
    }));

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
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Padding(
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
              itemCount: listDataPembayaran.length,
              itemBuilder: (context, index) {
                return ListTileUser2(
                  photoPathURL:
                      '${backendURL}/public/uploads/users/${listDataPembayaran[index].data_user!.id}/profile_picture/',
                  photo: listDataPembayaran[index].data_user!.photo_profile_img,
                  initialName: StringFormat.initialName(
                      listDataPembayaran[index].data_user!.full_name),
                  fullName: listDataPembayaran[index].data_user!.full_name,
                  address:
                      listDataPembayaran[index].data_user!.address.toString(),
                  tileColor: listDataPembayaran[index].status == 0
                      ? smartRTErrorColor
                      : smartRTSuccessColor,
                  paymentDate: listDataPembayaran[index].updated_at == null
                      ? ''
                      : DateFormat('d MMMM y')
                          .format(listDataPembayaran[index].updated_at!),
                  via: listDataPembayaran[index].status == 0
                      ? ''
                      : listDataPembayaran[index].payment_type,
                  onTap: () {
                    DetailIuranArisanArguments arguments =
                        DetailIuranArisanArguments(
                            dataPembayaran: listDataPembayaran[index],
                            pertemuanKe: pertemuanKe);
                    Navigator.pushNamed(context, DetailIuranArisanPage.id,
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
