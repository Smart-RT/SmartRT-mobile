import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/role_request_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class DetailKonfirmasiRequestJabatanArguments {
  UserRoleRequest dataKonfirmasi;
  DetailKonfirmasiRequestJabatanArguments({required this.dataKonfirmasi});
}

class DetailKonfirmasiRequestJabatanPage extends StatefulWidget {
  static const String id = 'DetailKonfirmasiRequestJabatanPage';
  final DetailKonfirmasiRequestJabatanArguments args;
  DetailKonfirmasiRequestJabatanPage({Key? key, required this.args})
      : super(key: key);

  @override
  State<DetailKonfirmasiRequestJabatanPage> createState() =>
      _DetailKonfirmasiRequestJabatanPageState();
}

class _DetailKonfirmasiRequestJabatanPageState
    extends State<DetailKonfirmasiRequestJabatanPage> {
  void terimaPermintaan() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menerimanya menjadi ${Role.values[widget.args.dataKonfirmasi.request_role - 1].toString().split('.').last.replaceAll('_', ' ')} wilayah anda?\n\nMohon pastikan terlebih dahulu bahwa ia adalah warga wilayah anda!',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text(
                  'Batal',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  updateKonfirmasi('terima');
                },
                child: Text(
                  'TERIMA LAPORAN',
                  style: smartRTTextNormal.copyWith(
                    fontWeight: FontWeight.bold,
                    color: smartRTStatusGreenColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void tolakPermintaan() async {
    final _alasanController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menolak permohonan untuk menjadi ${Role.values[widget.args.dataKonfirmasi.request_role - 1].toString().split('.').last.replaceAll('_', ' ')} wilayah anda?',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  _alasanController.text = '';
                  Navigator.pop(context, 'Batal');
                },
                child: Text(
                  'Batal',
                  style: smartRTTextNormal.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  updateKonfirmasi('tolak');
                },
                child: Text(
                  'TOLAK LAPORAN',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold, color: smartRTErrorColor2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateKonfirmasi(String typeConfirmation) async {
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .patch('/users/update/roleReq/pengurus', data: {
      "idRoleReq": widget.args.dataKonfirmasi.id,
      "typeConfirmation": typeConfirmation
    });
    if (resp.statusCode.toString() == '200') {
      int indexUpdate = context
          .read<RoleRequestProvider>()
          .listUserRoleReqPengurus
          .indexOf(widget.args.dataKonfirmasi);
      context
          .read<RoleRequestProvider>()
          .listUserRoleReqPengurus[indexUpdate]
          .confirmater_id = AuthProvider.currentUser!.id;
      context
          .read<RoleRequestProvider>()
          .listUserRoleReqPengurus[indexUpdate]
          .data_user_confirmater = AuthProvider.currentUser!;
      if (typeConfirmation == 'terima') {
        context
            .read<RoleRequestProvider>()
            .listUserRoleReqPengurus[indexUpdate]
            .accepted_at = DateTime.now();
        await NetUtil().dioClient.post('/users/role/log/add', data: {
          "user_id": widget.args.dataKonfirmasi.data_user_requester!.id,
          "before_user_role_id":
              widget.args.dataKonfirmasi.data_user_requester!.user_role,
          "after_user_role_id": widget.args.dataKonfirmasi.request_code,
        });

        // Update halaman saya, update area id dari current user
        User u = context.read<AuthProvider>().user!;
        if (widget.args.dataKonfirmasi.request_role == 4) {
          u.area!.bendahara_id =
              widget.args.dataKonfirmasi.data_user_requester!;
        } else if (widget.args.dataKonfirmasi.request_role == 5) {
          u.area!.sekretaris_id =
              widget.args.dataKonfirmasi.data_user_requester!;
        } else if (widget.args.dataKonfirmasi.request_role == 6) {
          u.area!.wakil_ketua_id =
              widget.args.dataKonfirmasi.data_user_requester!;
        }

        AuthProvider.currentUser = u;
        context.read<AuthProvider>().saveUserDataToStorage();
        context.read<AuthProvider>().updateListener();
      } else {
        context
            .read<RoleRequestProvider>()
            .listUserRoleReqPengurus[indexUpdate]
            .rejected_at = DateTime.now();
      }
      context.read<RoleRequestProvider>().updateListener();
      Navigator.pop(context);
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = context
        .read<RoleRequestProvider>()
        .listUserRoleReqPengurus
        .indexOf(widget.args.dataKonfirmasi);
    UserRoleRequest roleReq =
        context.watch<RoleRequestProvider>().listUserRoleReqPengurus[index];
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'DETAIL',
                style: smartRTTextTitle.copyWith(letterSpacing: 10),
                textAlign: TextAlign.center,
              ),
              Text(
                'PERMOHONAN UPDATE JABATAN',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Status',
                      style: smartRTTextLarge,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      roleReq.confirmater_id == null
                          ? 'Menunggu Konfirmasi'
                          : roleReq.accepted_at != null
                              ? "Diterima"
                              : "Ditolak",
                      style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: roleReq.confirmater_id == null
                            ? smartRTStatusYellowColor
                            : roleReq.accepted_at != null
                                ? smartRTStatusGreenColor
                                : smartRTStatusRedColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              roleReq.confirmater_id != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Tanggal Konfirmasi',
                            style: smartRTTextLarge,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat('d MMMM y', 'id_ID').format(
                                roleReq.rejected_at ?? roleReq.accepted_at!),
                            style: smartRTTextLarge,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              Text(
                'DATA PEMOHON',
                style: smartRTTextTitleCard,
              ),
              SB_height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Nama',
                      style: smartRTTextLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      roleReq.data_user_requester!.full_name,
                      style: smartRTTextLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Alamat',
                      style: smartRTTextLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      roleReq.data_user_requester!.address ?? '-',
                      style: smartRTTextLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Jabatan',
                      style: smartRTTextLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      Role.values[roleReq.request_role - 1]
                          .toString()
                          .split('.')
                          .last
                          .replaceAll('_', ' '),
                      style: smartRTTextLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              SB_height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Tanggal Dibuat',
                      style: smartRTTextLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      DateFormat('d MMMM y', 'id_ID')
                          .format(roleReq.created_at),
                      style: smartRTTextLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              roleReq.confirmater_id != null
                  ? const SizedBox()
                  : Column(
                      children: [
                        SB_height15,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: smartRTSuccessColor,
                            ),
                            onPressed: () {
                              terimaPermintaan();
                            },
                            child: Text(
                              'TERIMA',
                              style: smartRTTextLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: smartRTPrimaryColor,
                              ),
                            ),
                          ),
                        ),
                        SB_height15,
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: smartRTErrorColor,
                            ),
                            onPressed: () async {
                              tolakPermintaan();
                            },
                            child: Text(
                              'TOLAK',
                              style: smartRTTextLarge.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
