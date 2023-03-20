import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_periode_detail_page.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_riwayat_arisan_wilayah.dart';

class RiwayatArisanPeriodeArguments {
  String type;
  RiwayatArisanPeriodeArguments({
    required this.type,
  });
}

class RiwayatArisanPeriodePage extends StatefulWidget {
  static const String id = 'RiwayatArisanPeriodePage';
  RiwayatArisanPeriodeArguments args;
  RiwayatArisanPeriodePage({Key? key, required this.args}) : super(key: key);

  @override
  State<RiwayatArisanPeriodePage> createState() =>
      _RiwayatArisanPeriodePageState();
}

class _RiwayatArisanPeriodePageState extends State<RiwayatArisanPeriodePage> {
  User user = AuthProvider.currentUser!;
  String type = '';
  List<LotteryClubPeriod> listPeriodeArisan = [];

  void getData() async {
    type = widget.args.type.toLowerCase();
    Response<dynamic> resp =
        await NetUtil().dioClient.get('/lotteryClubs/get/periods');
    listPeriodeArisan.clear();
    listPeriodeArisan.addAll((resp.data).map<LotteryClubPeriod>((request) {
      return LotteryClubPeriod.fromData(request);
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
      body: Padding(
        padding: paddingScreen,
        child: Column(
          children: [
            Text(
              'RIWAYAT ARISAN $type'.toUpperCase(),
              style: smartRTTextTitle,
              textAlign: TextAlign.center,
            ),
            // SB_height30,
            Divider(
              height: 50,
              thickness: 2,
            ),
            listPeriodeArisan.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, int) {
                        return Divider(
                          color: smartRTPrimaryColor,
                          height: 5,
                        );
                      },
                      itemCount: listPeriodeArisan.length,
                      itemBuilder: (context, index) {
                        return CardRiwayatArisanWilayah(
                          periodeKe: listPeriodeArisan[index].period.toString(),
                          status: listPeriodeArisan[index].meet_ctr <
                                  listPeriodeArisan[index].total_meets
                              ? 'Berlangsung'
                              : 'Selesai',
                          statusTextColor: listPeriodeArisan[index].meet_ctr <
                                  listPeriodeArisan[index].total_meets
                              ? smartRTStatusYellowColor
                              : smartRTQuaternaryColor,
                          totalPertemuan:
                              '${listPeriodeArisan[index].total_meets}x (${listPeriodeArisan[index].year_limit == 0 ? '6 bulan' : '${listPeriodeArisan[index].year_limit.toString()} tahun'})',
                          totalAnggota:
                              '${listPeriodeArisan[index].total_members} orang',
                          iuran: CurrencyFormat.convertToIdr(
                              listPeriodeArisan[index].bill_amount, 2),
                          onTap: () async {
                            RiwayatArisanPeriodeDetailArguments args =
                                RiwayatArisanPeriodeDetailArguments(
                              dataPeriodeArisan: listPeriodeArisan[index],
                            );
                            Navigator.pushNamed(
                                context, RiwayatArisanPeriodeDetailPage.id,
                                arguments: args);
                          },
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        'Tidak ada Riwayat Arisan',
                        style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
