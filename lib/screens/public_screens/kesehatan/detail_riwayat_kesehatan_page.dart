import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/disease_group.dart';
import 'package:smart_rt/models/health/health_task_help.dart';
import 'package:smart_rt/models/health/user_health_report.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class DetailRiwayatKesehatanArguments {
  UserHealthReport dataReport;
  DetailRiwayatKesehatanArguments({required this.dataReport});
}

class DetailRiwayatKesehatanPage extends StatefulWidget {
  static const String id = 'DetailRiwayatKesehatanPage';
  DetailRiwayatKesehatanArguments args;
  DetailRiwayatKesehatanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<DetailRiwayatKesehatanPage> createState() =>
      _DetailRiwayatKesehatanPageState();
}

class _DetailRiwayatKesehatanPageState
    extends State<DetailRiwayatKesehatanPage> {
  UserHealthReport? dataReport;
  String status = '';
  Color statusColor = smartRTStatusGreenColor;
  String statusDibuat = '';
  String diseaseLevel = '';
  Color diseaseLevelColor = smartRTSickLevel1Color;
  String diseaseNotes = '';
  String diseaseGroup = '';
  String reportedName = '';
  String reportedAddress = '';
  String createdBy = '';
  String createdByAddress = '';
  String createdAtDate = '';
  String createdAtTime = '';
  String confirmationBy = '';
  String confirmationByAddress = '';
  String confirmationAt = '';
  String healedAtDate = '';
  String healedAtTime = '';

  String getStatus() {
    if (dataReport!.healed_at != null) {
      return 'Sudah Sembuh';
    } else {
      statusColor = smartRTStatusRedColor;
      return 'Masih Sakit';
    }
  }

  String getDiseaseLevel() {
    if (dataReport!.disease_level == 1) {
      diseaseLevelColor = smartRTSickLevel1Color;
      return 'Sakit Ringan';
    } else if (dataReport!.disease_level == 2) {
      diseaseLevelColor = smartRTSickLevel2Color;
      return 'Sakit Sedang';
    } else {
      diseaseLevelColor = smartRTSickLevel3Color;
      return 'Sakit Berat';
    }
  }

  String getStatusDibuat() {
    if (dataReport!.reported_id_for == dataReport!.created_by) {
      return 'Diri Sendiri';
    } else {
      return 'Orang Lain';
    }
  }

  void getData() async {
    dataReport = widget.args.dataReport;

    status = getStatus();
    statusDibuat = getStatusDibuat();
    diseaseLevel = getDiseaseLevel();
    diseaseGroup = dataReport!.disease_group!.name;
    diseaseNotes = dataReport!.disease_notes;

    reportedName = dataReport!.reported_data_user!.full_name;
    reportedAddress = dataReport!.reported_data_user!.address ?? '';

    createdBy = dataReport!.created_by_data_user!.full_name;
    createdByAddress = dataReport!.created_by_data_user!.address ?? '';
    createdAtDate = DateFormat('d MMMM y').format(dataReport!.created_at);
    createdAtTime = '${DateFormat('HH:mm').format(dataReport!.created_at)} WIB';

    if (dataReport!.confirmation_by != null) {
      confirmationBy = dataReport!.confirmation_by_data_user!.full_name;
      confirmationByAddress =
          dataReport!.confirmation_by_data_user!.address ?? '';
      confirmationAt =
          DateFormat('d MMMM y HH:mm').format(dataReport!.confirmation_at!);
    }

    if (dataReport!.healed_at != null) {
      healedAtDate = DateFormat('d MMMM y').format(dataReport!.healed_at!);
      healedAtTime =
          '${DateFormat('HH:mm').format(dataReport!.healed_at!)} WIB';
    }

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
              (status == 'Sudah Sembuh')
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Tanggal Sembuh',
                                style: smartRTTextLarge,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                healedAtDate,
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
                                '',
                                style: smartRTTextLarge,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                healedAtTime,
                                style: smartRTTextLarge,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Dibuat Oleh',
                      style: smartRTTextLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      statusDibuat,
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
                      'Tanggal',
                      style: smartRTTextLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      createdAtDate,
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
                      '',
                      style: smartRTTextLarge,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      createdAtTime,
                      style: smartRTTextLarge,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
              statusDibuat == 'Orang Lain'
                  ? Column(
                      children: [
                        SB_height15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Pelapor',
                                style: smartRTTextLarge,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                createdBy,
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
                                '',
                                style: smartRTTextLarge,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                createdByAddress,
                                style: smartRTTextLarge,
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Tingkat Bahaya',
                          style: smartRTTextLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          diseaseLevel,
                          style: smartRTTextLarge.copyWith(
                              color: diseaseLevelColor),
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
                          'Golongan Penyakit',
                          style: smartRTTextLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          diseaseGroup,
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
                          'Detail Penyakit',
                          style: smartRTTextLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          diseaseNotes,
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
                          'Penderita',
                          style: smartRTTextLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reportedName,
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
                          '',
                          style: smartRTTextLarge,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          reportedAddress,
                          style: smartRTTextLarge,
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 50,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
