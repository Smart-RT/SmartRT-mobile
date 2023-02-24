import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/health_task_help.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatanku_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class DetailRiwayatBantuanPageArguments {
  int dataBantuanID;
  DetailRiwayatBantuanPageArguments({required this.dataBantuanID});
}

class DetailRiwayatBantuanPage extends StatefulWidget {
  static const String id = 'DetailRiwayatBantuanPage';
  DetailRiwayatBantuanPageArguments args;
  DetailRiwayatBantuanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<DetailRiwayatBantuanPage> createState() =>
      _DetailRiwayatBantuanPageState();
}

class _DetailRiwayatBantuanPageState extends State<DetailRiwayatBantuanPage> {
  int? dataBantuanID;
  HealthTaskHelp? dataBantuan;

  final detailPermintaanController = TextEditingController();

  int statusID = -1;
  String statusName = '';
  Color statusColor = smartRTPrimaryColor;
  String tingkatKepentingan = '';
  String tanggalTerbuat = '';
  String waktuTerbuat = '';
  String tanggalKonfirmasi = '';
  String konfirmasiBy = '';
  String statusKonfirmasi = '';
  String catatanKonfirmasi = '';

  void getData() async {
    dataBantuanID = widget.args.dataBantuanID;

    Response<dynamic> resp =
        await NetUtil().dioClient.get('/health/healthTaskHelp/$dataBantuanID');
    dataBantuan = HealthTaskHelp.fromData(resp.data);

    statusID = dataBantuan!.status!.id;
    statusName = dataBantuan!.status!.name;
    statusColor = dataBantuan!.status!.color;
    tingkatKepentingan =
        dataBantuan!.urgent_level == 1 ? 'Normal' : 'Butuh Cepat';
    detailPermintaanController.text = dataBantuan!.notes;
    tanggalTerbuat = DateFormat('d MMMM y').format(dataBantuan!.created_at);
    waktuTerbuat = '${DateFormat('HH:mm').format(dataBantuan!.created_at)} WIB';

    setState(() {});
  }

  void batalkan() async {
    Response<dynamic> resp = await NetUtil().dioClient.patch(
        '/health/healthTaskHelp',
        data: {"status": -2, "idBantuan": dataBantuanID});
    if (resp.statusCode.toString() == '200') {
      DetailRiwayatBantuanPageArguments arguments =
          DetailRiwayatBantuanPageArguments(dataBantuanID: dataBantuanID!);
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, RiwayatBantuanPage.id);
      Navigator.pushNamed(context, DetailRiwayatBantuanPage.id,
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
                'DETAIL BANTUAN',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        statusName,
                        style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 50,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tingkat Kepentingan',
                        style: smartRTTextLarge,
                      ),
                      Text(tingkatKepentingan, style: smartRTTextLarge),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'DETAIL PERMINTAAN',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SB_height5,
                  TextFormField(
                    readOnly: true,
                    controller: detailPermintaanController,
                    autocorrect: false,
                    style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.normal),
                    maxLines: 10,
                  ),
                ],
              ),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal Terbuat',
                        style: smartRTTextLarge,
                      ),
                      Text(tanggalTerbuat, style: smartRTTextLarge),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Waktu Terbuat',
                        style: smartRTTextLarge,
                      ),
                      Text(waktuTerbuat, style: smartRTTextLarge),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       'Detail Permintaan',
              //       style: smartRTTextNormalBold_Primary,
              //     ),
              //     Text(
              //       detailPermintaan,
              //       style: smartRTTextNormal_Primary,
              //     ),
              //     SB_height30,
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Tanggal Terbuat',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           tanggalTerbuat,
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Dibuat Oleh',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           'Laa',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     SB_height15,
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Tanggal Konfirmasi',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Dikonfirmasi Oleh',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Catatan',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     SB_height15,
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Tanggal Selesai',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Diselesaikan Oleh',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     SB_height15,
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Penilaian',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Ulasan',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              statusID == 0
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          batalkan();
                        },
                        child: Text(
                          'BATALKAN',
                          style: smartRTTextLargeBold_Secondary,
                        ),
                      ),
                    )
                  : const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
