import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/health_task_help.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_minta_bantuan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_with_status.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RiwayatBantuanArguments {
  String type;
  RiwayatBantuanArguments({required this.type});
}

class RiwayatBantuanPage extends StatefulWidget {
  static const String id = 'RiwayatBantuanPage';
  RiwayatBantuanArguments args;
  RiwayatBantuanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<RiwayatBantuanPage> createState() => _RiwayatBantuanPageState();
}

class _RiwayatBantuanPageState extends State<RiwayatBantuanPage> {
  List<HealthTaskHelp> listPermohonan = [];
  List<HealthTaskHelp> listDiproses = [];
  List<HealthTaskHelp> listTelahBerlalu = [];
  String type = '';
  String appbarTitle = 'Riwayat Bantuanku';

  void getData() async {
    type = widget.args.type;

    Response<dynamic> resp;
    if (type == 'Semua') {
      appbarTitle = 'Riwayat Bantuan Wilayah';
      resp = await NetUtil()
          .dioClient
          .get('/health/healthTaskHelp/list/0/is-all/yes');
      listPermohonan.addAll((resp.data).map<HealthTaskHelp>((request) {
        return HealthTaskHelp.fromData(request);
      }));

      resp = await NetUtil()
          .dioClient
          .get('/health/healthTaskHelp/list/1/is-all/yes');
      listDiproses.addAll((resp.data).map<HealthTaskHelp>((request) {
        return HealthTaskHelp.fromData(request);
      }));

      resp = await NetUtil()
          .dioClient
          .get('/health/healthTaskHelp/list/telahBerlalu/is-all/yes');
      listTelahBerlalu.addAll((resp.data).map<HealthTaskHelp>((request) {
        return HealthTaskHelp.fromData(request);
      }));
    } else {
      resp = await NetUtil()
          .dioClient
          .get('/health/healthTaskHelp/list/0/is-all/no');
      listPermohonan.addAll((resp.data).map<HealthTaskHelp>((request) {
        return HealthTaskHelp.fromData(request);
      }));

      resp = await NetUtil()
          .dioClient
          .get('/health/healthTaskHelp/list/1/is-all/no');
      listDiproses.addAll((resp.data).map<HealthTaskHelp>((request) {
        return HealthTaskHelp.fromData(request);
      }));

      resp = await NetUtil()
          .dioClient
          .get('/health/healthTaskHelp/list/telahBerlalu/is-all/no');
      listTelahBerlalu.addAll((resp.data).map<HealthTaskHelp>((request) {
        return HealthTaskHelp.fromData(request);
      }));
    }

    setState(() {});
  }

  String getHelpType(String text) {
    if (text == '1') {
      return "Obat - obatan";
    } else if (text == '2') {
      return "Kebutuhan Pangan";
    } else {
      return "Lainnya";
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
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appbarTitle),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Permohonan',
              ),
              Tab(
                text: 'Diproses',
              ),
              Tab(
                text: 'Telah Berlalu',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            listPermohonan.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listPermohonan.length,
                    itemBuilder: (context, index) {
                      return CardListTileWithStatusColor(
                        title:
                            'Kebutuhan ${getHelpType(listPermohonan[index].help_type.toString())}',
                        subtitle: 'Detail : ${listPermohonan[index].notes}',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y', 'id_ID').format(listPermohonan[index].created_at)}',
                        statusColor: listPermohonan[index].urgent_level == 1
                            ? smartRTStatusYellowColor
                            : smartRTStatusRedColor,
                        onTap: () {
                          DetailRiwayatBantuanPageArguments arguments =
                              DetailRiwayatBantuanPageArguments(
                                  dataBantuanID: listPermohonan[index].id,
                                  type: type);
                          Navigator.pushNamed(
                              context, DetailRiwayatBantuanPage.id,
                              arguments: arguments);
                        },
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Tidak ada riwayat",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listDiproses.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listDiproses.length,
                    itemBuilder: (context, index) {
                      return CardListTileWithStatusColor(
                        title:
                            'Kebutuhan ${getHelpType(listDiproses[index].help_type.toString())}',
                        subtitle: 'Detail : ${listDiproses[index].notes}',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y').format(listDiproses[index].created_at)}',
                        statusColor: listDiproses[index].urgent_level == 1
                            ? smartRTStatusYellowColor
                            : smartRTStatusRedColor,
                        onTap: () {
                          DetailRiwayatBantuanPageArguments arguments =
                              DetailRiwayatBantuanPageArguments(
                                  dataBantuanID: listDiproses[index].id,
                                  type: type);
                          Navigator.pushNamed(
                              context, DetailRiwayatBantuanPage.id,
                              arguments: arguments);
                        },
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Tidak ada riwayat",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listTelahBerlalu.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listTelahBerlalu.length,
                    itemBuilder: (context, index) {
                      return CardListTileWithStatusColor(
                        title:
                            'Kebutuhan ${getHelpType(listTelahBerlalu[index].help_type.toString())}',
                        subtitle: 'Detail : ${listTelahBerlalu[index].notes}',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y').format(listTelahBerlalu[index].created_at)}',
                        statusColor: listTelahBerlalu[index].urgent_level == 1
                            ? smartRTStatusYellowColor
                            : smartRTStatusRedColor,
                        onTap: () {
                          DetailRiwayatBantuanPageArguments arguments =
                              DetailRiwayatBantuanPageArguments(
                                  dataBantuanID: listTelahBerlalu[index].id,
                                  type: type);
                          Navigator.pushNamed(
                              context, DetailRiwayatBantuanPage.id,
                              arguments: arguments);
                        },
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Tidak ada riwayat",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
