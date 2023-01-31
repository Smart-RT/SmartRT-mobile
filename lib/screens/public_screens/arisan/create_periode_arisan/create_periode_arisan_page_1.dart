import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';

import 'package:smart_rt/providers/auth_provider.dart';

class CreatePeriodeArisanPage1 extends StatefulWidget {
  static const String id = 'CreatePeriodeArisanPage1';
  const CreatePeriodeArisanPage1({Key? key}) : super(key: key);

  @override
  State<CreatePeriodeArisanPage1> createState() =>
      _CreatePeriodeArisanPage1State();
}

class _CreatePeriodeArisanPage1State extends State<CreatePeriodeArisanPage1> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: paddingScreen,
                  child: const ExplainPart(
                      title: 'Pilih Anggota',
                      notes:
                          'Anda hanya daoat merubah anggota ketika belum ada jadwal pertemuan yang di publish pada periode ini. Minimal anda harus memiliki 6 anggota dalam setiap periodenya (Semua pengurus pada wilayah anda wajib mengikuti arisan sebagai panutan warga).'),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  height: 2,
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
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {},
                  ),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  height: 2,
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
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {},
                  ),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  height: 2,
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
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {},
                  ),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  height: 2,
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
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {},
                  ),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  height: 2,
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
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {},
                  ),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  height: 2,
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
                  trailing: Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {},
                  ),
                ),
                Divider(
                  color: smartRTPrimaryColor,
                  height: 2,
                ),
              ],
            ),
            Padding(
              padding: paddingScreen,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, CreatePeriodeArisanPage2.id);
                  },
                  child: Text(
                    'SELANJUTNYA',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
