import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:smart_rt/providers/health_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';
import 'package:provider/provider.dart';

class LaporanWargaPage extends StatefulWidget {
  static const String id = 'LaporanWargaPage';
  const LaporanWargaPage({Key? key}) : super(key: key);

  @override
  State<LaporanWargaPage> createState() => _LaporanWargaPageState();
}

class _LaporanWargaPageState extends State<LaporanWargaPage> {
  Future<void> getData() async {
    context.read<HealthProvider>().futures[LaporanWargaPage.id] = context
        .read<HealthProvider>()
        .getListUserHealthReport(context: context);
    context.read<HealthProvider>().updateListener();
    await context.read<HealthProvider>().futures[LaporanWargaPage.id];
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<UserHealthReport> listLaporanWarga =
        context.watch<HealthProvider>().listUserHealthReport;
    List<UserHealthReport> listMenungguKonfirmasi = listLaporanWarga
        .where((element) => element.confirmation_status == -1)
        .toList();
    List<UserHealthReport> listTelahDikonfirmasi = listLaporanWarga
        .where((element) => element.confirmation_status! > -1)
        .toList();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Laporan dari Warga'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Menunggu Konfirmasi',
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
                    .watch<HealthProvider>()
                    .futures[LaporanWargaPage.id],
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

                  return listMenungguKonfirmasi.isNotEmpty
                      ? ListView.separated(
                          separatorBuilder: (context, int) {
                            return Divider(
                              color: smartRTPrimaryColor,
                              thickness: 1,
                              height: 5,
                            );
                          },
                          itemCount: listMenungguKonfirmasi.length,
                          itemBuilder: (context, index) {
                            return CardListTileWithStatusColor(
                              title:
                                  'Golongan Penyakit ${listMenungguKonfirmasi[index].disease_group!.name}',
                              subtitle:
                                  'Detail : ${listMenungguKonfirmasi[index].disease_level == 1 ? 'Sakit Ringan' : listMenungguKonfirmasi[index].disease_level == 2 ? 'Sakit Sedang' : 'Sakit Berat'} - ${listMenungguKonfirmasi[index].disease_notes}',
                              maxLineSubtitle: 2,
                              bottomText:
                                  'Tanggal dibuat : ${DateFormat('d MMMM y', 'id_ID').format(listMenungguKonfirmasi[index].created_at)}',
                              statusColor: smartRTPrimaryColor,
                              onTap: () {
                                DetailRiwayatKesehatanArguments arguments =
                                    DetailRiwayatKesehatanArguments(
                                        dataReport:
                                            listMenungguKonfirmasi[index]);
                                Navigator.pushNamed(
                                    context, DetailRiwayatKesehatanPage.id,
                                    arguments: arguments);
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
              ),
            ),
            RefreshIndicator(
              onRefresh: () => getData(),
              child: FutureBuilder(
                future: context
                    .watch<HealthProvider>()
                    .futures[LaporanWargaPage.id],
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
                              title:
                                  'Golongan Penyakit ${listTelahDikonfirmasi[index].disease_group!.name}',
                              subtitle:
                                  'Detail : ${listTelahDikonfirmasi[index].disease_level == 1 ? 'Sakit Ringan' : listTelahDikonfirmasi[index].disease_level == 2 ? 'Sakit Sedang' : 'Sakit Berat'} - ${listTelahDikonfirmasi[index].disease_notes}',
                              maxLineSubtitle: 2,
                              bottomText:
                                  'Tanggal dibuat : ${DateFormat('d MMMM y', 'id_ID').format(listTelahDikonfirmasi[index].created_at)}',
                              statusColor: listTelahDikonfirmasi[index]
                                          .confirmation_status ==
                                      0
                                  ? smartRTStatusRedColor
                                  : smartRTStatusGreenColor,
                              onTap: () {
                                DetailRiwayatKesehatanArguments arguments =
                                    DetailRiwayatKesehatanArguments(
                                        dataReport:
                                            listTelahDikonfirmasi[index]);
                                Navigator.pushNamed(
                                    context, DetailRiwayatKesehatanPage.id,
                                    arguments: arguments);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
