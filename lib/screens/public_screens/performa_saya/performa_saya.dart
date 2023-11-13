import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/event/event_task_detail_rating.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PerformaSayaPage extends StatefulWidget {
  static const String id = 'PerformaSayaPage';
  const PerformaSayaPage({super.key});

  @override
  State<PerformaSayaPage> createState() => _PerformaSayaPageState();
}

class _PerformaSayaPageState extends State<PerformaSayaPage> {
  int jumlahDiikuti = 0;
  int jumlahAktif = 0;
  int jumlahDitolak = 0;
  int jumlahDikeluarkan = 0;
  num average = 0;
  List<EventTaskDetailRating> ratings = [];
  List<Map<String, dynamic>> chartData = [
    {"rating": '1', "count": 0},
    {"rating": '2', "count": 0},
    {"rating": '3', "count": 0},
    {"rating": '4', "count": 0},
    {"rating": '5', "count": 0},
  ];

  void getData() async {
    try {
      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/event/task/detail/rating/performance');
      if (resp.statusCode.toString() == '200') {
        setState(() {
          jumlahDiikuti = resp.data['event_count'];
          jumlahAktif = resp.data['event_active_count'];
          jumlahDitolak = resp.data['event_reject_count'];
          jumlahDikeluarkan = resp.data['event_kick_count'];
          average = resp.data['average'];

          ratings.clear();
          ratings.addAll(resp.data['ratings'].map<EventTaskDetailRating>(
              (r) => EventTaskDetailRating.fromData(r)));
          chartData[0]['count'] = ratings.where((r) => r.rating == 1).length;
          chartData[1]['count'] = ratings.where((r) => r.rating == 2).length;
          chartData[2]['count'] = ratings.where((r) => r.rating == 3).length;
          chartData[3]['count'] = ratings.where((r) => r.rating == 4).length;
          chartData[4]['count'] = ratings.where((r) => r.rating == 5).length;
        });
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = context.watch<AuthProvider>().user!;
    return Scaffold(
      appBar: AppBar(title: Text('Performa Saya')),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    color: smartRTPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatarLoader(
                            radius: 50,
                            photoPathUrl:
                                '${backendURL}/public/uploads/users/${currentUser.id}/profile_picture/',
                            photo: currentUser.photo_profile_img,
                            initials: currentUser.initialName(),
                          ),
                          SB_height15,
                          Text(
                            currentUser.full_name,
                            style: smartRTTextLargeBold_Primary.copyWith(
                                color: Colors.white),
                          ),
                          Text(
                            currentUser.address ?? '-',
                            style:
                                smartRTTextLarge.copyWith(color: Colors.white),
                          ),
                          SB_height5,
                          Text(
                            'Rating saya: $average dari 5',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: SfCartesianChart(
              title: ChartTitle(
                  text: 'Rating yang saya dapatkan',
                  textStyle: smartRTTextLargeBold_Primary),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              series: [
                ColumnSeries(
                  color: smartRTActiveColor,
                  dataSource: chartData,
                  xValueMapper: (Map<String, dynamic> data, _) =>
                      data['rating'],
                  yValueMapper: (Map<String, dynamic> data, _) => data['count'],
                )
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: smartRTPrimaryColor),
                  Center(
                    child: Text(
                      'Informasi Perfoma Saya',
                      style:
                          smartRTTextLargeBold_Primary.copyWith(fontSize: 24),
                    ),
                  ),
                  SB_height15,
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text('Jumlah Diikuti :',
                                    style: smartRTTextNormalBold_Primary),
                              ))),
                      Expanded(flex: 1, child: Text('$jumlahDiikuti Acara')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text('Jumlah Aktif :',
                                    style: smartRTTextNormalBold_Primary),
                              ))),
                      Expanded(flex: 1, child: Text('$jumlahAktif Acara')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text('Jumlah Ditolak :',
                                    style: smartRTTextNormalBold_Primary),
                              ))),
                      Expanded(flex: 1, child: Text('$jumlahDitolak Acara')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text('Jumlah Dikeluarkan :',
                                    style: smartRTTextNormalBold_Primary),
                              ))),
                      Expanded(
                          flex: 1, child: Text('$jumlahDikeluarkan Acara')),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text('Jumlah Rating :',
                                    style: smartRTTextNormalBold_Primary),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Text('${ratings.length} Rating Didapatkan')),
                    ],
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
        ],
      )),
    );
  }
}
