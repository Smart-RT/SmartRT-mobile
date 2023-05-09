import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/committe/committe.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/committe_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_with_cb.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';

class RekomendasikanPanitiaPage extends StatefulWidget {
  static const String id = 'RekomendasikanPanitiaPage';
  const RekomendasikanPanitiaPage({Key? key}) : super(key: key);

  @override
  State<RekomendasikanPanitiaPage> createState() =>
      RekomendasikanPanitiaPageState();
}

class RekomendasikanPanitiaPageState extends State<RekomendasikanPanitiaPage> {
  User user = AuthProvider.currentUser!;
  List<User> listUserWilayah = [];
  List<bool> isChecked = [];
  List<bool> isDisabled = [];
  List<Committe> listPanitia = [];

  void rekomendasikanPanitia() async {
    List<int> listID = [];
    for (var i = 0; i < listUserWilayah.length; i++) {
      if (isChecked[i]) {
        listID.add(listUserWilayah[i].id);
        debugPrint(listUserWilayah[i].id.toString());
      }
    }

    Response<dynamic> resp = await NetUtil()
        .dioClient
        .post('/committe/req/add/recommendation', data: {'list_id': listID});

    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  void getData() async {
    listUserWilayah =
        await context.read<AuthProvider>().getListUserWilayah(context: context);

    for (var i = 0; i < listUserWilayah.length; i++) {
      isChecked.add(false);
      isDisabled.add(false);
    }

    Response<dynamic> resp = await NetUtil().dioClient.get('/committe/get/all');
    listPanitia.addAll((resp.data).map<Committe>((request) {
      return Committe.fromData(request);
    }));

    for (var i = 0; i < listUserWilayah.length; i++) {
      if (listUserWilayah[i].user_role != Role.Warga) {
        isDisabled[i] = true;
      } else {
        for (var i2 = 0; i2 < listPanitia.length; i2++) {
          if (listUserWilayah[i].id == listPanitia[i2].data_user!.id) {
            isDisabled[i] = true;
          }
        }
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
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
            child: ExplainPart(
                title: 'REKOMENDASIKAN WARGA'.toUpperCase(),
                notes:
                    'Pilihlah warga yang anda rekomendasikan sebagai Panitia!\n\n*Warga yang direkomendasikan akan menjadi panitia ketika warga tersebut menyetujuinya!'),
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
              itemCount: listUserWilayah.length,
              itemBuilder: (context, index) {
                return ListTileUserWithCB(
                    fullName: listUserWilayah[index].full_name,
                    address: listUserWilayah[index].address.toString(),
                    photoPathURL:
                        '${backendURL}/public/uploads/users/${listUserWilayah[index].id}/profile_picture/',
                    photo: listUserWilayah[index].photo_profile_img.toString(),
                    initialName: StringFormat.initialName(
                        listUserWilayah[index].full_name),
                    isChecked: isChecked[index],
                    isDisabled: isDisabled[index],
                    onChanged: (val) {
                      debugPrint(index.toString());
                      setState(
                        () {
                          isChecked[index] = val!;
                        },
                      );
                    });
              },
            ),
          ),
          Padding(
            padding: paddingScreen,
            child: Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  rekomendasikanPanitia();
                },
                child: Text(
                  'REKOMENDASIKAN',
                  style: smartRTTextLarge.copyWith(
                      color: smartRTSecondaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
