import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/notification_provider.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/beranda_page.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/keuangan_page.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/pengumuman_page.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/saya_page.dart';
import 'package:smart_rt/screens/public_screens/home/home_part/tugas_page.dart';
import 'package:smart_rt/models/news/news.dart';
import 'package:badges/badges.dart' as badges;
import 'package:smart_rt/screens/public_screens/notification/notification_screen.dart';

class PublicHome extends StatefulWidget {
  static const String id = 'PublicHome';
  const PublicHome({Key? key}) : super(key: key);

  @override
  State<PublicHome> createState() => _PublicHomeState();
}

class _PublicHomeState extends State<PublicHome> {
  User user = AuthProvider.currentUser!;
  List<News> listPengumuman = [];
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions = <Widget>[
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
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      // get notification data...
      await context.read<NotificationProvider>().getNotifications(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? Row(
                children: [
                  SizedBox(
                      width: 25,
                      child: Image.asset('assets/img/logo/logo-kotak.png',
                          fit: BoxFit.fitWidth)),
                  SB_width15,
                  Text(
                    'Hai, ${user.full_name}',
                    style: smartRTTextLarge.copyWith(
                      color: smartRTSecondaryColor,
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        actions: [
          badges.Badge(
            showBadge: context.watch<NotificationProvider>().totalUnread > 0,
            badgeContent: Text(
              context.watch<NotificationProvider>().totalUnread.toString(),
              style: TextStyle(fontSize: 10),
            ),
            position: badges.BadgePosition.topEnd(top: 0, end: 5),
            child: IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () async {
                Navigator.pushNamed(context, NotificationScreen.id);
              },
            ),
          ),
          SB_width15
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
