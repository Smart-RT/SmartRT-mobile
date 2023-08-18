import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/population_provider.dart';
import 'package:smart_rt/screens/admin_screens/daftar_akun/daftar_akun_page.dart';
import 'package:smart_rt/screens/admin_screens/daftar_pelanggan_pro/daftar_pelanggan_pro_page.dart';
import 'package:smart_rt/screens/admin_screens/daftar_wilayah_surabaya/daftar_wilayah_surabaya_page.dart';
import 'package:smart_rt/screens/admin_screens/request_role/list_request_role_page.dart';
import 'package:smart_rt/screens/public_screens/daftar_ketua/daftar_ketua_form_page_1.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_button.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:smart_rt/screens/admin_screens/pengaturan/pengaturan_page.dart';

import 'package:smart_rt/screens/public_screens/authentications/welcome_page.dart';
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

class _BerandaAdminPageState extends State<BerandaAdminPage> {
  int populationUtara = 0;
  int populationTimur = 0;
  int populationSelatan = 0;
  int populationBarat = 0;
  int populationPusat = 0;

  List<_PieData> pieData = [
    _PieData('Utara', 0, '0'),
    _PieData('Timur', 0, '0'),
    _PieData('Selatan', 0, '0'),
    _PieData('Barat', 0, '0'),
    _PieData('Pusat', 0, '0'),
  ];

  void getData() async {
    await context.read<PopulationProvider>().getPopulation();
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    populationBarat = context.watch<PopulationProvider>().populasiBarat;
    populationSelatan = context.watch<PopulationProvider>().populasiSelatan;
    populationTimur = context.watch<PopulationProvider>().populasiTimur;
    populationUtara = context.watch<PopulationProvider>().populasiUtara;
    populationPusat = context.watch<PopulationProvider>().populasiPusat;

    pieData = [
      _PieData('Sby. Utara', populationUtara,
          populationUtara == 0 ? ' ' : populationUtara.toString()),
      _PieData('Sby. Timur', populationTimur,
          populationTimur == 0 ? ' ' : populationTimur.toString()),
      _PieData('Sby. Selatan', populationSelatan,
          populationSelatan == 0 ? ' ' : populationSelatan.toString()),
      _PieData('Sby. Barat', populationBarat,
          populationBarat == 0 ? ' ' : populationBarat.toString()),
      _PieData('Sby. Pusat', populationPusat,
          populationPusat == 0 ? ' ' : populationPusat.toString()),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Beranda')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: SfCircularChart(
                    title: ChartTitle(
                        text:
                            'Jumlah Penduduk Surabaya Berdasarkan Pengguna Aplikasi',
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
            Visibility(
                child: Divider(
              thickness: 1,
            )),
            Padding(
              padding: paddingScreen,
              child: CardListTileWithButton(
                  title: 'PERMINTAAN MENJADI KETUA RT',
                  subtitle:
                      'Terdapat x permintaan untuk menjadi Ketua RT yang harus anda konfirmasi segera!',
                  buttonText: 'KONFIRMASI SEKARANG',
                  onTapButton: () {
                    Navigator.pushNamed(context, ListRequestRolePage.id);
                  }),
            ),
          ],
        ),
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
                Navigator.pop(context);
                Navigator.pushNamed(context, ListRequestRolePage.id);
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
                'Daftar Pelanggan Pro',
                style: smartRTTextLarge_Primary,
              ),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
                Navigator.pushNamed(context, DaftarPelangganProPage.id);
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
                Icons.settings,
                color: smartRTPrimaryColor,
              ),
              title: Text(
                'Pengaturan',
                style: smartRTTextLarge_Primary,
              ),
              onTap: () {
                Navigator.pushNamed(context, PengaturanPage.id);
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
              onTap: () async {
                Navigator.pop(context);
                await context.read<AuthProvider>().logout();
                Navigator.pushReplacementNamed(context, WelcomePage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
