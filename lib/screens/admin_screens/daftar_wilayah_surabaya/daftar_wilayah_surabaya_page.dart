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

class DaftarWilayahSurabayaPage extends StatefulWidget {
  static const String id = 'DaftarWilayahSurabayaPage';
  const DaftarWilayahSurabayaPage({Key? key}) : super(key: key);

  @override
  State<DaftarWilayahSurabayaPage> createState() =>
      _DaftarWilayahSurabayaPageState();
}

class _DaftarWilayahSurabayaPageState extends State<DaftarWilayahSurabayaPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Wilayah Surabaya'),
          actions: [
            Icon(Icons.filter_alt),
            SB_width15,
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('RT 1 | RW 1 | Kalijudan, Mulyorejo', style: smartRTTextLargeBold_Primary),
              subtitle:
                  Text('RT : Laa Miao Miao \n( 081X XXXX XXXX | Kalijudan Taruna V/7 )', style: smartRTTextNormal_Primary,),
              isThreeLine: true,
            ),
            Divider(height: 0,thickness: 1,),
            ListTile(
              title: Text('RT 1 | RW 1 | Kalijudan, Mulyorejo', style: smartRTTextLargeBold_Primary),
              subtitle:
                  Text('RT : Laa Miao Miao \n( 081X XXXX XXXX | Kalijudan Taruna V/7 )', style: smartRTTextNormal_Primary,),
              isThreeLine: true,
            ),
          ],
        ),
      ),
    );
  }
}
