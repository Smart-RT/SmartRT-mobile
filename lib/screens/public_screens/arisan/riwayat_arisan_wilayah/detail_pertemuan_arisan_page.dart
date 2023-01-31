import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_semua_pertemuan_page.dart';
import 'package:smart_rt/widgets/cards/card_periode_arisan.dart';

import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_iuran_arisan_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_absensi_pertemuan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_semua_anggota_periode_arisan_page.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class DetailPertemuanArisanPage extends StatefulWidget {
  static const String id = 'DetailPertemuanArisanPage';
  const DetailPertemuanArisanPage({Key? key}) : super(key: key);

  @override
  State<DetailPertemuanArisanPage> createState() =>
      _DetailPertemuanArisanPageState();
}

class _DetailPertemuanArisanPageState extends State<DetailPertemuanArisanPage> {
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
                    'DETAIL PERTEMUAN KE X',
                    style: smartRTTextTitleCard.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'PERIODE KE X',
                    style: smartRTTextLarge,
                    textAlign: TextAlign.center,
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal Pertemuan',
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
                        'Tempat Pertemuan',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        'Rumah Pak RT',
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah Anggota Hadir',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        '10 Orang',
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pemenang Pertama',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        'XXX',
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pemenang Kedua',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        'XXX',
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
                title: 'Lihat Absensi',
                onTapDestination: LihatAbsensiPertemuanArisanPage.id),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
                title: 'Lihat Iuran Arisan',
                onTapDestination: LihatIuranArisanPertemuanPage.id),
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
