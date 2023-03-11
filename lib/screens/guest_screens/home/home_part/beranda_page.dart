import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/konfirmasi_gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/cards/card_big_icon_text_home.dart';
import 'package:smart_rt/widgets/cards/card_icon_with_text.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  void acara() async {}
  void janjiTemu() async {
    Navigator.pushNamed(context, ListJanjiTemuPage.id);
  }

  void administrasi() async {
    Navigator.pushNamed(context, AdministrationPage.id);
  }

  void arisan() async {
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
            style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: Text(
                'OK',
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
    } else {
      Navigator.pushNamed(context, ArisanPage.id);
    }
  }

  void performaSaya() async {}
  void kesehatan() async {
    Navigator.pushNamed(context, KesehatankuPage.id);
  }

  void gabungWilayah() async {
    Navigator.pushNamed(context, GabungWilayahPage.id);
  }

  @override
  User user = AuthProvider.currentUser!;
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: paddingScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Halo,',
              style: smartRTTextTitleCard,
            ),
            Text(
              StringFormat.convertMax2Words(user.full_name),
              style: smartRTTextTitle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '( ${user.user_role.name} )',
              style: smartRTTextLarge,
            ),
            SB_height30,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.calendar_month,
                        iconColor: smartRTPrimaryColor,
                        title: 'Acara',
                        onTap: () async {
                          acara();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.handshake,
                        iconColor: smartRTPrimaryColor,
                        title: 'Janji Temu',
                        onTap: () async {
                          janjiTemu();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.article,
                        iconColor: smartRTPrimaryColor,
                        title: 'ADM',
                        onTap: () async {
                          administrasi();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.group,
                        iconColor: smartRTPrimaryColor,
                        title: 'Arisan',
                        onTap: () async {
                          arisan();
                        },
                      ),
                    ),
                  ],
                ),
                SB_height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.analytics,
                        iconColor: smartRTPrimaryColor,
                        title: 'Performa Saya',
                        onTap: () async {
                          performaSaya();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.health_and_safety,
                        iconColor: smartRTPrimaryColor,
                        title: 'Kesehatan',
                        onTap: () async {
                          kesehatan();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.close,
                        iconColor: smartRTPrimaryColor,
                        title: '-',
                        onTap: () async {},
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.close,
                        iconColor: smartRTPrimaryColor,
                        title: '-',
                        onTap: () async {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SB_height30,
            user.user_role == Role.Ketua_RT
                ? Row(
                    children: [
                      CardBigIconAndText(
                        icon: Icons.domain_add,
                        title: 'Konfirmasi Gabung Wilayah',
                        onTap: () async {
                          Navigator.pushNamed(
                              context, KonfirmasiGabungWilayahPage.id);
                        },
                      ),
                    ],
                  )
                : Row(
                    children: [
                      CardBigIconAndText(
                        icon: Icons.domain_add,
                        title: 'Gabung Wilayah',
                        onTap: () async {
                          gabungWilayah();
                        },
                      ),
                    ],
                  ),
            SB_height50,
            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         CardBigIconAndText(
            //             icon: Icons.calendar_month,
            //             title: 'Acara',
            //             onTap: () {}),
            //         CardBigIconAndText(
            //             icon: Icons.handshake,
            //             title: 'Janji Temu',
            //             onTap: () {
            //               Navigator.pushNamed(context, ListJanjiTemuPage.id);
            //             }),
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         CardBigIconAndText(
            //             icon: Icons.article,
            //             title: 'Administrasi',
            //             onTap: () {}),
            //         CardBigIconAndText(
            //             icon: Icons.group,
            //             title: 'Arisan',
            //             onTap: () {
            //               if (user.area == null) {
            //                 showDialog<String>(
            //                   context: context,
            //                   builder: (BuildContext context) => AlertDialog(
            //                     title: Text(
            //                       'Hai Sobat Pintar,',
            //                       style: smartRTTextTitleCard,
            //                     ),
            //                     content: Text(
            //                       'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
            //                       style: smartRTTextNormal.copyWith(
            //                           fontWeight: FontWeight.normal),
            //                     ),
            //                     actions: <Widget>[
            //                       TextButton(
            //                         onPressed: () =>
            //                             Navigator.pop(context, 'OK'),
            //                         child: Text(
            //                           'OK',
            //                           style: smartRTTextNormal.copyWith(
            //                               fontWeight: FontWeight.bold),
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               } else {
            //                 Navigator.pushNamed(context, ArisanPage.id);
            //               }
            //             }),
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         CardBigIconAndText(
            //             icon: Icons.analytics,
            //             title: 'Performa Saya',
            //             onTap: () {}),
            //         CardBigIconAndText(
            //             icon: Icons.health_and_safety,
            //             title: 'Kesehatan',
            //             onTap: () {
            //               Navigator.pushNamed(context, KesehatankuPage.id);
            //             }),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         CardBigIconAndText(
            //             icon: Icons.domain_add,
            //             title: 'Gabung Wilayah',
            //             onTap: () {
            //               Navigator.pushNamed(context, GabungWilayahPage.id);
            //             }),
            //       ],
            //     )
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
