import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/anggota_periode/anggota_periode_page.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_2.dart';

class RiwayatArisanPeriodeDetailArguments {
  LotteryClubPeriod dataPeriodeArisan;
  RiwayatArisanPeriodeDetailArguments({required this.dataPeriodeArisan});
}

class RiwayatArisanPeriodeDetailPage extends StatefulWidget {
  static const String id = 'RiwayatArisanPeriodeDetailPage';
  RiwayatArisanPeriodeDetailArguments args;
  RiwayatArisanPeriodeDetailPage({Key? key, required this.args})
      : super(key: key);

  @override
  State<RiwayatArisanPeriodeDetailPage> createState() =>
      _RiwayatArisanPeriodeDetailPageState();
}

class _RiwayatArisanPeriodeDetailPageState
    extends State<RiwayatArisanPeriodeDetailPage> {
  LotteryClubPeriod? dataPeriodeArisan;
  String periodeKe = '';
  String pertemuanPertama = '';
  String pertemuanTerakhir = '';
  String jumlahPertemuan = '';
  String yearLimit = '';
  String jumlahAnggota = '';
  String iuranPertemuan = '';
  String hadiahPemenang = '';
  String status = '';
  Color statusColor = smartRTPrimaryColor;

  void getData() async {
    dataPeriodeArisan = widget.args.dataPeriodeArisan;
    periodeKe = dataPeriodeArisan!.period.toString();
    DateTime date = dataPeriodeArisan!.started_at;
    DateTime pertemuanTerakhirDate = dataPeriodeArisan!.year_limit == 0
        ? DateTime(date.year, date.month + 6, date.day)
        : DateTime(
            date.year + dataPeriodeArisan!.year_limit, date.month, date.day);
    pertemuanPertama =
        DateFormat('d MMMM y', 'id_ID').format(dataPeriodeArisan!.started_at);
    pertemuanTerakhir =
        DateFormat('MMMM y', 'id_ID').format((pertemuanTerakhirDate));
    yearLimit = dataPeriodeArisan!.year_limit == 0
        ? '6 bulan'
        : '${dataPeriodeArisan!.year_limit.toString()} tahun';
    jumlahPertemuan =
        '${dataPeriodeArisan!.total_meets.toString()}x (${yearLimit})';
    jumlahAnggota = '${dataPeriodeArisan!.total_members} orang';
    iuranPertemuan =
        CurrencyFormat.convertToIdr(dataPeriodeArisan!.bill_amount, 2);
    hadiahPemenang =
        CurrencyFormat.convertToIdr(dataPeriodeArisan!.winner_bill_amount, 2);
    status = dataPeriodeArisan!.meet_ctr < dataPeriodeArisan!.total_meets
        ? 'Berlangsung'
        : 'Selesai';

    if (status.toLowerCase() == 'berlangsung') {
      statusColor = smartRTStatusYellowColor;
    }
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
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: paddingScreen,
              child: Column(
                children: [
                  Text(
                    'DETAIL PERIODE KE-${periodeKe}',
                    style: smartRTTextTitleCard.copyWith(
                      color: smartRTPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SB_height15,
                  ListTileData2(
                    txtLeft: 'Status',
                    txtRight: status,
                    txtStyleRight: smartRTTextLarge.copyWith(
                        color: statusColor, fontWeight: FontWeight.bold),
                  ),
                  SB_height15,
                  ListTileData2(
                    txtLeft: 'Pertemuan Pertama',
                    txtRight: pertemuanPertama,
                  ),
                  ListTileData2(
                    txtLeft: 'Pertemuan Terakhir',
                    txtRight: pertemuanTerakhir,
                  ),
                  SB_height15,
                  ListTileData2(
                    txtLeft: 'Jumlah Pertemuan',
                    txtRight: jumlahPertemuan,
                  ),
                  ListTileData2(
                    txtLeft: 'Jumlah Anggota',
                    txtRight: jumlahAnggota,
                  ),
                  SB_height15,
                  ListTileData2(
                    txtLeft: 'Iuran Pertemuan',
                    txtRight: iuranPertemuan,
                  ),
                  ListTileData2(
                    txtLeft: 'Nominal Pemenang',
                    txtRight: hadiahPemenang,
                  ),
                ],
              ),
            ),
            Divider(
              color: smartRTPrimaryColor,
              height: 25,
              thickness: 1,
            ),
            ListTileArisan(
              title: 'Lihat Semua Anggota',
              onTap: () {
                AnggotaPeriodeArgument arguments = AnggotaPeriodeArgument(
                    idPeriode: dataPeriodeArisan!.id.toString(),
                    periodeKe: periodeKe);
                Navigator.pushNamed(context, AnggotaPeriodePage.id,
                    arguments: arguments);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              height: 25,
              thickness: 1,
            ),
            ListTileArisan(
              title: 'Lihat Semua Pertemuan',
              onTap: () async {
                RiwayatArisanPertemuanArguments arguments =
                    RiwayatArisanPertemuanArguments(
                  idPeriode: dataPeriodeArisan!.id.toString(),
                  periodeKe: periodeKe,
                  dataPeriodeArisan: dataPeriodeArisan!,
                );
                Navigator.pushNamed(context, RiwayatArisanPertemuanPage.id,
                    arguments: arguments);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              height: 25,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
