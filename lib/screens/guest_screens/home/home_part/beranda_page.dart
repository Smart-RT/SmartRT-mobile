import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/daftar_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/widgets/cards/card_big_icon_text_home.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  @override
  User user = AuthProvider.currentUser!;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardBigIconAndText(
                    icon: Icons.calendar_month, title: 'Acara', onTap: () {}),
                CardBigIconAndText(
                    icon: Icons.handshake,
                    title: 'Janji Temu',
                    onTap: () {
                      Navigator.pushNamed(context, ListJanjiTemuPage.id);
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardBigIconAndText(
                    icon: Icons.article, title: 'Administrasi', onTap: () {}),
                CardBigIconAndText(
                    icon: Icons.group,
                    title: 'Arisan',
                    onTap: () {
                      if (user.area == null) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(
                              'Hai Sobat Pintar,',
                              style: smartRTTextTitleCard,
                            ),
                            content: Text(
                              'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
                              style: smartRTTextNormal.copyWith(
                                  fontWeight: FontWeight.normal),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: Text(
                                  'OK',
                                  style: smartRTTextNormal.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (user.area?.lottery_club_id == null) {
                        Navigator.pushNamed(context, DaftarArisanPage.id);
                      } else {
                        Navigator.pushNamed(context, ArisanPage.id);
                      }
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardBigIconAndText(
                    icon: Icons.analytics,
                    title: 'Performa Saya',
                    onTap: () {}),
                CardBigIconAndText(
                    icon: Icons.health_and_safety,
                    title: 'Kesehatan',
                    onTap: () {
                      Navigator.pushNamed(context, KesehatankuPage.id);
                    }),
              ],
            ),
            Row(
              children: [
                CardBigIconAndText(
                    icon: Icons.domain_add,
                    title: 'Gabung Wilayah',
                    onTap: () {
                      Navigator.pushNamed(context, GabungWilayahPage.id);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
