import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_absence.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_detail_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_with_cb.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class AbsensiPertemuanArisanArgument {
  LotteryClubPeriodDetail dataPertemuan;
  String typeFrom;
  AbsensiPertemuanArisanArgument(
      {required this.dataPertemuan, required this.typeFrom});
}

class AbsensiPertemuanArisanPage extends StatefulWidget {
  static const String id = 'AbsensiPertemuanArisanPage';
  AbsensiPertemuanArisanArgument args;
  AbsensiPertemuanArisanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<AbsensiPertemuanArisanPage> createState() =>
      _AbsensiPertemuanArisanPageState();
}

class _AbsensiPertemuanArisanPageState
    extends State<AbsensiPertemuanArisanPage> {
  LotteryClubPeriodDetail? dataPertemuan;
  List<LotteryClubPeriodDetailAbsence>? listAbsensiAnggotaArisan = [];
  List<bool> isChecked = [];
  User user = AuthProvider.currentUser!;

  void simpanAction() async {
    List<int> listIDAbsenAnggotaHadir = [];

    for (var i = 0; i < isChecked.length; i++) {
      if (isChecked[i]) {
        listIDAbsenAnggotaHadir.add(listAbsensiAnggotaArisan![i].id);
      }
    }
    debugPrint('DATA ID: ${listIDAbsenAnggotaHadir}');
    Response<dynamic> response = await NetUtil()
        .dioClient
        .patch('/lotteryClubs/periode/pertemuan/absences', data: {
      "listIDAbsenAnggotaHadir": listIDAbsenAnggotaHadir,
      "idPertemuan": dataPertemuan!.id
    });
    String msg = response.data;
    if (msg == "BERHASIL SIMPAN !") {
      debugPrint(widget.args.typeFrom);
      if (widget.args.typeFrom.toLowerCase() == 'riwayat') {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        debugPrint('asjdasjdsnadnak');
        RiwayatArisanPertemuanArguments arguments =
            RiwayatArisanPertemuanArguments(
          idPeriode: dataPertemuan!.lottery_club_period_id!.id.toString(),
          periodeKe: dataPertemuan!.lottery_club_period_id!.period.toString(),
          dataPeriodeArisan: dataPertemuan!.lottery_club_period_id!,
        );
        Navigator.pushNamed(context, RiwayatArisanPertemuanPage.id,
            arguments: arguments);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
      }
      Response<dynamic> respPertemuanBaru = await NetUtil()
          .dioClient
          .get('/lotteryClubs/get/meet/id-pertemuan/${dataPertemuan!.id}');
      LotteryClubPeriodDetail dataPertemuanBaru =
          LotteryClubPeriodDetail.fromData(respPertemuanBaru.data);

      RiwayatArisanPertemuanDetailArguments arguments2 =
          RiwayatArisanPertemuanDetailArguments(
        dataPertemuan: dataPertemuanBaru,
        periodeKe: dataPertemuanBaru.period_ke.toString(),
        pertemuanKe: dataPertemuanBaru.pertemuan_ke.toString(),
        typeFrom: widget.args.typeFrom,
        dataPeriodeArisan: dataPertemuanBaru.lottery_club_period_id!,
      );
      Navigator.pushNamed(context, RiwayatArisanPertemuanDetailPage.id,
          arguments: arguments2);
      SmartRTSnackbar.show(context,
          message: msg, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: msg, backgroundColor: smartRTErrorColor);
    }
  }

  void getAbsensiAnggotaArisan() async {
    dataPertemuan = widget.args.dataPertemuan;
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getListAbsensiPertemuan/${dataPertemuan!.id}');
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
                  onChanged: user.user_role != Role.Warga
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
          if (user.user_role != Role.Warga)
            Padding(
              padding: paddingScreen,
              child: Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    simpanAction();
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
