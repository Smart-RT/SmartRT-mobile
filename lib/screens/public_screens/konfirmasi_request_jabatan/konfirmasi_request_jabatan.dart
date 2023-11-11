import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/role_request_provider.dart';
import 'package:smart_rt/screens/public_screens/konfirmasi_request_jabatan/detail_konfirmasi_request_jabatan_page.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';

class KonfirmasiRequestJabatan extends StatefulWidget {
  static const String id = 'KonfirmasiRequestJabatan';
  const KonfirmasiRequestJabatan({super.key});

  @override
  State<KonfirmasiRequestJabatan> createState() =>
      _KonfirmasiRequestJabatanState();
}

class _KonfirmasiRequestJabatanState extends State<KonfirmasiRequestJabatan> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      context.read<RoleRequestProvider>().getUserRoleReqPengurusData();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<UserRoleRequest> listUserRoleReq =
        context.watch<RoleRequestProvider>().listUserRoleReqPengurus;
    List<UserRoleRequest> permohonan = listUserRoleReq
        .where((ur) => ur.accepted_at == null && ur.rejected_at == null)
        .toList();
    List<UserRoleRequest> telahKonfirmasi =
        listUserRoleReq.where((ur) => ur.confirmater_id != null).toList();
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Konfirmasi Request Jabatan"),
          bottom: TabBar(tabs: [
            Tab(
              text: 'Permohonan',
            ),
            Tab(
              text: 'Telah Dikonfirmasi',
            )
          ]),
        ),
        body: Container(
            child: TabBarView(
          children: [
            permohonan.length <= 0
                ? ListView(
                    children: [
                      SB_height15,
                      Center(
                        child: Text(
                          "Tidak ada riwayat",
                          style: smartRTTextLarge.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    itemCount: permohonan.length,
                    separatorBuilder: (context, indx) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemBuilder: (context, index) {
                      return CardListTileWithStatusColor(
                        title: permohonan[index].data_user_requester!.full_name,
                        subtitle:
                            permohonan[index].data_user_requester!.address ??
                                '',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y', 'id_ID').format(permohonan[index].created_at)}',
                        statusColor: smartRTStatusYellowColor,
                        onTap: () {
                          DetailKonfirmasiRequestJabatanArguments args =
                              DetailKonfirmasiRequestJabatanArguments(
                                  dataKonfirmasi: permohonan[index]);
                          Navigator.pushNamed(
                              context, DetailKonfirmasiRequestJabatanPage.id,
                              arguments: args);
                        },
                      );
                    },
                  ),
            telahKonfirmasi.length <= 0
                ? ListView(
                    children: [
                      SB_height15,
                      Center(
                        child: Text(
                          "Tidak ada riwayat",
                          style: smartRTTextLarge.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : ListView.separated(
                    itemCount: telahKonfirmasi.length,
                    separatorBuilder: (context, indx) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemBuilder: (context, index) {
                      return CardListTileWithStatusColor(
                        title: telahKonfirmasi[index]
                            .data_user_requester!
                            .full_name,
                        subtitle: telahKonfirmasi[index]
                                .data_user_requester!
                                .address ??
                            '',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y', 'id_ID').format(telahKonfirmasi[index].created_at)}',
                        statusColor: telahKonfirmasi[index].accepted_at == null
                            ? smartRTErrorColor
                            : smartRTSuccessColor,
                        onTap: () {
                          DetailKonfirmasiRequestJabatanArguments args =
                              DetailKonfirmasiRequestJabatanArguments(
                                  dataKonfirmasi: telahKonfirmasi[index]);
                          Navigator.pushNamed(
                              context, DetailKonfirmasiRequestJabatanPage.id,
                              arguments: args);
                        },
                      );
                    },
                  )
          ],
        )),
      ),
    );
  }
}
