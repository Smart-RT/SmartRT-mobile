import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club_period.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_semua_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_semua_anggota_periode_arisan_page.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class DetailRiwayatArisanWilayahArguments {
  LotteryClubPeriod dataPeriodeArisan;
  DetailRiwayatArisanWilayahArguments({required this.dataPeriodeArisan});
}

class DetailRiwayatArisanWilayah extends StatefulWidget {
  static const String id = 'DetailRiwayatArisanWilayah';
  DetailRiwayatArisanWilayahArguments args;
  DetailRiwayatArisanWilayah({Key? key, required this.args}) : super(key: key);

  @override
  State<DetailRiwayatArisanWilayah> createState() =>
      _DetailRiwayatArisanWilayahState();
}

class _DetailRiwayatArisanWilayahState
    extends State<DetailRiwayatArisanWilayah> {
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

  void getData() async {
    dataPeriodeArisan = widget.args.dataPeriodeArisan;
    periodeKe = dataPeriodeArisan!.period.toString();
    DateTime date = dataPeriodeArisan!.started_at;
    DateTime pertemuanTerakhirDate = dataPeriodeArisan!.year_limit == 0
        ? DateTime(date.year, date.month + 6, date.day)
        : DateTime(
            date.year + dataPeriodeArisan!.year_limit, date.month, date.day);
    pertemuanPertama =
        DateFormat('d MMMM y').format(dataPeriodeArisan!.started_at);
    pertemuanTerakhir = DateFormat('MMMM y').format((pertemuanTerakhirDate));
    yearLimit = dataPeriodeArisan!.year_limit == 0
        ? '6 bulan'
        : '${dataPeriodeArisan!.year_limit.toString()} tahun';
    jumlahPertemuan =
        '${dataPeriodeArisan!.total_meets.toString()}x (${yearLimit})';
    jumlahAnggota = '${dataPeriodeArisan!.total_members} orang';
    iuranPertemuan = 'IDR ${dataPeriodeArisan!.bill_amount},00';
    hadiahPemenang = 'IDR ${dataPeriodeArisan!.winner_bill_amount},00';
    status = dataPeriodeArisan!.meet_ctr < dataPeriodeArisan!.total_meets
        ? 'Berlangsung'
        : 'Selesai';
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        status,
                        style: smartRTTextLarge.copyWith(
                            color: smartRTSuccessColor2),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pertemuan Pertama',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        pertemuanPertama,
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pertemuan Terakhir',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        pertemuanTerakhir,
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah Pertemuan',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        jumlahPertemuan,
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah Anggota',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        jumlahAnggota,
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Iuran Pertemuan',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        iuranPertemuan,
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nominal Pemenang',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        hadiahPemenang,
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
              title: 'Lihat Semua Anggota',
              onTap: () {
                LihatSemuaAnggotaArisanPageArguments arguments =
                    LihatSemuaAnggotaArisanPageArguments(
                        idPeriode: dataPeriodeArisan!.id.toString(),
                        periodeKe: periodeKe);
                Navigator.pushNamed(context, LihatSemuaAnggotaArisanPage.id,
                    arguments: arguments);
              },
            ),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
                title: 'Lihat Semua Pertemuan',
                onTapDestination: LihatSemuaPertemuanPage.id),
            Divider(
              height: 25,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
