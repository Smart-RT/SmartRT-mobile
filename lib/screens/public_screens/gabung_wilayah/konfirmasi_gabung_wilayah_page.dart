import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/health_task_help.dart';
import 'package:smart_rt/models/user_role_request.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';

class KonfirmasiGabungWilayahPage extends StatefulWidget {
  static const String id = 'KonfirmasiGabungWilayahPage';
  const KonfirmasiGabungWilayahPage({Key? key}) : super(key: key);

  @override
  State<KonfirmasiGabungWilayahPage> createState() =>
      _KonfirmasiGabungWilayahPageState();
}

class _KonfirmasiGabungWilayahPageState
    extends State<KonfirmasiGabungWilayahPage> {
  List<UserRoleRequest> listPermohonan = [];
  List<UserRoleRequest> listTelahDikonfirmasi = [];

  void getData() async {
    Response<dynamic> resp;
    resp = await NetUtil()
        .dioClient
        .get('/users/getRoleRequest/typeReqRole/warga/isConfirmation/yes');
    listTelahDikonfirmasi.addAll((resp.data).map<UserRoleRequest>((request) {
      return UserRoleRequest.fromData(request);
    }));
    resp = await NetUtil()
        .dioClient
        .get('/users/getRoleRequest/typeReqRole/warga/isConfirmation/no');
    listPermohonan.addAll((resp.data).map<UserRoleRequest>((request) {
      return UserRoleRequest.fromData(request);
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
                        title: listPermohonan[index]
                            .data_user_requester!
                            .full_name,
                        subtitle: listPermohonan[index]
                                .data_user_requester!
                                .address ??
                            '',
                        bottomText:
                            'Tanggal dibuat : ${DateFormat('d MMMM y').format(listPermohonan[index].created_at)}',
                        statusColor: smartRTStatusYellowColor,
                        onTap: () {},
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
            listTelahDikonfirmasi.isNotEmpty
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
                            'Tanggal dibuat : ${DateFormat('d MMMM y').format(listTelahDikonfirmasi[index].created_at)}',
                        statusColor: smartRTStatusYellowColor,
                        onTap: () {},
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
