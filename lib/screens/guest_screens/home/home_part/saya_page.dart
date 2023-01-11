import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/welcome_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/tanda_tangan_saya/tanda_tangan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/ubah_profil/ubah_profil_page.dart';
import 'package:smart_rt/screens/public_screens/update_role/req_update_role_page.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';

class SayaPage extends StatelessWidget {
  const SayaPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: smartRTPrimaryColor,
          width: double.infinity,
          height: 125,
          child: Row(
            children: [
              Expanded(child: 
                CircleAvatarLoader(
                            radius: 50,
                            photoPathUrl:
                                '${backendURL}/public/uploads/users/${AuthProvider.currentUser!.id}/profile_picture/',
                            photo:
                                context.watch<AuthProvider>().user?.photo_profile_img,
                            initials:
                                context.watch<AuthProvider>().user!.initialName(),
                          )
              ),
              // Expanded(
              //     child: Icon(
              //   Icons.account_circle,
              //   size: 100,
              //   color: smartRTSecondaryColor,
              // )),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AuthProvider.currentUser!.full_name,
                        style: smartRTTextLargeBold_Secondary,
                      ),
                      Visibility(
                        visible: AuthProvider.currentUser!.address == null || AuthProvider.currentUser!.address == '' ? false : true,
                        child: Text(
                          AuthProvider.currentUser!.address.toString(),
                          style: smartRTTextLarge_Secondary,
                        ),
                      ),
                      Text(
                        AuthProvider.currentUser!.user_role.name.replaceAll("_", " "),
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
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, UbahProfilPage.id);
                },
                child: Card(
                  color: smartRTSecondaryColor,
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: smartRTPrimaryColor,
                    ),
                    title: Text(
                      'Ubah Profil',
                      style: smartRTTextLargeBold_Primary,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: smartRTPrimaryColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, TandaTanganSayaPage.id);
                },
                child: Card(
                  color: smartRTSecondaryColor,
                  child: ListTile(
                    leading: Icon(
                      Icons.border_color_rounded,
                      color: smartRTPrimaryColor,
                    ),
                    title: Text(
                      'Tanda Tangan Saya',
                      style: smartRTTextLargeBold_Primary,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: smartRTPrimaryColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, GabungWilayahPage.id);
                },
                child: Card(
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
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, DaftarKetuaPage.id);
                },
                child: Card(
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
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, ReqUpdateRolePage.id);
                },
                child: Card(
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
              GestureDetector(
                onTap: ()async{
                  await context.read<AuthProvider>().logout();
                  Navigator.pushReplacementNamed(context, WelcomePage.id);
                },
                child: Card(
                  color: smartRTSecondaryColor,
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: smartRTPrimaryColor,
                    ),
                    title: Text(
                      'Keluarkan Akun',
                      style: smartRTTextLargeBold_Primary,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: smartRTPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
