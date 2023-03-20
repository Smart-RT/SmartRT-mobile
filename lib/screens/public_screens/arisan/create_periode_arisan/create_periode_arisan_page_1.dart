import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_with_cb.dart';
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
  List<User>? listUserWilayah = [];
  List<bool> isChecked = [];

  void getListUserWilayah() async {
    listUserWilayah =
        await context.read<AuthProvider>().getListUserWilayah(context: context);
    for (var i = 0; i < listUserWilayah!.length; i++) {
      if (listUserWilayah![i].user_role.index == 2) {
        isChecked.add(false);
      } else {
        isChecked.add(true);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      getListUserWilayah();
    });
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
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
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, int) {
                return Divider(
                  color: smartRTPrimaryColor,
                  height: 5,
                );
              },
              itemCount: listUserWilayah!.length,
              itemBuilder: (context, index) {
                return ListTileUserWithCB(
                  fullName: listUserWilayah![index].full_name,
                  address: listUserWilayah![index].address.toString(),
                  photoPathURL:
                      '${backendURL}/public/uploads/users/${listUserWilayah![index].id}/profile_picture/',
                  photo: listUserWilayah![index].photo_profile_img.toString(),
                  initialName: initialName(listUserWilayah![index].full_name),
                  isChecked: isChecked[index],
                  onChanged: (listUserWilayah![index].user_role.index == 2)
                      ? (val) {
                          setState(
                            () {
                              isChecked[index] = val!;
                            },
                          );
                        }
                      : null,
                );
              },
            ),
          ),
          Padding(
            padding: paddingScreen,
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  List<int> listMemberID = [];

                  for (var i = 0; i < isChecked.length; i++) {
                    if (isChecked[i]) {
                      listMemberID.add(listUserWilayah![i].id);
                    }
                  }

                  if (listMemberID.length >= 6) {
                    CreatePeriodeArisanPage2Arguments argsForPage2 =
                        CreatePeriodeArisanPage2Arguments(
                            listMemberID: listMemberID);
                    Navigator.pushNamed(context, CreatePeriodeArisanPage2.id,
                        arguments: argsForPage2);
                  } else {
                    SmartRTSnackbar.show(context,
                        message: 'Anggota Arisan minimal 6 orang!',
                        backgroundColor: smartRTErrorColor);
                  }
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
    );
  }
}
