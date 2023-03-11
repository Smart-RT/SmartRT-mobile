import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_member.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class LihatSemuaAnggotaArisanPageArguments {
  String idPeriode;
  String periodeKe;
  LihatSemuaAnggotaArisanPageArguments(
      {required this.idPeriode, required this.periodeKe});
}

class LihatSemuaAnggotaArisanPage extends StatefulWidget {
  static const String id = 'LihatSemuaAnggotaArisanPage';
  LihatSemuaAnggotaArisanPageArguments args;
  LihatSemuaAnggotaArisanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<LihatSemuaAnggotaArisanPage> createState() =>
      _LihatSemuaAnggotaArisanPageState();
}

class _LihatSemuaAnggotaArisanPageState
    extends State<LihatSemuaAnggotaArisanPage> {
  List<LotteryClubPeriodMember> listMember = [];
  String idPeriode = '';
  String periodeKe = '';

  void getData() async {
    idPeriode = widget.args.idPeriode;
    periodeKe = widget.args.periodeKe;
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getListMemberArisan/$idPeriode');
    listMember.addAll((resp.data).map<LotteryClubPeriodMember>((request) {
      return LotteryClubPeriodMember.fromData(request);
    }));

    setState(() {});
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
  void initState() {
    // TODO: implement initState
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
            child: Column(
              children: [
                Text(
                  'LIST ANGGOTA',
                  style: smartRTTextTitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'PERIODE KE $periodeKe',
                  style: smartRTTextLarge,
                  textAlign: TextAlign.center,
                ),
                SB_height15,
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, int) {
                return Divider(
                  color: smartRTPrimaryColor,
                  height: 5,
                );
              },
              itemCount: listMember.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatarLoader(
                    radius: 50,
                    photoPathUrl:
                        '${backendURL}/public/uploads/users/${listMember[index].user_id!.id}/profile_picture/',
                    photo: listMember[index].user_id!.photo_profile_img,
                    initials: initialName(listMember[index].user_id!.full_name),
                  ),
                  title: Text(listMember[index].user_id!.full_name),
                  subtitle: Text(listMember[index].user_id!.address.toString()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
