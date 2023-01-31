import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_semua_pertemuan_page.dart';
import 'package:smart_rt/widgets/cards/card_periode_arisan.dart';

import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_semua_anggota_periode_arisan_page.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class DetailRiwayatArisanWilayah extends StatefulWidget {
  static const String id = 'DetailRiwayatArisanWilayah';
  const DetailRiwayatArisanWilayah({Key? key}) : super(key: key);

  @override
  State<DetailRiwayatArisanWilayah> createState() =>
      _DetailRiwayatArisanWilayahState();
}

class _DetailRiwayatArisanWilayahState
    extends State<DetailRiwayatArisanWilayah> {
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
                    'DETAIL PERIODE KE-X',
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
                        'Pertemuan Pertama',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        '1 Januari 2021',
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
                        '21 Januari 2022',
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
                        '12x (1 tahun)',
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
                        '20 Orang',
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
                        'Rp 10.000,00',
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
                        'Rp 200.000,00',
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
                onTapDestination: LihatSemuaAnggotaArisanPage.id),
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
