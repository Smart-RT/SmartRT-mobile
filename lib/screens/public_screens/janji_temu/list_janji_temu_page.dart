import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/meet/meeting.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/buat_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_detail_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_with_time_location.dart';

class ListJanjiTemuPage extends StatefulWidget {
  static const String id = 'ListJanjiTemuPage';
  const ListJanjiTemuPage({Key? key}) : super(key: key);

  @override
  State<ListJanjiTemuPage> createState() => _ListJanjiTemuPageState();
}

class _ListJanjiTemuPageState extends State<ListJanjiTemuPage> {
  List<Meeting> listMeetingPermohonan = [];
  List<Meeting> listMeetingTerjadwalkan = [];
  List<Meeting> listMeetingTelahBerlalu = [];
  List<Meeting> listMeetingStatusNegative = [];
  User user = AuthProvider.currentUser!;

  void getData() async {
    Response<dynamic> respPermohonan =
        await NetUtil().dioClient.get('/meet/get/status/permohonan');
    listMeetingPermohonan.clear();
    listMeetingPermohonan.addAll((respPermohonan.data).map<Meeting>((request) {
      return Meeting.fromData(request);
    }));

    Response<dynamic> respTerjadwalkan =
        await NetUtil().dioClient.get('/meet/get/status/terjadwalkan');
    listMeetingTerjadwalkan.clear();
    listMeetingTerjadwalkan
        .addAll((respTerjadwalkan.data).map<Meeting>((request) {
      return Meeting.fromData(request);
    }));

    Response<dynamic> respTelahBerlalu =
        await NetUtil().dioClient.get('/meet/get/status/telah-berlalu');
    listMeetingTelahBerlalu.clear();
    listMeetingTelahBerlalu
        .addAll((respTelahBerlalu.data).map<Meeting>((request) {
      return Meeting.fromData(request);
    }));

    Response<dynamic> respStatusNegative =
        await NetUtil().dioClient.get('/meet/get/status/status-negative');
    listMeetingStatusNegative.clear();
    listMeetingStatusNegative
        .addAll((respStatusNegative.data).map<Meeting>((request) {
      return Meeting.fromData(request);
    }));

    debugPrint(listMeetingPermohonan.length.toString());

    setState(() {});
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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Janji Temu'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, BuatJanjiTemuPage.id);
              },
            ),
            SB_height15,
          ],
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'Terjadwalkan',
              ),
              Tab(
                text: 'Permohonan',
              ),
              Tab(
                text: 'Telah Berlalu',
              ),
              Tab(
                text: 'Dibatalkan / Ditolak',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            listMeetingTerjadwalkan.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listMeetingTerjadwalkan.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardWithTimeLocation(
                            title: listMeetingTerjadwalkan[index].title,
                            onTap: () async {
                              Navigator.pushNamed(
                                  context, ListJanjiTemuDetailPage.id,
                                  arguments: ListJanjiTemuDetailPageArgument(
                                      dataJanjiTemu:
                                          listMeetingTerjadwalkan[index]));
                            },
                            subtitle: listMeetingTerjadwalkan[index].detail,
                            dateTime: DateFormat('d MMMM y HH:mm', 'id_ID')
                                .format(listMeetingTerjadwalkan[index]
                                    .meet_datetime),
                            location: listMeetingTerjadwalkan[index]
                                        .new_respondent_by ==
                                    null
                                ? 'Rumah ${listMeetingTerjadwalkan[index].origin_respondent_by!.full_name}\n${listMeetingTerjadwalkan[index].origin_respondent_by!.address!}'
                                : 'Rumah ${listMeetingTerjadwalkan[index].new_respondent_by!.full_name}\n${listMeetingTerjadwalkan[index].new_respondent_by!.address!}',
                          ),
                          if (index == listMeetingTerjadwalkan.length - 1)
                            Divider(
                              color: smartRTPrimaryColor,
                              thickness: 1,
                              height: 5,
                            ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Tidak ada Janji Temu",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listMeetingPermohonan.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listMeetingPermohonan.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardWithTimeLocation(
                            title: listMeetingPermohonan[index].title,
                            onTap: () async {
                              Navigator.pushNamed(
                                  context, ListJanjiTemuDetailPage.id,
                                  arguments: ListJanjiTemuDetailPageArgument(
                                      dataJanjiTemu:
                                          listMeetingPermohonan[index]));
                            },
                            subtitle: listMeetingPermohonan[index].detail,
                            dateTime: DateFormat('d MMMM y HH:mm', 'id_ID')
                                .format(
                                    listMeetingPermohonan[index].meet_datetime),
                            location: listMeetingPermohonan[index]
                                        .new_respondent_by ==
                                    null
                                ? 'Rumah ${listMeetingPermohonan[index].origin_respondent_by!.full_name}\n${listMeetingPermohonan[index].origin_respondent_by!.address!}'
                                : 'Rumah ${listMeetingPermohonan[index].new_respondent_by!.full_name}\n${listMeetingPermohonan[index].new_respondent_by!.address!}',
                            status: (listMeetingPermohonan[index]
                                        .created_by!
                                        .id ==
                                    listMeetingPermohonan[index]
                                        .meet_datetime_negotiated_by!
                                        .id)
                                ? 'Menunggu Konfirmasi Responden\n(${listMeetingPermohonan[index].new_respondent_by == null ? listMeetingPermohonan[index].origin_respondent_by!.full_name : listMeetingPermohonan[index].new_respondent_by!.full_name})'
                                : 'Menunggu Konfirmasi Pemohon',
                          ),
                          if (index == listMeetingPermohonan.length - 1)
                            Divider(
                              color: smartRTPrimaryColor,
                              thickness: 1,
                              height: 5,
                            ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Tidak ada Janji Temu",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listMeetingTelahBerlalu.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listMeetingTelahBerlalu.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardWithTimeLocation(
                            title: listMeetingTelahBerlalu[index].title,
                            onTap: () async {
                              Navigator.pushNamed(
                                  context, ListJanjiTemuDetailPage.id,
                                  arguments: ListJanjiTemuDetailPageArgument(
                                      dataJanjiTemu:
                                          listMeetingTelahBerlalu[index]));
                            },
                            subtitle: listMeetingTelahBerlalu[index].detail,
                            dateTime: DateFormat('d MMMM y HH:mm', 'id_ID')
                                .format(listMeetingTelahBerlalu[index]
                                    .meet_datetime),
                            location: listMeetingTelahBerlalu[index]
                                        .new_respondent_by ==
                                    null
                                ? 'Rumah ${listMeetingTelahBerlalu[index].origin_respondent_by!.full_name}\n${listMeetingTelahBerlalu[index].origin_respondent_by!.address!}'
                                : 'Rumah ${listMeetingTelahBerlalu[index].new_respondent_by!.full_name}\n${listMeetingTelahBerlalu[index].new_respondent_by!.address!}',
                            status: (listMeetingTelahBerlalu[index].status == 0)
                                ? 'Tidak Terkonfirmasi'
                                : 'Selesai',
                          ),
                          if (index == listMeetingTelahBerlalu.length - 1)
                            Divider(
                              color: smartRTPrimaryColor,
                              thickness: 1,
                              height: 5,
                            ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Tidak ada Janji Temu",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listMeetingStatusNegative.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listMeetingStatusNegative.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardWithTimeLocation(
                              title: listMeetingStatusNegative[index].title,
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, ListJanjiTemuDetailPage.id,
                                    arguments: ListJanjiTemuDetailPageArgument(
                                        dataJanjiTemu:
                                            listMeetingStatusNegative[index]));
                              },
                              subtitle: listMeetingStatusNegative[index].detail,
                              dateTime: DateFormat('d MMMM y HH:mm', 'id_ID')
                                  .format(listMeetingStatusNegative[index]
                                      .meet_datetime),
                              location: listMeetingStatusNegative[index].new_respondent_by == null
                                  ? 'Rumah ${listMeetingStatusNegative[index].origin_respondent_by!.full_name}\n${listMeetingStatusNegative[index].origin_respondent_by!.address!}'
                                  : 'Rumah ${listMeetingStatusNegative[index].new_respondent_by!.full_name}\n${listMeetingStatusNegative[index].new_respondent_by!.address!}',
                              status: (listMeetingStatusNegative[index].status == -1 &&
                                      listMeetingStatusNegative[index]
                                              .confirmated_by!
                                              .id !=
                                          listMeetingStatusNegative[index]
                                              .created_by!
                                              .id)
                                  ? 'Ditolak oleh Responden'
                                  : (listMeetingStatusNegative[index].status == -1 &&
                                          listMeetingStatusNegative[index]
                                                  .confirmated_by!
                                                  .id ==
                                              listMeetingStatusNegative[index]
                                                  .created_by!
                                                  .id)
                                      ? 'Ditolak oleh Pemohon'
                                      : listMeetingStatusNegative[index].created_by!.id ==
                                              listMeetingStatusNegative[index]
                                                  .confirmated_by!
                                                  .id
                                          ? 'Dibatalkan oleh Pemohon'
                                          : 'Dibatalkan oleh Responden'),
                          if (index == listMeetingStatusNegative.length - 1)
                            Divider(
                              color: smartRTPrimaryColor,
                              thickness: 1,
                              height: 5,
                            ),
                        ],
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "Tidak ada Janji Temu",
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
