import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class DetailWilayah extends StatelessWidget {
  static const String id = 'DetailWilayahPage';
  const DetailWilayah({super.key});

  String initialName(String full_name) {
    if (full_name == '') {
      return '';
    } else if (full_name.contains(' ')) {
      List<String> nama = full_name.toUpperCase().split(' ');
      return '${nama[0][0]}${nama[1][0]}';
    } else if (full_name.length < 2) {
      return full_name.toUpperCase();
    } else {
      return '${full_name[0]}${full_name[1]}'.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    Area area = context.watch<AuthProvider>().user!.area!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Wilayah"),
      ),
      body: Container(
          child: ListView(
        children: [
          ListTile(
            leading: CircleAvatarLoader(
              radius: 30,
              photoPathUrl:
                  '${backendURL}/public/uploads/users/${area.ketua_id!.id}/profile_picture/',
              photo: area.ketua_id!.photo_profile_img,
              initials: initialName(area.ketua_id!.full_name),
            ),
            title: Text('Ketua'),
            subtitle: Text(area.ketua_id!.full_name),
          ),
          ListTile(
            leading: CircleAvatarLoader(
              radius: 30,
              photoPathUrl:
                  '${backendURL}/public/uploads/users/${area.wakil_ketua_id?.id ?? ''}/profile_picture/',
              photo: area.wakil_ketua_id?.photo_profile_img ?? '',
              initials: area.wakil_ketua_id != null
                  ? initialName(area.wakil_ketua_id!.full_name)
                  : '?',
            ),
            title: Text('Wakil Ketua'),
            subtitle: Text(area.wakil_ketua_id != null
                ? area.wakil_ketua_id!.full_name
                : "Belum Ada, Kode: ${area.wakil_ketua_code}"),
            trailing: area.wakil_ketua_id == null
                ? GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: area.wakil_ketua_code));
                      SmartRTSnackbar.show(context,
                          message: 'Berhasil menyalin kode Wakil Ketua!',
                          backgroundColor: smartRTSuccessColor);
                    },
                    child: Icon(Icons.copy))
                : null,
          ),
          ListTile(
            leading: CircleAvatarLoader(
              radius: 30,
              photoPathUrl:
                  '${backendURL}/public/uploads/users/${area.sekretaris_id?.id ?? ''}/profile_picture/',
              photo: area.sekretaris_id?.photo_profile_img ?? '',
              initials: area.sekretaris_id != null
                  ? initialName(area.sekretaris_id!.full_name)
                  : '?',
            ),
            title: Text("Sekretaris"),
            subtitle: Text(area.sekretaris_id != null
                ? area.sekretaris_id!.full_name
                : "Belum Ada, Kode: ${area.sekretaris_code}"),
            trailing: area.wakil_ketua_id == null
                ? GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: area.sekretaris_code));
                      SmartRTSnackbar.show(context,
                          message: 'Berhasil menyalin kode Sekretaris!',
                          backgroundColor: smartRTSuccessColor);
                    },
                    child: Icon(Icons.copy))
                : null,
          ),
          ListTile(
            leading: CircleAvatarLoader(
              radius: 30,
              photoPathUrl:
                  '${backendURL}/public/uploads/users/${area.bendahara_id?.id ?? ''}/profile_picture/',
              photo: area.bendahara_id?.photo_profile_img ?? '',
              initials: area.bendahara_id != null
                  ? initialName(area.bendahara_id!.full_name)
                  : '?',
            ),
            dense: false,
            title: Text("Bendahara"),
            subtitle: Text(area.bendahara_id != null
                ? area.bendahara_id!.full_name
                : "Belum Ada, Kode: ${area.bendahara_code}"),
            trailing: area.bendahara_id == null
                ? GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                          ClipboardData(text: area.bendahara_code));
                      SmartRTSnackbar.show(context,
                          message: 'Berhasil menyalin kode Bendahara!',
                          backgroundColor: smartRTSuccessColor);
                    },
                    child: Icon(Icons.copy))
                : null,
          ),
        ],
      )),
    );
  }
}
