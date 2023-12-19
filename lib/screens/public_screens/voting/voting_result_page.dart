import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/candidate/candidate.dart';
import 'package:smart_rt/models/event/event_task_detail_rating.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/circle_avatar_loader/circle_avatar_loader.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VotingResultPage extends StatefulWidget {
  static const String id = 'VotingResultPage';
  const VotingResultPage({super.key});

  @override
  State<VotingResultPage> createState() => _VotingResultPageState();
}

class _VotingResultPageState extends State<VotingResultPage> {
  User user = AuthProvider.currentUser!;
  List<Candidate> listCandidate = [];

  void getData() async {
    try {
      Response<dynamic> resp =
          await NetUtil().dioClient.get('/vote/getvoting/1');
      listCandidate.addAll((resp.data).map<Candidate>((request) {
        return Candidate.fromData(request);
      }));

      setState(() {});
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
    return Scaffold(
      appBar: AppBar(title: Text('Hasil Voting')),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: SfCartesianChart(
              title: ChartTitle(
                  text: 'Hasil Voting', textStyle: smartRTTextTitleCard),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(),
              series: [
                ColumnSeries(
                  color: smartRTActiveColor,
                  dataSource: listCandidate,
                  xValueMapper: (Candidate data, index) => index + 1,
                  yValueMapper: (Candidate data, _) => data.totalVote,
                )
              ],
            ),
            flex: 1,
          ),
          Divider(color: smartRTPrimaryColor),
          Center(
            child: Text(
              'Informasi Kandidat',
              style: smartRTTextTitleCard,
            ),
          ),
          SB_height15,
          Expanded(
            child: Padding(
              padding: paddingScreen,
              child: ListView.separated(
                separatorBuilder: (context, int) {
                  return Divider(
                    color: smartRTPrimaryColor,
                    height: 15,
                    thickness: 1,
                  );
                },
                itemCount: listCandidate.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          (index + 1).toString(),
                          style: smartRTTextLarge,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              listCandidate[index].nama,
                              style: smartRTTextLarge.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              listCandidate[index].alamat,
                              style: smartRTTextLarge,
                            ),
                            Text(
                              'Mendapatkan ${listCandidate[index].totalVote} suara',
                              style: smartRTTextLarge,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
