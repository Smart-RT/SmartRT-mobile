import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/widgets/cards/card_with_time_location.dart';

class ListJanjiTemuPage extends StatefulWidget {
  static const String id = 'ListJanjiTemuPage';
  const ListJanjiTemuPage({Key? key}) : super(key: key);

  @override
  State<ListJanjiTemuPage> createState() => _ListJanjiTemuPageState();
}

class _ListJanjiTemuPageState extends State<ListJanjiTemuPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Janji Temu'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Terjadwalkan',
              ),
              Tab(
                text: 'Permohonan',
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
              children: <CardWithTimeLocation>[
                CardWithTimeLocation(title: 'Gebyar Promosi Produk XYZ', dateTime: 'Senin, 01 Agustus 2023', location: 'Kalijudan Taruna V/7, Mulyorejo'),
                CardWithTimeLocation(title: 'Gebyar Promosi Produk XYZ', dateTime: 'Senin, 01 Agustus 2023', location: 'Kalijudan Taruna V/7, Mulyorejo'),
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
