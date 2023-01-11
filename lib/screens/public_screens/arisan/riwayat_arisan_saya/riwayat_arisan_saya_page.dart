import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/detail_riwayat_arisan_saya_page.dart';
import 'package:smart_rt/widgets/cards/card_periode_arisan.dart';

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
        title: Text('Riwayat Arisan Saya'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total periode yang telah diikuti',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    '2',
                    style: smartRTTextLarge,
                  ),
                ],
              ),
              SB_height30,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Banyak Iuran Belum Dibayar',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    '3 Iuran',
                    style: smartRTTextLarge,
                  ),
                ],
              ),
              SB_height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Iuran Belum Dibayar',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    'Rp 30.000,-',
                    style: smartRTTextLarge,
                  ),
                ],
              ),
              // SB_height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    'Detail Iuran Belum Dibayar>',
                    style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SB_height30,
              
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PERIODE ARISAN SAYA',
                        style: smartRTTextLarge.copyWith(
                          color: smartRTPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.sort,
                        color: smartRTPrimaryColor,
                      ),
                    ],
                  ),
                  SB_height15,
                  CardPeriodeArisan(periodeKe: 'x', status: 'status', startedAt: 'startedAt', iuranPertemuan: 'iuranPertemuan', jumlahPertemuan: 'jumlahPertemuan', totalAnggota: 'totalAnggota', statusColor: smartRTPrimaryColor, onTapDestination: DetailRiwayatArisanSayaPage.id)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
