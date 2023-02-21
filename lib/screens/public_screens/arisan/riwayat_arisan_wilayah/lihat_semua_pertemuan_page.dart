import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club_period_detail.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_pertemuan_arisan.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/detail_pertemuan_arisan_page.dart';
import 'package:intl/intl.dart';

class LihatSemuaPertemuanPageArguments {
  String idPeriode;
  String periodeKe;
  LihatSemuaPertemuanPageArguments(
      {required this.idPeriode, required this.periodeKe});
}

class LihatSemuaPertemuanPage extends StatefulWidget {
  static const String id = 'LihatSemuaPertemuanPage';
  LihatSemuaPertemuanPageArguments args;
  LihatSemuaPertemuanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<LihatSemuaPertemuanPage> createState() =>
      _LihatSemuaPertemuanPageState();
}

class _LihatSemuaPertemuanPageState extends State<LihatSemuaPertemuanPage> {
  List<LotteryClubPeriodDetail> listPertemuan = [];
  String idPeriode = '';
  String periodeKe = '';

  void getData() async {
    idPeriode = widget.args.idPeriode;
    periodeKe = widget.args.periodeKe;

    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getListPertemuanArisan/$idPeriode');
    listPertemuan.clear();
    listPertemuan.addAll((resp.data).map<LotteryClubPeriodDetail>((request) {
      return LotteryClubPeriodDetail.fromData(request);
    }));
    setState(() {});
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
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
              'LIST PERTEMUAN',
              style: smartRTTextTitle,
              textAlign: TextAlign.center,
            ),
            Text(
              'PERIODE KE ${periodeKe}',
              style: smartRTTextLarge,
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
                itemCount: listPertemuan.length,
                itemBuilder: (context, index) {
                  return CardListPertemuanArisan(
                    status: listPertemuan[index].status,
                    pertemuanKe: (index + 1).toString(),
                    jumlahAnggotaHadir:
                        listPertemuan[index].total_attendance.toString(),
                    tempatPelaksanaan: listPertemuan[index].meet_at.toString(),
                    tanggalPelaksanaan: DateFormat('d MMMM y')
                        .format(listPertemuan[index].meet_date),
                    waktuPelaksanaan: DateFormat('H:m')
                        .format(listPertemuan[index].meet_date),
                    onTap: () {
                      DetailPertemuanArisanPageArguments arguments =
                          DetailPertemuanArisanPageArguments(
                              dataPertemuan: listPertemuan[index],
                              periodeKe: periodeKe,
                              pertemuanKe: (index + 1).toString());
                      Navigator.pushNamed(context, DetailPertemuanArisanPage.id,
                          arguments: arguments);
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
