import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/admin_screens/daftar_akun/buat_akun_admin_page.dart';

class DaftarAkunPage extends StatefulWidget {
  static const String id = 'DaftarAkunPage';
  const DaftarAkunPage({Key? key}) : super(key: key);

  @override
  State<DaftarAkunPage> createState() => _DaftarAkunPageState();
}

class _DaftarAkunPageState extends State<DaftarAkunPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Daftar Akun'),
          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, BuatAkunAdminPage.id);
                },
                child: Icon(Icons.person_add)),
            SB_width15,
          ],
        ),
        body: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: smartRTPrimaryColor,
                child: Icon(Icons.person_rounded),
              ),
              title: Text(
                'Laa Miao Miao (Guest)',
                style: smartRTTextLargeBold_Primary,
              ),
              subtitle: Text(
                '08XX XXXX XXXX',
                style: smartRTTextNormal_Primary,
              ),
            ),
            Divider(
              height: 0,
              thickness: 1,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: smartRTPrimaryColor,
                child: Icon(Icons.person_rounded),
              ),
              title: Text(
                'Laa Miao Miao (Guest)',
                style: smartRTTextLargeBold_Primary,
              ),
              subtitle: Text(
                '08XX XXXX XXXX',
                style: smartRTTextNormal_Primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
