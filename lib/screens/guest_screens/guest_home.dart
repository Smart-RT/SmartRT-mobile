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
            child: GestureDetector(
              onTap: () {/** ... */},
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
          ),
        ],
      ),
    ),
    Text(
      'Index 2: School',
    ),
    ListView(
      children: <Widget>[
        Card(
          color: smartRTSecondaryColor,
          child: ListTile(
            leading: Icon(
              Icons.image,
              size: 72,
            ),
            title: Text(
              '[Judul Berita]',
              style: smartRTTextLargeBold_Primary,
            ),
            subtitle: Text(
              'Senin, 1 Agustus 2022\n\nFirst blood, literally. Meski secara biologis keduanya tak bisa menghasilkan janin, namun rutinitas majikan dan budak ini bakal terus berjalan hingga Taku mengumpulkan kawanan lainnya.',
              style: smartRTTextNormal_Primary,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Card(
          color: smartRTSecondaryColor,
          child: ListTile(
            leading: Icon(
              Icons.image,
              size: 72,
            ),
            title: Text(
              '[Judul Berita]',
              style: smartRTTextLargeBold_Primary,
            ),
            subtitle: Text(
              'Senin, 1 Agustus 2022\n\nFirst blood, literally. Meski secara biologis keduanya tak bisa menghasilkan janin, namun rutinitas majikan dan budak ini bakal terus berjalan hingga Taku mengumpulkan kawanan lainnya.',
              style: smartRTTextNormal_Primary,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Card(
          color: smartRTSecondaryColor,
          child: ListTile(
            leading: Icon(
              Icons.image,
              size: 72,
            ),
            title: Text(
              '[Judul Berita]',
              style: smartRTTextLargeBold_Primary,
            ),
            subtitle: Text(
              'Senin, 1 Agustus 2022\n\nFirst blood, literally. Meski secara biologis keduanya tak bisa menghasilkan janin, namun rutinitas majikan dan budak ini bakal terus berjalan hingga Taku mengumpulkan kawanan lainnya.',
              style: smartRTTextNormal_Primary,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
    Column(
      children: [
        Container(
          color: smartRTPrimaryColor,
          width: double.infinity,
          height: 125,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: paddingScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'DOMPET SAYA',
                      style: smartRTTextLargeBold_Success,
                    ),
                    Text(
                      'IDR 0,00',
                      style: smartRTTextTitle_Success,
                    )
                  ],
                ),
              )),
              Expanded(
                  child: Padding(
                padding: paddingScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'HUTANG',
                      style: smartRTTextLargeBold_Error,
                    ),
                    Text(
                      'IDR 0,00',
                      style: smartRTTextTitle_Error,
                    )
                  ],
                ),
              )),
            ],
          ),
        ),
        Container(
          height: 500,
          child: ListView(
            children: <Widget>[
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  title: Text(
                    'Semua Tagihan (0)',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  title: Text(
                    'Keuangan Kas',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  title: Text(
                    'Keuangan Iuran',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  title: Text(
                    'Keuangan Arisan',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        )
      
      ],
    ),
    Column(
      children: [
        Container(
          color: smartRTPrimaryColor,
          width: double.infinity,
          height: 125,
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                Icons.account_circle,
                size: 100,
                color: smartRTSecondaryColor,
              )),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '[Nama Lengkap]',
                        style: smartRTTextLargeBold_Secondary,
                      ),
                      Text(
                        '[Jabatan]',
                        style: smartRTTextLarge_Secondary,
                      ),
                      Text(
                        '[Alamat Rumah]',
                        style: smartRTTextLarge_Secondary,
                      ),
                    ],
                  ))
            ],
          ),
        ),
        Container(
          height: 500,
          child: ListView(
            children: <Widget>[
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: smartRTPrimaryColor,
                  ),
                  title: Text(
                    'Edit Profile',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  leading: Icon(
                    Icons.domain_add,
                    color: smartRTPrimaryColor,
                  ),
                  title: Text(
                    'Join Wilayah',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  leading: Icon(
                    Icons.accessibility_new_rounded,
                    color: smartRTPrimaryColor,
                  ),
                  title: Text(
                    'Daftar menjadi Ketua RT',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  leading: Icon(
                    Icons.accessibility_new_rounded,
                    color: smartRTPrimaryColor,
                  ),
                  title: Text(
                    'Update Jabatan',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  leading: Icon(
                    Icons.analytics,
                    color: smartRTPrimaryColor,
                  ),
                  title: Text(
                    'Performa Saya',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
              Card(
                color: smartRTSecondaryColor,
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: smartRTPrimaryColor,
                  ),
                  title: Text(
                    'Keluarkan AKun',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: smartRTPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
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
                    Title(
                      color: smartRTPrimaryColor,
                      child: Text(
                        'Judul Berita',
                        style: smartRTTextLargeBold_Primary,
                      ),
                    ),
                    Text(
                      'First blood, literally. Meski secara biologis keduanya tak bisa menghasilkan janin, namun rutinitas majikan dan budak ini bakal terus berjalan hingga Taku mengumpulkan kawanan lainnya.',
                      maxLines: 3,
                    ),
                    Text(
                      'Senin, 01 Agustus 2022',
                      textAlign: TextAlign.right,
                    )
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
