import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class GuestHome extends StatefulWidget {
  static const String id = 'GuestHome';
  const GuestHome({Key? key}) : super(key: key);

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Padding(
      padding: paddingScreen,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Acara',
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.handshake,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Janji Temu',
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.article,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Administrasi',
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Arisan',
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.analytics,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Performa Saya',
                          textAlign: TextAlign.center,
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 165,
                height: 155,
                child: Card(
                  color: smartRTCardColor,
                  shadowColor: smartRTShadowColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: paddingCard,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.health_and_safety,
                          color: smartRTSecondaryColor,
                          size: 65,
                        ),
                        Text(
                          'Kesehatan',
                          style: smartRTTextLargeBold_Secondary,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 155,
            child: Card(
              color: smartRTCardColor,
              shadowColor: smartRTShadowColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: paddingCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.domain_add,
                      color: smartRTSecondaryColor,
                      size: 65,
                    ),
                    Text(
                      'Gabung Wilayah',
                      style: smartRTTextLargeBold_Secondary,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    Text(
      'Index 2: School',
    ),
    Text(
      'Index 2: School',
    ),
    Padding(
      padding: paddingScreen,
      child: Container(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) => ListItem(),
        ),
      ),
    ),
    Text(
      'Index 2: School',
    ),
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
            icon: Icon(Icons.wallet),
            label: 'Keuangan',
            backgroundColor: smartRTPrimaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Pengumuman',
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

class ListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: MediaQuery.of(context).size.height / 7,
      child: Card(
        shadowColor: smartRTShadowColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.image,
                size: 50,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: paddingCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Title(color: smartRTPrimaryColor, child: Text('Judul Berita', style: smartRTTextLargeBold_Primary,),),
                    Text('First blood, literally. Meski secara biologis keduanya tak bisa menghasilkan janin, namun rutinitas majikan dan budak ini bakal terus berjalan hingga Taku mengumpulkan kawanan lainnya.', maxLines: 3,),
                    Text('Senin, 01 Agustus 2022', textAlign: TextAlign.right,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
