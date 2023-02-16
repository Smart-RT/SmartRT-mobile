import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club_period.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/detail_riwayat_arisan_wilayah_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_riwayat_arisan_wilayah.dart';

class RiwayatArisanWilayahPage extends StatefulWidget {
  static const String id = 'RiwayatArisanWilayahPage';
  const RiwayatArisanWilayahPage({Key? key}) : super(key: key);

  @override
  State<RiwayatArisanWilayahPage> createState() =>
      _RiwayatArisanWilayahPageState();
}

class _RiwayatArisanWilayahPageState extends State<RiwayatArisanWilayahPage> {
  User user = AuthProvider.currentUser!;
  List<LotteryClubPeriod> listPeriodeArisan = [];

  void getData() async {
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getListPeriodeArisan/${user.area!.id}');
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
              'RIWAYAT ARISAN WILAYAH',
              style: smartRTTextTitle,
              textAlign: TextAlign.center,
            ),
            SB_height30,
            Expanded(
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
                        ? smartRTSuccessColor
                        : smartRTSecondaryColor,
                    totalPertemuan:
                        '${listPeriodeArisan[index].total_meets}x (${listPeriodeArisan[index].year_limit == 0 ? '6 bulan' : '${listPeriodeArisan[index].year_limit.toString()} tahun'})',
                    totalAnggota:
                        '${listPeriodeArisan[index].total_members} orang',
                    iuran: 'IDR ${listPeriodeArisan[index].bill_amount},00',
                    onTap: () async {
                      DetailRiwayatArisanWilayahArguments args =
                          DetailRiwayatArisanWilayahArguments(
                              dataPeriodeArisan: listPeriodeArisan[index]);
                      Navigator.pushNamed(
                          context, DetailRiwayatArisanWilayah.id,
                          arguments: args);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
