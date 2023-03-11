import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_detail_page.dart';
import 'package:smart_rt/screens/public_screens/administration/create/administration_create_page_1.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/constants/size.dart';

class AdministrationPage extends StatefulWidget {
  static const String id = 'AdministrationPage';

  const AdministrationPage({Key? key}) : super(key: key);

  @override
  State<AdministrationPage> createState() => _AdministrationPageState();
}

class _AdministrationPageState extends State<AdministrationPage> {
  User user = AuthProvider.currentUser!;
  List<Administration> listPermohonan = [];
  List<Administration> listDiterima = [];
  List<Administration> listDitolak = [];

  void getData() async {
    Response<dynamic> resp;

    resp = await NetUtil()
        .dioClient
        .get('/administration/area/${user.area!.id}/status/0');
    listPermohonan.addAll((resp.data).map<Administration>((request) {
      return Administration.fromData(request);
    }));

    resp = await NetUtil()
        .dioClient
        .get('/administration/area/${user.area!.id}/status/1');
    listDiterima.addAll((resp.data).map<Administration>((request) {
      return Administration.fromData(request);
    }));

    resp = await NetUtil()
        .dioClient
        .get('/administration/area/${user.area!.id}/status/-1');
    listDitolak.addAll((resp.data).map<Administration>((request) {
      return Administration.fromData(request);
    }));

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
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Administrasi'),
          actions: [
            if (user.user_role != Role.Ketua_RT)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AdministrationCreatePage1.id);
                    },
                    child: const Icon(Icons.add),
                  ),
                  SB_width25,
                ],
              )
          ],
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Permohonan',
              ),
              Tab(
                text: 'Diterima',
              ),
              Tab(
                text: 'Ditolak',
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
                        title: listPermohonan[index].administration_type!.name,
                        subtitle:
                            '${listPermohonan[index].creator_fullname}\n${listPermohonan[index].creator_address}',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y').format(listPermohonan[index].created_at)}',
                        statusColor: smartRTTertiaryColor,
                        onTap: () {
                          AdministrationDetailPageArgument args =
                              AdministrationDetailPageArgument(
                                  dataAdm: listPermohonan[index]);

                          Navigator.pushNamed(
                              context, AdministrationDetailPage.id,
                              arguments: args);
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
            listDiterima.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listDiterima.length,
                    itemBuilder: (context, index) {
                      return CardListTileWithStatusColor(
                        title: listDiterima[index].administration_type!.name,
                        subtitle:
                            '${listDiterima[index].creator_fullname}\n${listDiterima[index].creator_address}',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y').format(listDiterima[index].created_at)}',
                        statusColor: smartRTTertiaryColor,
                        onTap: () {
                          AdministrationDetailPageArgument args =
                              AdministrationDetailPageArgument(
                                  dataAdm: listDiterima[index]);

                          Navigator.pushNamed(
                              context, AdministrationDetailPage.id,
                              arguments: args);
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
            listDitolak.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listDitolak.length,
                    itemBuilder: (context, index) {
                      return CardListTileWithStatusColor(
                        title: listDitolak[index].administration_type!.name,
                        subtitle:
                            '${listDitolak[index].creator_fullname}\n${listDitolak[index].creator_address}',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y').format(listDitolak[index].created_at)}',
                        statusColor: smartRTTertiaryColor,
                        onTap: () {
                          AdministrationDetailPageArgument args =
                              AdministrationDetailPageArgument(
                                  dataAdm: listDitolak[index]);

                          Navigator.pushNamed(
                              context, AdministrationDetailPage.id,
                              arguments: args);
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
