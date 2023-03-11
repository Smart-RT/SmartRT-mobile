import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_absence.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_with_cb.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class AbsenAnggotaPageArguments {
  String idPertemuan;
  AbsenAnggotaPageArguments({required this.idPertemuan});
}

class AbsenAnggotaPage extends StatefulWidget {
  static const String id = 'AbsenAnggotaPage';
  AbsenAnggotaPageArguments args;
  AbsenAnggotaPage({Key? key, required this.args}) : super(key: key);

  @override
  State<AbsenAnggotaPage> createState() => _AbsenAnggotaPageState();
}

class _AbsenAnggotaPageState extends State<AbsenAnggotaPage> {
  String idPertemuan = '';
  List<LotteryClubPeriodDetailAbsence>? listAbsensiAnggotaArisan = [];
  List<bool> isChecked = [];

  void getAbsensiAnggotaArisan() async {
    idPertemuan = widget.args.idPertemuan;
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getListAbsensiPertemuan/${idPertemuan}');
    listAbsensiAnggotaArisan!
        .addAll((resp.data).map<LotteryClubPeriodDetailAbsence>((request) {
      return LotteryClubPeriodDetailAbsence.fromData(request);
    }));
    for (var i = 0; i < listAbsensiAnggotaArisan!.length; i++) {
      isChecked.add(listAbsensiAnggotaArisan![i].is_present.toString() == '1');
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      getAbsensiAnggotaArisan();
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
                title: 'Absen Anggota',
                notes:
                    'Anda hanya dapat merubah absensi sebelum pemilihan pemenang dilakukan.'),
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
              itemCount: listAbsensiAnggotaArisan!.length,
              itemBuilder: (context, index) {
                return ListTileUserWithCB(
                  fullName: listAbsensiAnggotaArisan![index].user_id!.full_name,
                  address: listAbsensiAnggotaArisan![index]
                      .user_id!
                      .address
                      .toString(),
                  photoPathURL:
                      '${backendURL}/public/uploads/users/${listAbsensiAnggotaArisan![index].id}/profile_picture/',
                  photo: listAbsensiAnggotaArisan![index]
                      .user_id!
                      .photo_profile_img
                      .toString(),
                  initialName: initialName(
                      listAbsensiAnggotaArisan![index].user_id!.full_name),
                  isChecked: isChecked[index],
                  onChanged: (val) {
                    setState(
                      () {
                        isChecked[index] = val!;
                      },
                    );
                  },
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
                  List<int> listIDAbsenAnggotaHadir = [];

                  for (var i = 0; i < isChecked.length; i++) {
                    if (isChecked[i]) {
                      listIDAbsenAnggotaHadir
                          .add(listAbsensiAnggotaArisan![i].id);
                    }
                  }
                  debugPrint('DATA ID: ${listIDAbsenAnggotaHadir}');
                  Response<dynamic> response = await NetUtil()
                      .dioClient
                      .patch('/lotteryClubs/periode/pertemuan/absences', data: {
                    "listIDAbsenAnggotaHadir": listIDAbsenAnggotaHadir,
                    "idPertemuan": idPertemuan
                  });
                  String msg = response.data;
                  if (msg == "BERHASIL SIMPAN !") {
                    SmartRTSnackbar.show(context,
                        message: msg, backgroundColor: smartRTSuccessColor);
                  } else {
                    SmartRTSnackbar.show(context,
                        message: msg, backgroundColor: smartRTErrorColor);
                  }
                  setState(() {});
                },
                child: Text(
                  'SIMPAN',
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
