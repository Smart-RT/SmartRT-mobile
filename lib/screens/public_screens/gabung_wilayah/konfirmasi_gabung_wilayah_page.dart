import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/role_request_provider.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/detail_konfirmasi_gabung_wilayah_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';
import 'package:provider/provider.dart';

class KonfirmasiGabungWilayahPage extends StatefulWidget {
  static const String id = 'KonfirmasiGabungWilayahPage';
  const KonfirmasiGabungWilayahPage({Key? key}) : super(key: key);

  @override
  State<KonfirmasiGabungWilayahPage> createState() =>
      _KonfirmasiGabungWilayahPageState();
}

class _KonfirmasiGabungWilayahPageState
    extends State<KonfirmasiGabungWilayahPage> {
  Future<void> getData() async {
    context
            .read<RoleRequestProvider>()
            .futures['${KonfirmasiGabungWilayahPage.id}-yes'] =
        context.read<RoleRequestProvider>().getUserRoleReqWargaYes();
    context
            .read<RoleRequestProvider>()
            .futures['${KonfirmasiGabungWilayahPage.id}-no'] =
        context.read<RoleRequestProvider>().getUserRoleReqWargaNo();
    context.read<RoleRequestProvider>().updateListener();
    await context
        .read<RoleRequestProvider>()
        .futures['${KonfirmasiGabungWilayahPage.id}-yes'];
    await context
        .read<RoleRequestProvider>()
        .futures['${KonfirmasiGabungWilayahPage.id}-no'];
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    List<UserRoleRequest> listPermohonan =
        context.watch<RoleRequestProvider>().listUserRoleReqWargaPermohonan;
    List<UserRoleRequest> listTelahDikonfirmasi =
        context.watch<RoleRequestProvider>().listUserRoleReqWargaDikonfirmasi;
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Konfirmasi Gabung Wilayah'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Permohonan',
              ),
              Tab(
                text: 'Telah Dikonfirmasi',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RefreshIndicator(
                onRefresh: () => getData(),
                child: FutureBuilder(
                  future: context
                      .watch<RoleRequestProvider>()
                      .futures['${KonfirmasiGabungWilayahPage.id}-yes'],
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: ListView(
                          children: [
                            Text('Terjadi kesalahan, mohon refresh data...'),
                          ],
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: ListView(
                          children: [
                            Text('Sedang mengambil data, mohon tunggu...'),
                          ],
                        ),
                      );
                    }

                    return listPermohonan.isNotEmpty
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
                                title: listPermohonan[index]
                                    .data_user_requester!
                                    .full_name,
                                subtitle: listPermohonan[index]
                                        .data_user_requester!
                                        .address ??
                                    '',
                                bottomText:
                                    'Tanggal dibuat : ${DateFormat('d MMMM y', 'id_ID').format(listPermohonan[index].created_at)}',
                                statusColor: smartRTStatusYellowColor,
                                onTap: () {
                                  DetailKonfirmasiGabungWilayahArguments args =
                                      DetailKonfirmasiGabungWilayahArguments(
                                          dataKonfirmasi:
                                              listPermohonan[index]);
                                  Navigator.pushNamed(context,
                                      DetailKonfirmasiGabungWilayahPage.id,
                                      arguments: args);
                                },
                              );
                            },
                          )
                        : ListView(
                            children: [
                              SB_height15,
                              Center(
                                child: Text(
                                  "Tidak ada riwayat",
                                  style: smartRTTextLarge.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                  },
                )),
            RefreshIndicator(
                onRefresh: () => getData(),
                child: FutureBuilder(
                  future: context
                      .watch<RoleRequestProvider>()
                      .futures['${KonfirmasiGabungWilayahPage.id}-no'],
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: ListView(
                          children: [
                            Text('Terjadi kesalahan, mohon refresh data...'),
                          ],
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: EdgeInsets.all(15),
                        child: ListView(
                          children: [
                            Text('Sedang mengambil data, mohon tunggu...'),
                          ],
                        ),
                      );
                    }

                    return listTelahDikonfirmasi.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, int) {
                              return Divider(
                                color: smartRTPrimaryColor,
                                thickness: 1,
                                height: 5,
                              );
                            },
                            itemCount: listTelahDikonfirmasi.length,
                            itemBuilder: (context, index) {
                              return CardListTileWithStatusColor(
                                title: listTelahDikonfirmasi[index]
                                    .data_user_requester!
                                    .full_name,
                                subtitle: listTelahDikonfirmasi[index]
                                        .data_user_requester!
                                        .address ??
                                    '',
                                bottomText:
                                    'Tanggal dibuat : ${DateFormat('d MMMM y', 'id_ID').format(listTelahDikonfirmasi[index].created_at)}',
                                statusColor:
                                    listTelahDikonfirmasi[index].accepted_at ==
                                            null
                                        ? smartRTErrorColor
                                        : smartRTSuccessColor,
                                onTap: () {
                                  DetailKonfirmasiGabungWilayahArguments args =
                                      DetailKonfirmasiGabungWilayahArguments(
                                          dataKonfirmasi:
                                              listTelahDikonfirmasi[index]);
                                  Navigator.pushNamed(context,
                                      DetailKonfirmasiGabungWilayahPage.id,
                                      arguments: args);
                                },
                              );
                            },
                          )
                        : ListView(
                            children: [
                              SB_height15,
                              Center(
                                child: Text(
                                  "Tidak ada riwayat",
                                  style: smartRTTextLarge.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
