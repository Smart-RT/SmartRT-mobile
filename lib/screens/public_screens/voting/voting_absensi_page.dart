import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/voting/voting.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_with_cb.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';

class VotingAbsensiPage extends StatefulWidget {
  static const String id = 'VotingAbsensiPage';
  const VotingAbsensiPage({Key? key}) : super(key: key);

  @override
  State<VotingAbsensiPage> createState() => VotingAbsensiPageState();
}

class VotingAbsensiPageState extends State<VotingAbsensiPage> {
  User user = AuthProvider.currentUser!;
  List<User> listUserWilayah = [];
  List<bool> isChecked = [];
  List<bool> isDisabled = [];
  List<NeighbourhoodHeadCandidate> listKandidat = [];
  List<Voting> listVoting = [];

  void getData() async {
    listUserWilayah =
        await context.read<AuthProvider>().getListUserWilayah(context: context);

    for (var i = 0; i < listUserWilayah.length; i++) {
      isChecked.add(false);
      isDisabled.add(false);
    }

    Response<dynamic> resp2 = await NetUtil()
        .dioClient
        .get('/neighbourhood-head/get/all/period/${user.area!.periode}');
    listKandidat.addAll((resp2.data).map<NeighbourhoodHeadCandidate>((request) {
      return NeighbourhoodHeadCandidate.fromData(request);
    }));

    // debugPrint('listKandidat.length.toString()');
    // debugPrint(listKandidat.length.toString());
    // debugPrint(listKandidat[0].dataUser!.full_name);
    // debugPrint(listKandidat[1].dataUser!.full_name);

    Response<dynamic> resp3 = await NetUtil()
        .dioClient
        .get('/vote/data/list/period/${user.area!.periode}');

    if (resp3.statusCode.toString() == '200') {
      listVoting.addAll((resp3.data).map<Voting>((request) {
        return Voting.fromData(request);
      }));
    }

    for (var i = 0; i < listUserWilayah.length; i++) {
      if (listUserWilayah[i].is_committe == 1) {
        // isDisabled[i] = true;
      } else {
        // for (var i2 = 0; i2 < listKandidat.length; i2++) {
        //   if (listUserWilayah[i].id == listKandidat[i2].dataUser!.id &&
        //       listKandidat[i2].status == 1) {
        //     isDisabled[i] = true;
        //   }
        // }
        for (var i2 = 0; i2 < listVoting.length; i2++) {
          if (listUserWilayah[i].id == listVoting[i2].voter_id) {
            isChecked[i] = true;
          }
        }
      }
    }

    setState(() {});
  }

  void showConfirmNotify(User user) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: smartRTSecondaryColor,
        title: Text(
          'Konfirmasi Notice',
          style: smartRTTextTitleCard_Primary,
        ),
        content: Text(
          'Apakah anda yakin ingin mengirimkan notice ke user ${user.full_name}?',
          style:
              smartRTTextNormal_Primary.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Batal'),
                child: Text(
                  'Batal',
                  style: smartRTTextLarge_Primary,
                ),
              ),
              TextButton(
                onPressed: () async {
                  // notify
                  bool status = await sendNoticeToUser(user.id);
                  if (status) {
                    Navigator.pop(context, 'sukses');
                    SmartRTSnackbar.show(context,
                        message: 'Berhasil mengirimkan notice ke user',
                        backgroundColor: smartRTSuccessColor);
                  } else {
                    SmartRTSnackbar.show(context,
                        message: 'Terjadi kesalahan',
                        backgroundColor: smartRTErrorColor);
                  }
                },
                child: Text(
                  'Ya, Kirim Notice',
                  style: smartRTTextLargeBold_Primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> sendNoticeToUser(int userId) async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .post('/vote/notice', data: {"user_id_notice": userId});
      if (resp.statusCode.toString() == '200')
        return true;
      else
        return false;
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
        return false;
      }
    }
    return true;
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
                title: 'ABSENSI VOTING'.toUpperCase(),
                notes:
                    'Absensi akan dilakukan secara otomatis ketika warga melakukan voting dan telah dikonfirmasi oleh sistem.'),
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
                    onChanged:
                        context.watch<AuthProvider>().user!.is_committe == 1 &&
                                !isChecked[index]
                            ? (value) {
                                showConfirmNotify(listUserWilayah[index]);
                              }
                            : null);
              },
            ),
          ),
        ],
      ),
    );
  }
}
