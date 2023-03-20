import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_with_cb.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';

class FormLaporKesehatanChooseUserPage extends StatefulWidget {
  static const String id = 'FormLaporKesehatanChooseUserPage';
  const FormLaporKesehatanChooseUserPage({Key? key}) : super(key: key);

  @override
  State<FormLaporKesehatanChooseUserPage> createState() =>
      _FormLaporKesehatanChooseUserPageState();
}

class _FormLaporKesehatanChooseUserPageState
    extends State<FormLaporKesehatanChooseUserPage> {
  User user = AuthProvider.currentUser!;
  List<User>? listUserWilayah = [];
  List<bool> isChecked = [];

  void getListUserWilayah() async {
    listUserWilayah =
        await context.read<AuthProvider>().getListUserWilayah(context: context);
    for (var i = 0; i < listUserWilayah!.length; i++) {
      isChecked.add(false);
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
                title: 'Pilih Tetangga yang Dilaporkan',
                notes:
                    'Pilihlah tetangga anda yang nampak kurang sehat agar dapat penanganan yang cepat dan tepat dari pengurus RT'),
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
                  initialName: StringFormat.initialName(
                      listUserWilayah![index].full_name),
                  isChecked: isChecked[index],
                  isDisabled: listUserWilayah![index].is_health.toString() ==
                              '0' ||
                          listUserWilayah![index].is_health.toString() ==
                              '-1' ||
                          listUserWilayah![index].id == user.id ||
                          listUserWilayah![index].user_role == Role.Ketua_RT ||
                          listUserWilayah![index].user_role == Role.Wakil_RT ||
                          listUserWilayah![index].user_role == Role.Sekretaris
                      ? true
                      : false,
                  onChanged: (listUserWilayah![index].user_role.index == 2)
                      ? (val) {
                          setState(
                            () {
                              for (var i = 0; i < isChecked.length; i++) {
                                isChecked[i] = false;
                              }
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
                  int selectedIndex = -1;

                  for (var i = 0; i < isChecked.length; i++) {
                    if (isChecked[i]) {
                      selectedIndex = i;
                    }
                  }
                  if (selectedIndex == -1) {
                    SmartRTSnackbar.show(context,
                        message: 'Anda belum memilih siapapun!',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    User selectedTetangga = listUserWilayah![selectedIndex];
                    FormLaporKesehatanPageArguments arguments =
                        FormLaporKesehatanPageArguments(
                            type: 'Orang Lain',
                            dataUserTerlaporkan: selectedTetangga);
                    Navigator.pushNamed(context, FormLaporKesehatanPage.id,
                        arguments: arguments);
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
