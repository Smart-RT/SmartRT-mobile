import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/disease_group.dart';
import 'package:smart_rt/models/health/health_task_help.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/konfirmasi_gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/laporan_warga_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class DetailKonfirmasiGabungWilayahArguments {
  UserRoleRequest dataKonfirmasi;
  DetailKonfirmasiGabungWilayahArguments({required this.dataKonfirmasi});
}

class DetailKonfirmasiGabungWilayahPage extends StatefulWidget {
  static const String id = 'DetailKonfirmasiGabungWilayahPage';
  DetailKonfirmasiGabungWilayahArguments args;
  DetailKonfirmasiGabungWilayahPage({Key? key, required this.args})
      : super(key: key);

  @override
  State<DetailKonfirmasiGabungWilayahPage> createState() =>
      _DetailKonfirmasiGabungWilayahPageState();
}

class _DetailKonfirmasiGabungWilayahPageState
    extends State<DetailKonfirmasiGabungWilayahPage> {
  UserRoleRequest? dataKonfirmasi;
  String status = '';
  Color statusColor = smartRTStatusYellowColor;
  String namaPemohon = '';
  String alamatPemohon = '';
  String createdAt = '';
  String confirmationAt = '';
  bool isConfirmated = true;

  void getData() async {
    dataKonfirmasi = widget.args.dataKonfirmasi;

    if (dataKonfirmasi!.confirmater_id == null) {
      isConfirmated = false;
      status = 'Menunggu Konfirmasi';
      statusColor = smartRTStatusYellowColor;
    } else if (dataKonfirmasi!.accepted_at != null) {
      status = 'Diterima';
      statusColor = smartRTStatusGreenColor;
    } else {
      status = 'Ditolak';
      statusColor = smartRTStatusRedColor;
    }

    namaPemohon = dataKonfirmasi!.data_user_requester!.full_name;
    alamatPemohon = dataKonfirmasi!.data_user_requester!.address ?? '-';
    createdAt =
        DateFormat('d MMMM y', 'id_ID').format(dataKonfirmasi!.created_at);
    if (isConfirmated) {
      confirmationAt = DateFormat('d MMMM y', 'id_ID')
          .format(dataKonfirmasi!.rejected_at ?? dataKonfirmasi!.accepted_at!);
    }

    setState(() {});
  }

  void terimaPermintaan() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menerimanya menjadi warga wilayah anda?\n\nMohon pastikan terlebih dahulu bahwa ia adalah warga wilayah anda!',
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
          'Apakah anda yakin menolak permohonan untuk menjadi warga wilayah anda?',
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
        .patch('/users/update/roleReq/warga', data: {
      "idRoleReq": dataKonfirmasi!.id,
      "typeConfirmation": typeConfirmation
    });
    if (resp.statusCode.toString() == '200') {
      if (typeConfirmation == 'terima') {
        await NetUtil().dioClient.post('/users/role/log/add', data: {
          "user_id": dataKonfirmasi!.data_user_requester!.id,
          "before_user_role_id": 2,
          "after_user_role_id": 3,
        });
      }
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, KonfirmasiGabungWilayahPage.id);

      Response<dynamic> resp = await NetUtil()
          .dioClient
          .get('/users/getRoleRequest/id/${dataKonfirmasi!.id}');

      UserRoleRequest tempdataKonfirmasi = UserRoleRequest.fromData(resp.data);
      DetailKonfirmasiGabungWilayahArguments arguments =
          DetailKonfirmasiGabungWilayahArguments(
              dataKonfirmasi: tempdataKonfirmasi);
      Navigator.pushNamed(context, DetailKonfirmasiGabungWilayahPage.id,
          arguments: arguments);
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                'PERMOHONAN GABUNG WILAYAH',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 50,
                thickness: 5,
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
                      status,
                      style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              isConfirmated
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
                            confirmationAt,
                            style: smartRTTextLarge,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const Divider(
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
                      namaPemohon,
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
                      alamatPemohon,
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
                      createdAt,
                      style: smartRTTextLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              isConfirmated
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
