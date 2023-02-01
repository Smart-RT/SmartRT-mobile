import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:provider/provider.dart';

import 'package:smart_rt/providers/auth_provider.dart';

class LihatIuranArisanPertemuanPage extends StatefulWidget {
  static const String id = 'LihatIuranArisanPertemuanPage';
  const LihatIuranArisanPertemuanPage({Key? key}) : super(key: key);

  @override
  State<LihatIuranArisanPertemuanPage> createState() =>
      _LihatIuranArisanPertemuanPageState();
}

class _LihatIuranArisanPertemuanPageState
    extends State<LihatIuranArisanPertemuanPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding: paddingScreen,
            child: Column(
              children: [
                Text(
                  'IURAN ARISAN',
                  style: smartRTTextTitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'PERTEMUAN KE 1',
                  style: smartRTTextLarge,
                  textAlign: TextAlign.center,
                ),
                SB_height15,
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 2,
                ),
                ListTile(
                  tileColor: smartRTSuccessColor,
                  leading: CircleAvatarLoader(
                    radius: 50,
                    photoPathUrl:
                        '${backendURL}/public/uploads/users/${AuthProvider.currentUser!.id}/profile_picture/',
                    photo:
                        context.watch<AuthProvider>().user?.photo_profile_img,
                    initials: 'XX',
                  ),
                  title: Text('Nama Lengkap'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alamat'),
                      SB_height15,
                      Text('Virtual Account BCA'),
                      Text('21 Januari 2021')
                    ],
                  ),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 2,
                ),
                ListTile(
                  tileColor: smartRTErrorColor,
                  leading: CircleAvatarLoader(
                    radius: 50,
                    photoPathUrl:
                        '${backendURL}/public/uploads/users/${AuthProvider.currentUser!.id}/profile_picture/',
                    photo:
                        context.watch<AuthProvider>().user?.photo_profile_img,
                    initials: 'XX',
                  ),
                  title: Text('Nama Lengkap'),
                  subtitle: Text('Alamat'),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 2,
                ),
                ListTile(
                  tileColor: smartRTSuccessColor,
                  leading: CircleAvatarLoader(
                    radius: 50,
                    photoPathUrl:
                        '${backendURL}/public/uploads/users/${AuthProvider.currentUser!.id}/profile_picture/',
                    photo:
                        context.watch<AuthProvider>().user?.photo_profile_img,
                    initials: 'XX',
                  ),
                  title: Text('Nama Lengkap'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alamat'),
                      SB_height15,
                      Text('Virtual Account BCA'),
                      Text('21 Januari 2021')
                    ],
                  ),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
