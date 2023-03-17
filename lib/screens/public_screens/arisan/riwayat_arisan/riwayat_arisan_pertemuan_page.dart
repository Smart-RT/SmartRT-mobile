import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_pertemuan_arisan.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_detail_page.dart';
import 'package:intl/intl.dart';

class RiwayatArisanPertemuanArguments {
  String idPeriode;
  String periodeKe;
  LotteryClubPeriod dataPeriodeArisan;
  RiwayatArisanPertemuanArguments({
    required this.idPeriode,
    required this.periodeKe,
    required this.dataPeriodeArisan,
  });
}

class RiwayatArisanPertemuanPage extends StatefulWidget {
  static const String id = 'RiwayatArisanPertemuanPage';
  RiwayatArisanPertemuanArguments args;
  RiwayatArisanPertemuanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<RiwayatArisanPertemuanPage> createState() =>
      _RiwayatArisanPertemuanPageState();
}

class _RiwayatArisanPertemuanPageState
    extends State<RiwayatArisanPertemuanPage> {
  List<LotteryClubPeriodDetail> listPertemuan = [];
  String idPeriode = '';
  String periodeKe = '';
  User user = AuthProvider.currentUser!;

  void getData() async {
    idPeriode = widget.args.idPeriode;
    periodeKe = widget.args.periodeKe;

    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/get/meets/id-periode/$idPeriode');
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
            (listPertemuan.length == 1 &&
                    user.user_role == Role.Warga &&
                    listPertemuan[0].status == 'Unpublished')
                ? Expanded(
                    child: Center(
                      child: Text(
                        'Belum ada Riwayat Pertemuan',
                        style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Expanded(
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
                          statusColor:
                              listPertemuan[index].status == 'Unpublished'
                                  ? smartRTStatusYellowColor
                                  : listPertemuan[index].status == 'Published'
                                      ? smartRTStatusGreenColor
                                      : smartRTSecondaryColor,
                          pertemuanKe: (index + 1).toString(),
                          jumlahAnggotaHadir:
                              '${listPertemuan[index].total_attendance.toString()} orang',
                          tempatPelaksanaan:
                              listPertemuan[index].meet_at ?? '-',
                          tanggalPelaksanaan: DateFormat('d MMMM y', 'id_ID')
                              .format(listPertemuan[index].meet_date),
                          waktuPelaksanaan: DateFormat('H:m')
                              .format(listPertemuan[index].meet_date),
                          onTap: listPertemuan[index].status == 'Unpublished'
                              ? () async {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text(
                                        'Hai Sobat Pintar,',
                                        style: smartRTTextTitleCard,
                                      ),
                                      content: Text(
                                        'Anda dapat mengatur pertemuan dan mempublikasikan dengan memilih "BUAT PERTEMUAN SELANJUTNYA" di halaman utama arisan ',
                                        style: smartRTTextNormal.copyWith(
                                            fontWeight: FontWeight.normal),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: Text(
                                            'OK',
                                            style: smartRTTextNormal.copyWith(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              : () {
                                  RiwayatArisanPertemuanDetailArguments
                                      arguments =
                                      RiwayatArisanPertemuanDetailArguments(
                                    dataPertemuan: listPertemuan[index],
                                    periodeKe: periodeKe,
                                    pertemuanKe: (index + 1).toString(),
                                    typeFrom: 'Riwayat',
                                    dataPeriodeArisan:
                                        widget.args.dataPeriodeArisan,
                                  );
                                  Navigator.pushNamed(context,
                                      RiwayatArisanPertemuanDetailPage.id,
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
