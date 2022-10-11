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

class ListRequestRolePage extends StatefulWidget {
  static const String id = 'ListRequestRolePage';
  const ListRequestRolePage({Key? key}) : super(key: key);

  @override
  State<ListRequestRolePage> createState() => _ListRequestRolePageState();
}

class _ListRequestRolePageState extends State<ListRequestRolePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Riwayat Req Role Ketua RT'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Menunggu Konfirmasi',
              ),
              Tab(
                text: 'Sudah Dikonfirmasi',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ListView(
              children: [
                CardWithTimeLocation(title: 'Laa Miao Miao', subtitle: 'No. Telp : 0813 3445 6566\nKalijudan Taruna V no 7, Kalijudan, Mulyorejo, Surabaya', dateTime: 'Dibuat pada tanggal 1 Januari 2022', location: 'RT 2 | RW 4 | Kalijudan, Mulyorejo'),
                Divider(thickness: 1,),
                CardWithTimeLocation(title: 'Laa Miao Miao', subtitle: 'No. Telp : 0813 3445 6566\nKalijudan Taruna V no 7, Kalijudan, Mulyorejo, Surabaya', dateTime: 'Dibuat pada tanggal 1 Januari 2022', location: 'RT 2 | RW 4 | Kalijudan, Mulyorejo'),
              ],
            ),
            ListView(
              children: [
                CardWithTimeLocation(title: 'Laa Miao Miao', subtitle: 'No. Telp : 0813 3445 6566\nKalijudan Taruna V no 7, Kalijudan, Mulyorejo, Surabaya', dateTime: 'Diterima pada tanggal 1 Januari 2022', location: 'RT 2 | RW 4 | Kalijudan, Mulyorejo'),
                Divider(thickness: 1,),
                CardWithTimeLocation(title: 'Laa Miao Miao', subtitle: 'No. Telp : 0813 3445 6566\nKalijudan Taruna V no 7, Kalijudan, Mulyorejo, Surabaya', dateTime: 'Ditolak pada tanggal 1 Januari 2022', location: 'RT 2 | RW 4 | Kalijudan, Mulyorejo'),
              ],
            ),
          ],
        ),
      ),
    );
  
  }
}
