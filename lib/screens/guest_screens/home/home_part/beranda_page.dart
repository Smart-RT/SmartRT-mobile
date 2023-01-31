import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/widgets/cards/card_big_icon_text_home.dart';

class BerandaPage extends StatelessWidget {
  const BerandaPage({
    Key? key,
  }) : super(key: key);

  @override
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
                      Navigator.pushNamed(context, ArisanPage.id);
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
