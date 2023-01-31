import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/cards/card_list_pertemuan_arisan.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/detail_pertemuan_arisan_page.dart';

class LihatSemuaPertemuanPage extends StatefulWidget {
  static const String id = 'LihatSemuaPertemuanPage';
  const LihatSemuaPertemuanPage({Key? key}) : super(key: key);

  @override
  State<LihatSemuaPertemuanPage> createState() =>
      _LihatSemuaPertemuanPageState();
}

class _LihatSemuaPertemuanPageState extends State<LihatSemuaPertemuanPage> {
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
              'PERIODE KE 1',
              style: smartRTTextLarge,
              textAlign: TextAlign.center,
            ),
            SB_height30,
            SingleChildScrollView(
              child: Column(
                children: [
                  CardListPertemuanArisan(
                      pertemuanKe: '1',
                      jumlahAnggotaHadir: '12',
                      tempatPelaksanaan: 'Rumah Pak RT',
                      tanggalPelaksanaan: '1 Januari 2021',
                      onTapDestination: DetailPertemuanArisanPage.id),
                  CardListPertemuanArisan(
                      pertemuanKe: '2',
                      jumlahAnggotaHadir: '12',
                      tempatPelaksanaan: 'Rumah Pak RT',
                      tanggalPelaksanaan: '1 Januari 2021',
                      onTapDestination: ''),
                  CardListPertemuanArisan(
                      pertemuanKe: '3',
                      jumlahAnggotaHadir: '12',
                      tempatPelaksanaan: 'Rumah Pak RT',
                      tanggalPelaksanaan: '1 Januari 2021',
                      onTapDestination: ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
