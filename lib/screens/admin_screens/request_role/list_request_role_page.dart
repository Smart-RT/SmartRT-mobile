import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/role_request_provider.dart';
import 'package:smart_rt/screens/admin_screens/request_role/detail_request_role_page.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/cards/card_with_time_location.dart';

class ListRequestRolePage extends StatefulWidget {
  static const String id = 'ListRequestRolePage';
  const ListRequestRolePage({Key? key}) : super(key: key);

  @override
  State<ListRequestRolePage> createState() => _ListRequestRolePageState();
}

class _ListRequestRolePageState extends State<ListRequestRolePage> {
  void getData() async {
    await context.read<RoleRequestProvider>().getUserRoleReqKetuaData();
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<UserRoleRequest> listUserRoleReqKetuaRT = [];
    List<UserRoleRequest> listUserRoleReqKetuaWaitingConfirmation = [];
    List<int> listUserRoleReqKetuaWaitingConfirmationIdx = [];
    List<UserRoleRequest> listUserRoleReqKetuaConfirmated = [];
    List<int> listUserRoleReqKetuaConfirmatedIdx = [];

    listUserRoleReqKetuaRT =
        context.watch<RoleRequestProvider>().listUserRoleReqKetuaRT;
    for (var i = 0; i < listUserRoleReqKetuaRT.length; i++) {
      if (listUserRoleReqKetuaRT[i].confirmater_id == null) {
        listUserRoleReqKetuaWaitingConfirmation.add(listUserRoleReqKetuaRT[i]);
        listUserRoleReqKetuaWaitingConfirmationIdx.add(i);
      } else {
        listUserRoleReqKetuaConfirmated.add(listUserRoleReqKetuaRT[i]);
        listUserRoleReqKetuaConfirmatedIdx.add(i);
      }
    }
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Riwayat Req Role Ketua RT'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Menunggu Konfirmasi',
              ),
              Tab(
                text: 'Sudah Dikonfirmasi',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            listUserRoleReqKetuaWaitingConfirmation.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listUserRoleReqKetuaWaitingConfirmation.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardWithTimeLocation(
                              title:
                                  listUserRoleReqKetuaWaitingConfirmation[index]
                                      .data_user_requester!
                                      .full_name,
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, DetailRequestRolePage.id,
                                    arguments: DetailRequestRolePageArguments(
                                        index:
                                            listUserRoleReqKetuaWaitingConfirmationIdx[
                                                index]));
                              },
                              subtitle:
                                  'No. Telp : ${listUserRoleReqKetuaWaitingConfirmation[index].data_user_requester!.phone}\n${listUserRoleReqKetuaWaitingConfirmation[index].data_user_requester!.address!}, ${listUserRoleReqKetuaWaitingConfirmation[index].urban_village_id!.name}, ${listUserRoleReqKetuaWaitingConfirmation[index].sub_district_id!.name}',
                              dateTime:
                                  'Dibuat pada tanggal \n${DateFormat('d MMMM y HH:mm', 'id_ID').format(listUserRoleReqKetuaWaitingConfirmation[index].created_at)}',
                              location:
                                  'RT/RW ${StringFormat.numFormatRTRW(listUserRoleReqKetuaWaitingConfirmation[index].rt_num.toString())}/${StringFormat.numFormatRTRW(listUserRoleReqKetuaWaitingConfirmation[index].rw_num.toString())}\n${listUserRoleReqKetuaWaitingConfirmation[index].urban_village_id!.name}\nKec. ${listUserRoleReqKetuaWaitingConfirmation[index].sub_district_id!.name}'),
                          if (index ==
                              listUserRoleReqKetuaWaitingConfirmation.length -
                                  1)
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
                      "Tidak ada Permohonan",
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            listUserRoleReqKetuaConfirmated.isNotEmpty
                ? ListView.separated(
                    separatorBuilder: (context, int) {
                      return Divider(
                        color: smartRTPrimaryColor,
                        thickness: 1,
                        height: 5,
                      );
                    },
                    itemCount: listUserRoleReqKetuaConfirmated.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardWithTimeLocation(
                            title: listUserRoleReqKetuaConfirmated[index]
                                .data_user_requester!
                                .full_name,
                            onTap: () async {
                              Navigator.pushNamed(
                                  context, DetailRequestRolePage.id,
                                  arguments: DetailRequestRolePageArguments(
                                      index: listUserRoleReqKetuaConfirmatedIdx[
                                          index]));
                            },
                            subtitle:
                                'No. Telp : ${listUserRoleReqKetuaConfirmated[index].data_user_requester!.phone}\n${listUserRoleReqKetuaConfirmated[index].data_user_requester!.address!}, ${listUserRoleReqKetuaConfirmated[index].urban_village_id!.name}, ${listUserRoleReqKetuaConfirmated[index].sub_district_id!.name}',
                            dateTime:
                                'Dibuat pada tanggal \n${DateFormat('d MMMM y HH:mm', 'id_ID').format(listUserRoleReqKetuaConfirmated[index].created_at)}',
                            location:
                                'RT/RW ${StringFormat.numFormatRTRW(listUserRoleReqKetuaConfirmated[index].rt_num.toString())}/${StringFormat.numFormatRTRW(listUserRoleReqKetuaConfirmated[index].rw_num.toString())}\n${listUserRoleReqKetuaConfirmated[index].urban_village_id!.name}\nKec. ${listUserRoleReqKetuaConfirmated[index].sub_district_id!.name}',
                            status: (listUserRoleReqKetuaConfirmated[index]
                                            .confirmater_id !=
                                        null &&
                                    listUserRoleReqKetuaConfirmated[index]
                                            .accepted_at !=
                                        null)
                                ? 'Diterima ${listUserRoleReqKetuaConfirmated[index].data_user_confirmater!.full_name}'
                                : 'Ditolak ${listUserRoleReqKetuaConfirmated[index].data_user_confirmater!.full_name}',
                          ),
                          if (index ==
                              listUserRoleReqKetuaConfirmated.length - 1)
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
                      "Tidak ada Permohonan",
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
