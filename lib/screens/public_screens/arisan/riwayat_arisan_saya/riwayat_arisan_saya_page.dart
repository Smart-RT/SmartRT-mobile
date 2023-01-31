import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/detail_riwayat_arisan_saya_page.dart';
import 'package:smart_rt/widgets/cards/card_riwayat_arisan_wilayah.dart';

class RiwayatArisanSayaPage extends StatefulWidget {
  static const String id = 'RiwayatArisanSayaPage';
  const RiwayatArisanSayaPage({Key? key}) : super(key: key);

  @override
  State<RiwayatArisanSayaPage> createState() => _RiwayatArisanSayaPageState();
}

class _RiwayatArisanSayaPageState extends State<RiwayatArisanSayaPage> {
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
              'RIWAYAT ARISAN',
              style: smartRTTextTitle,
              textAlign: TextAlign.center,
            ),
            Text(
              'YANG TELAH SAYA IKUTI',
              style: smartRTTextLarge,
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
                      onTapDestination: DetailRiwayatArisanSayaPage.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
