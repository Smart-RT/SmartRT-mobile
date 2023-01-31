import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/detail_riwayat_arisan_wilayah_page.dart';
import 'package:smart_rt/widgets/cards/card_riwayat_arisan_wilayah.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';

import 'package:smart_rt/providers/auth_provider.dart';

class RiwayatArisanWilayahPage extends StatefulWidget {
  static const String id = 'RiwayatArisanWilayahPage';
  const RiwayatArisanWilayahPage({Key? key}) : super(key: key);

  @override
  State<RiwayatArisanWilayahPage> createState() =>
      _RiwayatArisanWilayahPageState();
}

class _RiwayatArisanWilayahPageState extends State<RiwayatArisanWilayahPage> {
  bool isChecked = false;

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
            SingleChildScrollView(
              child: Column(
                children: [
                  CardRiwayatArisanWilayah(
                      periodeKe: '1',
                      status: 'selesai',
                      totalPertemuan: '12x (1 tahun)',
                      totalAnggota: '10',
                      iuran: 'Rp 10.000,00',
                      onTapDestination: DetailRiwayatArisanWilayah.id),
                  CardRiwayatArisanWilayah(
                      periodeKe: '2',
                      status: 'selesai',
                      totalPertemuan: '12x (1 tahun)',
                      totalAnggota: '10',
                      iuran: 'Rp 10.000,00',
                      onTapDestination: ''),
                  CardRiwayatArisanWilayah(
                      periodeKe: '3',
                      status: 'selesai',
                      totalPertemuan: '12x (1 tahun)',
                      totalAnggota: '10',
                      iuran: 'Rp 10.000,00',
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
