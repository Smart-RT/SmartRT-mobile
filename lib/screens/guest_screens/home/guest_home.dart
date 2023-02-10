import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/guest_screens/home/home_part/beranda_page.dart';
import 'package:smart_rt/screens/guest_screens/home/home_part/keuangan_page.dart';
import 'package:smart_rt/screens/guest_screens/home/home_part/pengumuman_page.dart';
import 'package:smart_rt/screens/guest_screens/home/home_part/saya_page.dart';
import 'package:smart_rt/screens/guest_screens/home/home_part/tugas_page.dart';

class GuestHome extends StatefulWidget {
  static const String id = 'GuestHome';
  const GuestHome({Key? key}) : super(key: key);

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    BerandaPage(),
    TugasSayaPage(),
    PengumumanPage(),
    KeuanganPage(),
    SayaPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
