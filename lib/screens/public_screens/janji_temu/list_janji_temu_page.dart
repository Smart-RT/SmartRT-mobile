import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/buat_janji_temu_page.dart';
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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, BuatJanjiTemuPage.id);
              },
            ),
            SB_width25,
          ],
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
                CardWithTimeLocation(
                    title:
                        'Live-Action Violence Action Films Clip Shows Assassin Kei Meeting Yakuza Terano',
                    subtitle:
                        'The official website for the live-action film adaptation of author Shin Sawada and artist Renji Asais The Violence Action manga began streaming a clip from the film on Wednesday. The clip shows the assassin Kei meeting yakuza member Terano, who pays for Keis bus fare. Kei later tries to pay back Terano during the ride, but finds that she has no change, and promises to pay back Terano when they next meet. In the back of the bus, Keis schoolmate Watanabe looks upon them with envy.',
                    dateTime: 'Senin, 01 Agustus 2023',
                    location: 'Kalijudan Taruna V/7, Mulyorejo'),
                CardWithTimeLocation(
                    title:
                        'Live-Action Violence Action Films Clip Shows Assassin Kei Meeting Yakuza Terano',
                    subtitle:
                        'The official website for the live-action film adaptation of author Shin Sawada and artist Renji Asais The Violence Action manga began streaming a clip from the film on Wednesday. The clip shows the assassin Kei meeting yakuza member Terano, who pays for Keis bus fare. Kei later tries to pay back Terano during the ride, but finds that she has no change, and promises to pay back Terano when they next meet. In the back of the bus, Keis schoolmate Watanabe looks upon them with envy.',
                    dateTime: 'Senin, 01 Agustus 2023',
                    location: 'Kalijudan Taruna V/7, Mulyorejo'),
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
