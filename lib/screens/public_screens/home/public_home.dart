import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/beranda_page.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/keuangan_page.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/pengumuman_page.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/saya_page.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/tugas_page.dart';
import 'package:dio/dio.dart';
import 'package:smart_rt/models/news/news.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class PublicHome extends StatefulWidget {
  static const String id = 'PublicHome';
  const PublicHome({Key? key}) : super(key: key);

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  List<News> listPengumuman = [];
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions = <Widget>[
    BerandaPage(),
  ];

  void getData() async {
    Response<dynamic> resp = await NetUtil().dioClient.get('/news/get/all');
    listPengumuman.clear();
    listPengumuman.addAll((resp.data).map<News>((request) {
      return News.fromData(request);
    }));

    _widgetOptions = <Widget>[
      BerandaPage(),
      TugasSayaPage(),
      PengumumanPage(listPengumuman: listPengumuman),
      KeuanganPage(),
      SayaPage(),
    ];
    setState(() {});
  }

  void _onItemTapped(int index) {
    if (_widgetOptions.length != 5) {
      SmartRTSnackbar.show(context,
          message: "Tunggu sebentar! Masih dalam proses!",
          backgroundColor: smartRTStatusYellowColor);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(Icons.notifications),
          SB_width25,
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
            backgroundColor: smartRTPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist_rtl),
            label: 'Tugas',
            backgroundColor: smartRTPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Pengumuman',
            backgroundColor: smartRTPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Keuangan',
            backgroundColor: smartRTPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Saya',
            backgroundColor: smartRTPrimaryColor,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: smartRTSecondaryColor,
        unselectedItemColor: smartRTTertiaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
