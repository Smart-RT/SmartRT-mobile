import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user_role_request.dart';
import 'package:smart_rt/providers/role_request_provider.dart';
import 'package:smart_rt/screens/public_screens/image_view/image_view_page.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:smart_rt/screens/pdf_screen/pdf_screen.dart';

class DetailRequestRolePageArguments {
  int index;
  DetailRequestRolePageArguments({required this.index});
}

class DetailRequestRolePage extends StatefulWidget {
  static const String id = 'DetailRequestRolePage';
  DetailRequestRolePageArguments args;
  DetailRequestRolePage({Key? key, required this.args}) : super(key: key);

  @override
  State<DetailRequestRolePage> createState() => _DetailRequestRolePageState();
}

class _DetailRequestRolePageState extends State<DetailRequestRolePage> {
  String status = '';
  Color statusColor = smartRTStatusYellowColor;
  String namaPemohon = '';
  String jkPemohon = '';
  String umurPemohon = '';
  String alamatPemohon = '';
  String kelahiranPemohon = '';
  String rtrw = '';
  String kecamatan = '';
  String kelurahan = '';
  String createdAt = '';
  String confirmationAt = '';
  bool isConfirmated = true;

  void getData({required UserRoleRequest dataKonfirmasi}) async {
    if (dataKonfirmasi.confirmater_id == null) {
      isConfirmated = false;
      status = 'Menunggu Konfirmasi';
      statusColor = smartRTStatusYellowColor;
    } else if (dataKonfirmasi.accepted_at != null) {
      status = 'Diterima';
      statusColor = smartRTStatusGreenColor;
    } else {
      status = 'Ditolak';
      statusColor = smartRTStatusRedColor;
    }

    namaPemohon = dataKonfirmasi.data_user_requester!.full_name;
    jkPemohon = dataKonfirmasi.data_user_requester!.gender;
    umurPemohon = StringFormat.ageNow(
        bornDate: dataKonfirmasi.data_user_requester!.born_date!);
    kelahiranPemohon = StringFormat.formatDate(
        dateTime: dataKonfirmasi.data_user_requester!.born_date!,
        isWithTime: false);
    alamatPemohon = dataKonfirmasi.data_user_requester!.address ?? '-';
    rtrw = StringFormat.formatRTRW(
        rtNum: dataKonfirmasi.rt_num.toString(),
        rwNum: dataKonfirmasi.rw_num.toString());
    kecamatan = StringFormat.kecamatanFormat(
        kecamatan: dataKonfirmasi.sub_district_id!.name);
    kelurahan = StringFormat.kelurahanFormat(
        kelurahan: dataKonfirmasi.urban_village_id!.name);
    createdAt =
        DateFormat('d MMMM y', 'id_ID').format(dataKonfirmasi.created_at);
    if (isConfirmated) {
      confirmationAt = DateFormat('d MMMM y HH:mm', 'id_ID')
          .format(dataKonfirmasi.rejected_at ?? dataKonfirmasi.accepted_at!);
    }

    setState(() {});
  }

