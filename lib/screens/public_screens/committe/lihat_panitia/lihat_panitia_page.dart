import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/committe/committe.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/committe_provider.dart';
import 'package:smart_rt/screens/public_screens/committe/lihat_panitia/lihat_panitia_page_detail.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/buat_janji_temu_page.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_1.dart';

class LihatPanitiaPage extends StatefulWidget {
  static const String id = 'LihatPanitiaPage';
  const LihatPanitiaPage({Key? key}) : super(key: key);

  @override
  State<LihatPanitiaPage> createState() => _LihatPanitiaPageState();
}

class _LihatPanitiaPageState extends State<LihatPanitiaPage> {
  User user = AuthProvider.currentUser!;

  void getData() async {
    await context.read<CommitteProvider>().getListCommitte();
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Committe> listPanitiaSekarang =
        context.watch<CommitteProvider>().listPanitiaSekarang;
    List<Committe> listPanitiaAktif = [];
    List<int> listPanitiaAktifIdx = [];
    List<Committe> listPanitiaDitolak = [];
    List<int> listPanitiaDitolakIdx = [];
    List<Committe> listPanitiaRequest = [];
    List<int> listPanitiaRequestIdx = [];

    for (var i = 0; i < listPanitiaSekarang.length; i++) {
      if (listPanitiaSekarang[i].status == 0) {
        listPanitiaRequest.add(listPanitiaSekarang[i]);
        listPanitiaRequestIdx.add(i);
      } else if (listPanitiaSekarang[i].status == 1) {
        listPanitiaAktif.add(listPanitiaSekarang[i]);
        listPanitiaAktifIdx.add(i);
      } else if (listPanitiaSekarang[i].status == -1) {
        listPanitiaDitolak.add(listPanitiaSekarang[i]);
        listPanitiaDitolakIdx.add(i);
      }
    }

    debugPrint(listPanitiaAktif.length.toString());
    debugPrint(listPanitiaRequest.length.toString());
    debugPrint(listPanitiaDitolak.length.toString());
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Panitia'),
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
            tabs: <Widget>[
              Tab(
                text: 'Aktif',
              ),
              Tab(
                text: 'Permohonan',
              ),
              Tab(
                text: 'Ditolak',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            listPanitiaAktif.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listPanitiaAktif.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTileUser1(
                            fullName:
                                listPanitiaAktif[index].data_user!.full_name,
                            address:
                                listPanitiaAktif[index].data_user!.address!,
                            initialName: StringFormat.initialName(
                                listPanitiaAktif[index].data_user!.full_name),
                            onTap: () {
                              LihatPanitiaPageDetailArgument args =
                                  LihatPanitiaPageDetailArgument(
                                      index: listPanitiaAktifIdx[index]);
                              Navigator.pushNamed(
                                  context, LihatPanitiaPageDetail.id,
                                  arguments: args);
                            },
                          ),
                          if (index == listPanitiaAktif.length - 1)
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
                      "Tidak ada Panitia",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listPanitiaRequest.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listPanitiaRequest.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTileUser1(
                            fullName:
                                listPanitiaRequest[index].data_user!.full_name,
                            address:
                                '${listPanitiaRequest[index].data_user!.address!}\n\n${(listPanitiaRequest[index].created_by!.user_role == Role.Warga) ? 'Menunggu Konfirmasi\n(Pendaftaran)' : 'Menunggu Konfirmasi\n(Rekomendasi)'}',
                            initialName: StringFormat.initialName(
                                listPanitiaRequest[index].data_user!.full_name),
                            onTap: () {
                              LihatPanitiaPageDetailArgument args =
                                  LihatPanitiaPageDetailArgument(
                                      index: listPanitiaRequestIdx[index]);
                              Navigator.pushNamed(
                                  context, LihatPanitiaPageDetail.id,
                                  arguments: args);
                            },
                          ),
                          if (index == listPanitiaRequest.length - 1)
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
                      "Tidak ada Panitia",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listPanitiaDitolak.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listPanitiaDitolak.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTileUser1(
                            fullName:
                                listPanitiaDitolak[index].data_user!.full_name,
                            address:
                                listPanitiaDitolak[index].data_user!.address!,
                            initialName: StringFormat.initialName(
                                listPanitiaDitolak[index].data_user!.full_name),
                            onTap: () {
                              LihatPanitiaPageDetailArgument args =
                                  LihatPanitiaPageDetailArgument(
                                      index: listPanitiaDitolakIdx[index]);
                              Navigator.pushNamed(
                                  context, LihatPanitiaPageDetail.id,
                                  arguments: args);
                            },
                          ),
                          if (index == listPanitiaDitolak.length - 1)
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
                      "Tidak ada Panitia",
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
