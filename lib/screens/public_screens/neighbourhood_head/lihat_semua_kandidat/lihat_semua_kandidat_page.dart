import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/neighbourhood_head_provider.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_semua_kandidat/lihat_semua_kandidat_page_detail.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_1.dart';

class LihatSemuaKandidatPage extends StatefulWidget {
  static const String id = 'LihatSemuaKandidatPage';
  const LihatSemuaKandidatPage({Key? key}) : super(key: key);

  @override
  State<LihatSemuaKandidatPage> createState() => _LihatSemuaKandidatPageState();
}

class _LihatSemuaKandidatPageState extends State<LihatSemuaKandidatPage> {
  User user = AuthProvider.currentUser!;

  void getData() async {
    await context
        .read<NeighbourhoodHeadProvider>()
        .getListNeighbourhoodHeadCandidateThisPeriod(
            periode: user.area!.periode.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<NeighbourhoodHeadCandidate> listKandidat = context
        .watch<NeighbourhoodHeadProvider>()
        .listKandidatPengurusRTSekarang;
    List<NeighbourhoodHeadCandidate> listKandidatAktif = [];
    List<int> listKandidatAktifIdx = [];
    List<NeighbourhoodHeadCandidate> listKandidatDiskualifikasi = [];
    List<int> listKandidatDiskualifikasiIdx = [];
    List<NeighbourhoodHeadCandidate> listKandidatMengundurkanDiri = [];
    List<int> listKandidatMengundurkanDiriIdx = [];

    for (var i = 0; i < listKandidat.length; i++) {
      if (listKandidat[i].status == -2) {
        listKandidatMengundurkanDiri.add(listKandidat[i]);
        listKandidatMengundurkanDiriIdx.add(i);
      } else if (listKandidat[i].status == 1) {
        listKandidatAktif.add(listKandidat[i]);
        listKandidatAktifIdx.add(i);
      } else if (listKandidat[i].status == -1) {
        listKandidatDiskualifikasi.add(listKandidat[i]);
        listKandidatDiskualifikasiIdx.add(i);
      }
    }

    debugPrint(listKandidatAktif.length.toString());
    debugPrint(listKandidatMengundurkanDiri.length.toString());
    debugPrint(listKandidatDiskualifikasi.length.toString());
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Daftar Kandidat Pengurus RT'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: 'Aktif',
              ),
              Tab(
                text: 'Mengundurkan Diri',
              ),
              Tab(
                text: 'Diskualifikasi',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            listKandidatAktif.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listKandidatAktif.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTileUser1(
                            fullName:
                                listKandidatAktif[index].dataUser!.full_name,
                            address:
                                listKandidatAktif[index].dataUser!.address!,
                            initialName: StringFormat.initialName(
                                listKandidatAktif[index].dataUser!.full_name),
                            onTap: () {
                              LihatSemuaKandidatPageDetailArgument args =
                                  LihatSemuaKandidatPageDetailArgument(
                                      index: listKandidatAktifIdx[index]);
                              Navigator.pushNamed(
                                  context, LihatSemuaKandidatPageDetail.id,
                                  arguments: args);
                            },
                          ),
                          if (index == listKandidatAktif.length - 1)
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
                      "Tidak ada Kandidat",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listKandidatMengundurkanDiri.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listKandidatMengundurkanDiri.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTileUser1(
                            fullName: listKandidatMengundurkanDiri[index]
                                .dataUser!
                                .full_name,
                            address:
                                '${listKandidatMengundurkanDiri[index].dataUser!.address!}\n\n${(listKandidatMengundurkanDiri[index].created_by!.user_role == Role.Warga) ? 'Menunggu Konfirmasi\n(Pendaftaran)' : 'Menunggu Konfirmasi\n(Rekomendasi)'}',
                            initialName: StringFormat.initialName(
                                listKandidatMengundurkanDiri[index]
                                    .dataUser!
                                    .full_name),
                            onTap: () {
                              LihatSemuaKandidatPageDetailArgument args =
                                  LihatSemuaKandidatPageDetailArgument(
                                      index: listKandidatMengundurkanDiriIdx[
                                          index]);
                              Navigator.pushNamed(
                                  context, LihatSemuaKandidatPageDetail.id,
                                  arguments: args);
                            },
                          ),
                          if (index == listKandidatMengundurkanDiri.length - 1)
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
                      "Tidak ada Kandidat",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listKandidatDiskualifikasi.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listKandidatDiskualifikasi.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTileUser1(
                            fullName: listKandidatDiskualifikasi[index]
                                .dataUser!
                                .full_name,
                            address: listKandidatDiskualifikasi[index]
                                .dataUser!
                                .address!,
                            initialName: StringFormat.initialName(
                                listKandidatDiskualifikasi[index]
                                    .dataUser!
                                    .full_name),
                            onTap: () {
                              LihatSemuaKandidatPageDetailArgument args =
                                  LihatSemuaKandidatPageDetailArgument(
                                      index:
                                          listKandidatDiskualifikasiIdx[index]);
                              Navigator.pushNamed(
                                  context, LihatSemuaKandidatPageDetail.id,
                                  arguments: args);
                            },
                          ),
                          if (index == listKandidatDiskualifikasi.length - 1)
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
                      "Tidak ada Kandidat",
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