  void terimaPermintaan({required UserRoleRequest dataKonfirmasi}) async {
    final _tenureEndAtDate = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Admin Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menerimanya menjadi Ketua RT dan mendaftarkan wilayah baru?\n\nMohon pastikan terlebih dahulu bahwa ia benar menjabat didaerah tersebut!',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          DateTimePicker(
            type: DateTimePickerType.date,
            dateMask: 'yyyy/MM/dd',
            locale: const Locale('id', 'ID'),
            style: smartRTTextNormal_Primary,
            firstDate: DateTime.now().add(Duration(days: 3)),
            initialDate: DateTime.now().add(Duration(days: 3)),
            lastDate: DateTime.now().add(Duration(days: 1825)),
            dateLabelText: 'Tanggal Masa Jabatan Berakhir',
            onSaved: (val) => print(val),
            controller: _tenureEndAtDate,
          ),
          SB_height15,
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
                onPressed: () async {
                  if (_tenureEndAtDate.text != '') {
                    bool isSukses = await context
                        .read<RoleRequestProvider>()
                        .confirmationUserRoleReqKetua(
                            index: widget.args.index,
                            isAccepted: true,
                            tenureEndAt: _tenureEndAtDate.text);

                    if (isSukses) {
                      Navigator.pop(context);
                      await context
                          .read<RoleRequestProvider>()
                          .getUserRoleReqKetuaData();
                      setState(() {});
                    }
                  } else {
                    SmartRTSnackbar.show(context,
                        message:
                            'Anda wajib mengisikan tanggal berakhir jabatan!',
                        backgroundColor: smartRTErrorColor);
                  }
                },
                child: Text(
                  'TERIMA PERMOHONAN',
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

  void tolakPermintaan({required UserRoleRequest dataKonfirmasi}) async {
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
                onPressed: () {},
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

  @override
  Widget build(BuildContext context) {
    int index = widget.args.index;
    UserRoleRequest dataKonfirmasi =
        context.watch<RoleRequestProvider>().listUserRoleReqKetuaRT[index];
    getData(dataKonfirmasi: dataKonfirmasi);

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
                'PERMOHONAN MENJADI KETUA RT',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              ListTileData1(txtLeft: 'Status', txtRight: status),
              ListTileData1(txtLeft: 'Tanggal Dibuat', txtRight: createdAt),
              if (isConfirmated)
                ListTileData1(
                    txtLeft: 'Tanggal Konfirmasi', txtRight: confirmationAt),
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
              ListTileData1(txtLeft: 'Nama', txtRight: namaPemohon),
              ListTileData1(txtLeft: 'Jenis Kelamin', txtRight: jkPemohon),
              ListTileData1(
                  txtLeft: 'Tanggal Lahir', txtRight: kelahiranPemohon),
              ListTileData1(txtLeft: 'Umur', txtRight: umurPemohon),
              SB_height15,
              ListTileData1(txtLeft: 'Alamat', txtRight: alamatPemohon),
              ListTileData1(
                txtLeft: 'Kecamatan',
                txtRight: kecamatan,
              ),
              ListTileData1(
                txtLeft: 'Kelurahan',
                txtRight: kelurahan,
              ),
              ListTileData1(
                txtLeft: 'RT / RW',
                txtRight: rtrw,
              ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              Text(
                'LAMPIRAN',
                style: smartRTTextTitleCard,
              ),
              SB_height15,
              ListTileData1(
                txtLeft: 'Foto KTP',
                txtRight: 'Lihat Foto KTP >',
                txtStyleRight:
                    smartRTTextLarge.copyWith(color: smartRTActiveColor2),
                onTap: () {
                  ImageViewPageArgument args = ImageViewPageArgument(
                      imgLocation:
                          '$backendURL/public/uploads/file_lampiran/${dataKonfirmasi.id}/${dataKonfirmasi.ktp_img}');
                  Navigator.pushNamed(context, ImageViewPage.id,
                      arguments: args);
                },
              ),
              ListTileData1(
                txtLeft: 'Selfie KTP',
                txtRight: 'Lihat Selfie KTP >',
                txtStyleRight:
                    smartRTTextLarge.copyWith(color: smartRTActiveColor2),
                onTap: () {
                  ImageViewPageArgument args = ImageViewPageArgument(
                      imgLocation:
                          '$backendURL/public/uploads/file_lampiran/${dataKonfirmasi.id}/${dataKonfirmasi.selfie_ktp_img}');
                  Navigator.pushNamed(context, ImageViewPage.id,
                      arguments: args);
                },
              ),
              ListTileData1(
                txtLeft: 'Bukti / Surat Jabatan',
                txtRight: 'Lihat Bukti >',
                txtStyleRight:
                    smartRTTextLarge.copyWith(color: smartRTActiveColor2),
                onTap: () async {
                  String url =
                      '$backendURL/public/uploads/file_lampiran/${dataKonfirmasi.id}/${dataKonfirmasi.file_lampiran}';
                  String namaFile = dataKonfirmasi.file_lampiran!;

                  // Download dari server
                  Dio client = Dio();
                  Response response = await client.get(url,
                      options: Options(responseType: ResponseType.bytes));

                  // Buat file temporary
                  final tempOutputFile = await getTemporaryDirectory();
                  final file = File("${tempOutputFile.path}/$namaFile");
                  file.writeAsBytes(response.data);

                  String lampiranPath = file.path;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFScreen(path: lampiranPath),
                    ),
                  );
                },
              ),
              Divider(
                color: smartRTPrimaryColor,
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
                              terimaPermintaan(dataKonfirmasi: dataKonfirmasi);
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
                              tolakPermintaan(dataKonfirmasi: dataKonfirmasi);
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
