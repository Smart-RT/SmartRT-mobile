import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/admin_screens/daftar_akun/daftar_akun_page.dart';
import 'package:smart_rt/screens/admin_screens/daftar_wilayah_surabaya/daftar_wilayah_surabaya_page.dart';
import 'package:smart_rt/screens/admin_screens/request_role/list_request_role_page.dart';
import 'package:smart_rt/screens/public_screens/daftar_ketua/daftar_ketua_form_page_1.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BerandaAdminPage extends StatefulWidget {
  static const String id = 'BerandaAdminPage';
  const BerandaAdminPage({Key? key}) : super(key: key);

  @override
  State<BerandaAdminPage> createState() => _BerandaAdminPageState();
}

class _PieData {
  _PieData(this.xData, this.yData, this.text);
  final String xData;
  final num yData;
  final String text;
}

final List<_PieData> pieData = [
  _PieData('Utara', 200, 'Utara'),
  _PieData('Timur', 100, 'Timur'),
  _PieData('Selatan', 139, 'Selatan'),
  _PieData('Barat', 203, 'Barat'),
];

class _BerandaAdminPageState extends State<BerandaAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beranda')),
      body: Column(
        children: [
          Visibility(
            child: Container(
              padding: paddingCard,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, ListRequestRolePage.id);
                },
                child: Column(
                  children: [
                    Text(
                      'TERDAPAT REQUEST ROLE KETUA RT',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                    Text(
                      'Cek dan Konfirmasi Sekarang !',
                      style: smartRTTextNormal_Secondary,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
              child: Divider(
            thickness: 1,
          )),
          Center(
              child: SfCircularChart(
                  title: ChartTitle(
                      text: 'Jumlah Penduduk Surabaya',
                      textStyle: smartRTTextLargeBold_Primary),
                  legend: Legend(isVisible: true),
                  series: <PieSeries<_PieData, String>>[
                PieSeries<_PieData, String>(
                    explode: true,
                    explodeIndex: 0,
                    dataSource: pieData,
                    xValueMapper: (_PieData data, _) => data.xData,
                    yValueMapper: (_PieData data, _) => data.yData,
                    dataLabelMapper: (_PieData data, _) => data.text,
                    dataLabelSettings: DataLabelSettings(isVisible: true)),
              ])),
          Divider(
            thickness: 1,
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: smartRTSecondaryColor,
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.

          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: smartRTPrimaryColor,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: CircleAvatar(
                      backgroundColor: smartRTSecondaryColor,
                      child: Icon(Icons.person_rounded),
                    ),
                  ),
                  SB_width15,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Admin [Nama admin]',
                        style: smartRTTextLargeBold_Secondary,
                      ),
                      Text(
                        '08XX XXXX XXXX',
                        style: smartRTTextLarge_Secondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: smartRTPrimaryColor,
              ),
              title: Text(
                'Beranda',
                style: smartRTTextLarge_Primary,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              thickness: 0.25,
            ),
            ListTile(
              leading: Icon(
                Icons.list,
                color: smartRTPrimaryColor,
              ),
              title: Text(
                'Riwayat Req Role Ketua RT',
                style: smartRTTextLarge_Primary,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                // Navigator.pushNamed(context, ListRequestRolePage.id);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              thickness: 0.25,
            ),
            ListTile(
              leading: Icon(
                Icons.list,
                color: smartRTPrimaryColor,
              ),
              title: Text(
                'Daftar Wilayah Surabaya',
                style: smartRTTextLarge_Primary,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.pushNamed(context, DaftarWilayahSurabayaPage.id);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              thickness: 0.25,
            ),
            ListTile(
              leading: Icon(
                Icons.list,
                color: smartRTPrimaryColor,
              ),
              title: Text(
                'Daftar Akun',
                style: smartRTTextLarge_Primary,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.pushNamed(context, DaftarAkunPage.id);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              thickness: 0.25,
            ),
            ListTile(
              leading: Icon(
                Icons.health_and_safety,
                color: smartRTPrimaryColor,
              ),
              title: Text(
                'Laporan Kesehatan',
                style: smartRTTextLarge_Primary,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            Divider(
              color: smartRTPrimaryColor,
              thickness: 0.25,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: smartRTPrimaryColor,
              ),
              title: Text(
                'Keluar',
                style: smartRTTextLarge_Primary,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
