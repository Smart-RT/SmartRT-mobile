import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_bantuan_page.dart';
import 'package:smart_rt/widgets/cards/card_with_status.dart';
import 'package:smart_rt/widgets/cards/card_with_time_location.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RiwayatBantuanPage extends StatefulWidget {
  static const String id = 'RiwayatBantuanPage';
  const RiwayatBantuanPage({Key? key}) : super(key: key);

  @override
  State<RiwayatBantuanPage> createState() => _RiwayatBantuanPageState();
}

class _RiwayatBantuanPageState extends State<RiwayatBantuanPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Riwayat Bantuan'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Navigator.pushNamed(context, BuatJanjiTemuPage.id);
              },
            ),
            SB_width25,
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Permohonan',
              ),
              Tab(
                text: 'Diproses',
              ),
              Tab(
                text: 'Telah Berlalu',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: <CardWithStatus>[
                CardWithStatus(
                    title: 'Sabtu, 1 Oktober 2022',
                    subtitle: 'Kepada Pengurus RT, saya membutuhkan obat Pelancar Pencernaan, obat Sakit Kepala, serta vitamin untuk menunjang kepulihan saya.',
                    dateTime: 'Menunggu Konfirmasi',
                    onTap: (){Navigator.pushNamed(context, DetailRiwayatBantuanPage.id);},
                ),
              ],
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  
  }
}
