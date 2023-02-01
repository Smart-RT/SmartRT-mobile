import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:provider/provider.dart';

import 'package:smart_rt/providers/auth_provider.dart';

class LihatSemuaAnggotaArisanPage extends StatefulWidget {
  static const String id = 'LihatSemuaAnggotaArisanPage';
  const LihatSemuaAnggotaArisanPage({Key? key}) : super(key: key);

  @override
  State<LihatSemuaAnggotaArisanPage> createState() =>
      _LihatSemuaAnggotaArisanPageState();
}

class _LihatSemuaAnggotaArisanPageState
    extends State<LihatSemuaAnggotaArisanPage> {
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
                  'LIST ANGGOTA',
                  style: smartRTTextTitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'PERIODE KE 1',
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
                  height: 25,
                  thickness: 2,
                ),
                ListTile(
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
                  height: 25,
                  thickness: 2,
                ),
                ListTile(
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
                  height: 25,
                  thickness: 2,
                ),
                ListTile(
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
                  height: 25,
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
