import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/administration/administration.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
import 'package:smart_rt/screens/public_screens/image_view/image_view_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AdministrationDetailPageArgument {
  Administration dataAdm;
  AdministrationDetailPageArgument({required this.dataAdm});
}

class AdministrationDetailPage extends StatefulWidget {
  static const String id = 'AdministrationDetailPage';
  AdministrationDetailPageArgument args;
  AdministrationDetailPage({Key? key, required this.args}) : super(key: key);

  @override
  State<AdministrationDetailPage> createState() =>
      _AdministrationDetailPageState();
}

class _AdministrationDetailPageState extends State<AdministrationDetailPage> {
  User user = AuthProvider.currentUser!;
  Administration? dataAdm;

  String admTypeID = '';
  String admType = '';
  String admStatus = '';
  String admCreatorFullname = '';
  String admCreatorAddress = '';
  String admCreatorKTPNum = '';
  String admCreatorKKNum = '';
  String admCreatorBornPlace = '';
  String admCreatorBornDate = '';
  String admCreatorGender = '';
  String admCreatorReligion = '';
  String admCreatorWeddingStatus = '';
  String admCreatorJob = '';
  String admRejectedReason = '';
  String admCreatorNationality = '';
  String admCreatorBornTime = '';
  String admCreatorNotes = '';

  String creatorDadAddress = '';
  String creatorDadBornDate = '';
  String creatorDadBornPlace = '';
  String creatorDadFullname = '';
  String creatorDadJob = '';
  String creatorDadKTPNum = '';
  String creatorMomAddress = '';
  String creatorMomBornDate = '';
  String creatorMomBornPlace = '';
  String creatorMomFullname = '';
  String creatorMomJob = '';
  String creatorMomKTPNum = '';

  Widget actionWidget = const SizedBox();
  Widget dataPemohonWidget = const SizedBox();

  void update(int dataAdmID, int confirmationStatus, String? data) async {
    var formData = {};
    if (confirmationStatus == -1) {
      formData = {
        "administration_id": dataAdmID,
        "confirmation_status": confirmationStatus,
        "confirmation_rejected_reason": data,
      };
    } else {
      formData = {
        "administration_id": dataAdmID,
        "confirmation_status": confirmationStatus,
        "data_letter_num": data,
      };
    }

    Response<dynamic> resp = await NetUtil().dioClient.patch(
        '/administration/update/permohonan-surat-pengantar',
        data: formData);
    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, AdministrationPage.id);

      Response<dynamic> respData =
          await NetUtil().dioClient.get('/id/${dataAdm!.id}');
      Administration dataAdmNew = Administration.fromData(respData.data);
      AdministrationDetailPageArgument args =
          AdministrationDetailPageArgument(dataAdm: dataAdmNew);

      Navigator.pushNamed(context, AdministrationDetailPage.id,
          arguments: args);

      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  void terimaPermintaan() async {
    final _letterNumController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menerima $admType yang diajukan oleh $admCreatorFullname?\n\nJika anda menerimanya, maka pemohon dapat melihat serta mengunduh Surat Pengantar dengan tanda tangan anda !',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _letterNumController,
              autocorrect: false,
              style: smartRTTextNormal_Primary,
              decoration: const InputDecoration(
                labelText: 'Nomor Surat',
              ),
            ),
          ),
          SB_height30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text(
                  'Tidak',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold, color: smartRTErrorColor2),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_letterNumController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Nomor Surat tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    update(dataAdm!.id, 1, _letterNumController.text);
                  }
                },
                child: Text(
                  'SAYA YAKIN',
                  style: smartRTTextNormal.copyWith(
                    fontWeight: FontWeight.bold,
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
          'Anda wajib mengisikan alasan penolakan $admType yang diajukan oleh $admCreatorFullname jika anda yakin untuk menolak permohonan tersebut !',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _alasanController,
              maxLines: 5,
              autocorrect: false,
              style: smartRTTextNormal_Primary,
              decoration: const InputDecoration(
                labelText: 'Alasan',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Tidak boleh kosong';
                }
              },
            ),
          ),
          SB_height30,
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
                  if (_alasanController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Alasan tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    update(dataAdm!.id, -1, _alasanController.text);
                  }
                },
                child: Text(
                  'Tolak Permintaan',
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

  String getTextKeperluan(int admTypeID) {
    if (admTypeID == 1) {
      return 'Membenarkan bahwa orang tersebut merupakan warga RT${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/RW${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name} dan berkelakuan baik di masyarakat. Surat keterangan ini dibuat sebagai kelengkapan pengurusan SKCK (Surat Keterangan Catatan Kepolisian).';
    } else if (admTypeID == 2) {
      return 'Membenarkan bahwa orang tersebut merupakan warga RT${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/RW${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name} dan berkelakuan baik di masyarakat. Surat keterangan ini dibuat sebagai kelengkapan pengurusan KK (Kartu Keluarga).';
    } else if (admTypeID == 3) {
      return 'Membenarkan bahwa orang tersebut merupakan warga RT${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/RW${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name} dan berkelakuan baik di masyarakat. Surat keterangan ini dibuat sebagai kelengkapan pengurusan KTP (Kartu Tanda Penduduk).';
    } else if (admTypeID == 4) {
      return 'Membenarkan bahwa orang tersebut merupakan warga RT${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/RW${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name} dan berkelakuan baik di masyarakat. Surat keterangan ini dibuat sebagai kelengkapan pengurusan Pindah Domisili.';
    } else if (admTypeID == 7) {
      return 'Membenarkan bahwa orang tersebut merupakan warga RT${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/RW${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name} dan berkelakuan baik di masyarakat. Surat keterangan ini dibuat sebagai pernyataan bahwa orang tersebut tidak mampu.';
    } else if (admTypeID == 8) {
      return dataAdm!.creator_notes!;
    }
    return '';
  }

  void exportPDF() async {
    String txtKeperluan = getTextKeperluan(dataAdm!.administration_type!.id);

    var netImage;
    if (dataAdm!.confirmater_sign_img != null) {
      netImage = await networkImage(
          '${backendURL}/public/uploads/administrasi/file_lampiran/${dataAdm!.id}/${dataAdm!.confirmater_sign_img}');
    }
    final pdf = pw.Document();
    if (admTypeID == '5') {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text(
                  'RT ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())} / RW ${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())}'
                      .toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 25,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name}'
                      .toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'KOTA SURABAYA'.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
                pw.Text(
                  'SURAT PENGANTAR'.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text(
                  'Nomor : ${dataAdm!.data_letter_num != null ? dataAdm!.data_letter_num!.toUpperCase() : '______________________'}',
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Text(
                  'Kami yang bertanda tangan dibawah ini, Pengurus Rukun Tetangga ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name}, Surabaya, menerangkan bahwa :',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Nama',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_fullname!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Kewarganegaraan',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_nationality!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Tempat / Tanggal Lahir',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        "${dataAdm!.creator_bornplace!}, ${DateFormat('d MMMM y', 'id_ID').format(dataAdm!.creator_borndate!)}",
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Jenis Kelamin',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_gender!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Agama',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_religion!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'NIK',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_ktp_num!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Alamat',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_address!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text(
                  'Orang tersebut diatas, telah meninggal dunia pada :',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Hari, Tanggal',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        DateFormat('EEEE, d MMMM y', 'id_ID')
                            .format(dataAdm!.creator_additional_datetime!),
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Jam',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        DateFormat('HH:mm', 'id_ID')
                            .format(dataAdm!.creator_additional_datetime!),
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Pada Usia',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        '${dataAdm!.creator_age!} tahun',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Dikarenakan',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_notes!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text(
                  'Demikian surat keterangan ini kami buat, untuk dipergunakan sebagai mana mestinya.',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 25),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.SizedBox(),
                  ),
                  pw.Expanded(
                    child: pw.SizedBox(),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Surabaya, ${DateFormat('d MMMM y', 'id_ID').format(DateTime.now())}',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ]),
                pw.SizedBox(height: 25),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        children: [],
                      ),
                    ),
                    pw.Expanded(
                      child: pw.SizedBox(),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Ketua RT. ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num!)}',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}'
                                .toUpperCase(),
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Ketua,',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          dataAdm!.confirmater_sign_img != null
                              ? pw.SizedBox(
                                  height: 75, child: pw.Image(netImage))
                              : pw.SizedBox(height: 75),
                          pw.Text(
                            '( ${dataAdm!.confirmater_fullname ?? '                                     '} )',
                            style: const pw.TextStyle(
                                fontSize: 12,
                                decoration: pw.TextDecoration.underline),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    } else if (admTypeID == '6') {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text(
                  'RT ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())} / RW ${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())}'
                      .toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 25,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name}'
                      .toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'KOTA SURABAYA'.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
                pw.Text(
                  'SURAT PENGANTAR'.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Text(
                  'Nomor : ${dataAdm!.data_letter_num != null ? dataAdm!.data_letter_num!.toUpperCase() : '______________________'}',
                  style: const pw.TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Text(
                  'Kami yang bertanda tangan dibawah ini, Pengurus Rukun Tetangga ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name}, Surabaya, menerangkan bahwa :',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Nama',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_fullname!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Tempat Lahir',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        'Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name}, Kota Surabaya',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Tanggal dan Waktu Lahir',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        "${DateFormat('d MMMM y HH:mm', 'id_ID').format(dataAdm!.creator_borndate!)}",
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Jenis Kelamin',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_gender!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Anak Ke-',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_anak_ke!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Text(
                  'Pihak yang diterangkan diatas adalah benar anak kandung dari :',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Nama Ayah Kandung',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_dad_name!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'NIK',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_dad_ktp_num!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Tempat / Tanggal Lahir',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        "${dataAdm!.creator_dad_bornplace!}, ${DateFormat('d MMMM y', 'id_ID').format(dataAdm!.creator_dad_borndate!)}",
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Alamat',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_dad_address!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Nama Ibu Kandung',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_mom_name!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'NIK',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_mom_ktp_num!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Tempat / Tanggal Lahir',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        "${dataAdm!.creator_mom_bornplace!}, ${DateFormat('d MMMM y', 'id_ID').format(dataAdm!.creator_mom_borndate!)}",
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Alamat',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_mom_address!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text(
                  'Pihak-pihak diatas benar-benar adalah penduduk Rukun Tetangga ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name}, Surabaya yang belum memiliki Akta Kelahiran.\nDemikian surat keterangan ini kami buat dengan benar dan diberikan kepada yang bersangkutan untuk proses lebih lanjut dalam pembuatan akta kelahiran yang bersangkutan.',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 25),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.SizedBox(),
                  ),
                  pw.Expanded(
                    child: pw.SizedBox(),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Surabaya, ${DateFormat('d MMMM y', 'id_ID').format(DateTime.now())}',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ]),
                // pw.SizedBox(height: 15),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        children: [],
                      ),
                    ),
                    pw.Expanded(
                      child: pw.SizedBox(),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Ketua RT. ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num!)}',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}'
                                .toUpperCase(),
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Ketua,',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          dataAdm!.confirmater_sign_img != null
                              ? pw.SizedBox(
                                  height: 75, child: pw.Image(netImage))
                              : pw.SizedBox(height: 75),
                          pw.Text(
                            '( ${dataAdm!.confirmater_fullname ?? '                                     '} )',
                            style: const pw.TextStyle(
                                fontSize: 12,
                                decoration: pw.TextDecoration.underline),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    } else {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text(
                  'RT ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())} / RW ${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())}'
                      .toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 25,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name}'
                      .toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Text(
                  'KOTA SURABAYA'.toUpperCase(),
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
                pw.Text(
                  'SURAT PENGANTAR'.toUpperCase(),
                  style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                      decoration: pw.TextDecoration.underline),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text(
                  'Nomor : ${dataAdm!.data_letter_num != null ? dataAdm!.data_letter_num!.toUpperCase() : '______________________'}',
                  style: pw.TextStyle(
                    fontSize: 15,
                    decoration: dataAdm!.data_letter_num != null
                        ? pw.TextDecoration.none
                        : pw.TextDecoration.underline,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
                pw.SizedBox(
                  height: 25,
                ),
                pw.Text(
                  'Kami yang bertanda tangan dibawah ini, Pengurus Rukun Tetangga ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num.toString())}/${StringFormat.numFormatRTRW(dataAdm!.data_rw_num.toString())} Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}, Kec. ${dataAdm!.data_kecamatan_name}, Surabaya, menerangkan bahwa :',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Nama',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_fullname!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Kewarganegaraan',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_nationality!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Tempat / Tanggal Lahir',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        "${dataAdm!.creator_bornplace!}, ${DateFormat('d MMMM y', 'id_ID').format(dataAdm!.creator_borndate!)}",
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Jenis Kelamin',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_gender!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Agama',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_religion!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Pekerjaan',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_job!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Nomor KTP',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_ktp_num!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Alamat',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        dataAdm!.creator_address!,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.Row(
                  children: [
                    pw.Expanded(
                      flex: 3,
                      child: pw.Text(
                        'Maksud / Keperluan',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Text(
                        ':',
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    pw.Expanded(
                      flex: 8,
                      child: pw.Text(
                        txtKeperluan,
                        style: const pw.TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(
                  height: 15,
                ),
                pw.Text(
                  'Demikian surat keterangan ini kami buat, untuk dipergunakan sebagai mana mestinya.',
                  style: const pw.TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: pw.TextAlign.justify,
                ),
                pw.SizedBox(height: 25),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.SizedBox(),
                  ),
                  pw.Expanded(
                    child: pw.SizedBox(),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      'Surabaya, ${DateFormat('d MMMM y', 'id_ID').format(DateTime.now())}',
                      style: const pw.TextStyle(
                        fontSize: 12,
                      ),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ]),
                pw.SizedBox(height: 25),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Ketua RW. ${StringFormat.numFormatRTRW(dataAdm!.data_rw_num!)}',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}'
                                .toUpperCase(),
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Ketua,',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.SizedBox(height: 75),
                          pw.Text(
                            '(                                       ),',
                            style: const pw.TextStyle(
                                fontSize: 12,
                                decoration: pw.TextDecoration.underline),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Expanded(
                      child: pw.SizedBox(),
                    ),
                    pw.Expanded(
                      child: pw.Column(
                        children: [
                          pw.Text(
                            'Ketua RT. ${StringFormat.numFormatRTRW(dataAdm!.data_rt_num!)}',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Kel. ${dataAdm!.data_kelurahan_name!.substring(10)}'
                                .toUpperCase(),
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            'Ketua,',
                            style: const pw.TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          dataAdm!.confirmater_sign_img != null
                              ? pw.SizedBox(
                                  height: 75, child: pw.Image(netImage))
                              : pw.SizedBox(height: 75),
                          pw.Text(
                            '( ${dataAdm!.confirmater_fullname ?? '                                     '} )',
                            style: const pw.TextStyle(
                                fontSize: 12,
                                decoration: pw.TextDecoration.underline),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  void getData() async {
    dataAdm = widget.args.dataAdm;
    admTypeID = dataAdm!.administration_type!.id.toString();
    admStatus = dataAdm!.confirmation_status == -1
        ? 'Ditolak'
        : dataAdm!.confirmation_status == 0
            ? 'Menunggu Konfirmasi'
            : 'Diterima';
    admType = 'Permohonan ${dataAdm!.administration_type!.name}';

    if (admTypeID == '6') {
      creatorDadAddress = dataAdm!.creator_dad_address!;
      creatorDadBornDate = DateFormat('d MMMM y', 'id_ID')
          .format(dataAdm!.creator_dad_borndate!);
      creatorDadBornPlace = dataAdm!.creator_dad_bornplace!;
      creatorDadFullname = dataAdm!.creator_dad_name!;
      creatorDadJob = dataAdm!.creator_dad_job!;
      creatorDadKTPNum = dataAdm!.creator_dad_ktp_num!;

      creatorMomAddress = dataAdm!.creator_mom_address!;
      creatorMomBornDate = DateFormat('d MMMM y', 'id_ID')
          .format(dataAdm!.creator_mom_borndate!);
      creatorMomBornPlace = dataAdm!.creator_mom_bornplace!;
      creatorMomFullname = dataAdm!.creator_mom_name!;
      creatorMomJob = dataAdm!.creator_mom_job!;
      creatorMomKTPNum = dataAdm!.creator_mom_ktp_num!;
    }

    if (admTypeID == '8') {
      admCreatorNotes = dataAdm!.creator_notes ?? '';
    }

    admCreatorFullname = dataAdm!.creator_fullname ?? '-';
    admCreatorAddress = dataAdm!.creator_address ?? '-';
    admCreatorKTPNum = dataAdm!.creator_ktp_num ?? '-';
    admCreatorKKNum = dataAdm!.creator_kk_num ?? '-';
    admCreatorBornPlace = dataAdm!.creator_bornplace ?? '-';
    admCreatorBornDate =
        DateFormat('d MMMM y', 'id_ID').format(dataAdm!.creator_borndate!);
    admCreatorBornTime =
        DateFormat('HH:mm', 'id_ID').format(dataAdm!.creator_borndate!);

    admCreatorGender = dataAdm!.creator_gender!;
    admCreatorReligion = dataAdm!.creator_religion ?? '-';
    admCreatorWeddingStatus = dataAdm!.creator_wedding_status ?? '-';
    admCreatorJob = dataAdm!.creator_job ?? '-';
    admRejectedReason = dataAdm!.confirmation_rejected_reason ?? '';
    admCreatorNationality = dataAdm!.creator_nationality ?? '-';

    if (admTypeID == '5') {
      dataPemohonWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DATA PEMOHON',
            style: smartRTTextTitleCard,
          ),
          SB_height15,
          ListTileData1(
            txtLeft: 'Nama',
            txtRight: dataAdm!.data_creator!.full_name,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Alamat',
            txtRight: dataAdm!.data_creator!.address ?? '',
          ),
          const Divider(
            height: 50,
            thickness: 2,
          ),
          Text(
            'DATA ORANG YANG MENINGGAL',
            style: smartRTTextTitleCard,
          ),
          SB_height15,
          ListTileData1(
            txtLeft: 'Nama',
            txtRight: admCreatorFullname,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Kewarganegaraan',
            txtRight: admCreatorNationality,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Alamat',
            txtRight: admCreatorAddress,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Nomor KTP',
            txtRight: admCreatorKTPNum,
          ),
          SB_height5,
          if (admCreatorKTPNum != '-')
            ListTileData1(
              txtLeft: '',
              txtRight: 'Lihat KTP',
              txtStyleRight: smartRTTextLarge.copyWith(
                color: smartRTActiveColor2,
              ),
              onTap: () {
                ImageViewPageArgument args = ImageViewPageArgument(
                    imgLocation:
                        '${backendURL}/public/uploads/administrasi/file_lampiran/${dataAdm!.id}/${dataAdm!.creator_ktp_img}');
                Navigator.pushNamed(context, ImageViewPage.id, arguments: args);
              },
            ),
          if (admCreatorKTPNum != '-') SB_height5,
          ListTileData1(
            txtLeft: 'Nomor KK',
            txtRight: admCreatorKKNum,
          ),
          SB_height5,
          if (admCreatorKKNum != '-')
            ListTileData1(
              txtLeft: '',
              txtRight: 'Lihat KK',
              txtStyleRight: smartRTTextLarge.copyWith(
                color: smartRTActiveColor2,
              ),
              onTap: () {
                ImageViewPageArgument args = ImageViewPageArgument(
                    imgLocation:
                        '${backendURL}/public/uploads/administrasi/file_lampiran/${dataAdm!.id}/${dataAdm!.creator_kk_img}');
                Navigator.pushNamed(context, ImageViewPage.id, arguments: args);
              },
            ),
          if (admCreatorKKNum != '-') SB_height5,
          ListTileData1(
            txtLeft: 'Tempat Lahir',
            txtRight: admCreatorBornPlace,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Tanggal Lahir',
            txtRight: admCreatorBornDate,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Gender',
            txtRight: admCreatorGender,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Agama',
            txtRight: admCreatorReligion,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Status Perkawinan',
            txtRight: admCreatorWeddingStatus,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Pekerjaan',
            txtRight: admCreatorJob,
          ),
        ],
      );
    } else if (admTypeID == '6') {
      dataPemohonWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DATA PEMOHON',
            style: smartRTTextTitleCard,
          ),
          SB_height15,
          ListTileData1(
            txtLeft: 'Nama',
            txtRight: dataAdm!.data_creator!.full_name,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Alamat',
            txtRight: dataAdm!.data_creator!.address ?? '',
          ),
          const Divider(
            height: 50,
            thickness: 2,
          ),
          Text(
            'DATA ANAK',
            style: smartRTTextTitleCard,
          ),
          SB_height15,
          ListTileData1(
            txtLeft: 'Nama',
            txtRight: admCreatorFullname,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Tempat Lahir',
            txtRight: admCreatorBornPlace,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Tanggal Lahir',
            txtRight: admCreatorBornDate,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Waktu Lahir',
            txtRight: admCreatorBornTime,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Gender',
            txtRight: admCreatorGender,
          ),
          const Divider(
            height: 50,
            thickness: 2,
          ),
          Text(
            'DATA AYAH',
            style: smartRTTextTitleCard,
          ),
          SB_height15,
          ListTileData1(
            txtLeft: 'Nama',
            txtRight: creatorDadFullname,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Alamat',
            txtRight: creatorDadAddress,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Nomor KTP',
            txtRight: creatorDadKTPNum,
          ),
          SB_height5,
          if (creatorDadKTPNum != '-')
            ListTileData1(
              txtLeft: '',
              txtRight: 'Lihat KTP',
              txtStyleRight: smartRTTextLarge.copyWith(
                color: smartRTActiveColor2,
              ),
              onTap: () {
                ImageViewPageArgument args = ImageViewPageArgument(
                    imgLocation:
                        '${backendURL}/public/uploads/administrasi/file_lampiran/${dataAdm!.id}/${dataAdm!.creator_dad_ktp_img}');
                Navigator.pushNamed(context, ImageViewPage.id, arguments: args);
              },
            ),
          if (creatorDadKTPNum != '-') SB_height5,
          ListTileData1(
            txtLeft: 'Tempat Lahir',
            txtRight: creatorDadBornPlace,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Tanggal Lahir',
            txtRight: creatorDadBornPlace,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Pekerjaan',
            txtRight: creatorDadJob,
          ),
          const Divider(
            height: 50,
            thickness: 2,
          ),
          Text(
            'DATA IBU',
            style: smartRTTextTitleCard,
          ),
          SB_height15,
          ListTileData1(
            txtLeft: 'Nama',
            txtRight: creatorMomFullname,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Alamat',
            txtRight: creatorMomAddress,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Nomor KTP',
            txtRight: creatorMomKTPNum,
          ),
          SB_height5,
          if (creatorMomKTPNum != '-')
            ListTileData1(
              txtLeft: '',
              txtRight: 'Lihat KTP',
              txtStyleRight: smartRTTextLarge.copyWith(
                color: smartRTActiveColor2,
              ),
              onTap: () {
                ImageViewPageArgument args = ImageViewPageArgument(
                    imgLocation:
                        '${backendURL}/public/uploads/administrasi/file_lampiran/${dataAdm!.id}/${dataAdm!.creator_mom_ktp_img}');
                Navigator.pushNamed(context, ImageViewPage.id, arguments: args);
              },
            ),
          if (creatorMomKTPNum != '-') SB_height5,
          ListTileData1(
            txtLeft: 'Tempat Lahir',
            txtRight: creatorMomBornPlace,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Tanggal Lahir',
            txtRight: creatorMomBornPlace,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Pekerjaan',
            txtRight: creatorMomJob,
          ),
        ],
      );
    } else {
      dataPemohonWidget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DATA PEMOHON',
            style: smartRTTextTitleCard,
          ),
          SB_height15,
          ListTileData1(
            txtLeft: 'Nama',
            txtRight: admCreatorFullname,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Kewarganegaraan',
            txtRight: admCreatorNationality,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Alamat',
            txtRight: admCreatorAddress,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Nomor KTP',
            txtRight: admCreatorKTPNum,
          ),
          SB_height5,
          if (admCreatorKTPNum != '-')
            ListTileData1(
              txtLeft: '',
              txtRight: 'Lihat KTP',
              txtStyleRight: smartRTTextLarge.copyWith(
                color: smartRTActiveColor2,
              ),
              onTap: () {
                ImageViewPageArgument args = ImageViewPageArgument(
                    imgLocation:
                        '${backendURL}/public/uploads/administrasi/file_lampiran/${dataAdm!.id}/${dataAdm!.creator_ktp_img}');
                Navigator.pushNamed(context, ImageViewPage.id, arguments: args);
              },
            ),
          if (admCreatorKTPNum != '-') SB_height5,
          ListTileData1(
            txtLeft: 'Nomor KK',
            txtRight: admCreatorKKNum,
          ),
          SB_height5,
          if (admCreatorKKNum != '-')
            ListTileData1(
              txtLeft: '',
              txtRight: 'Lihat KK',
              txtStyleRight: smartRTTextLarge.copyWith(
                color: smartRTActiveColor2,
              ),
              onTap: () {
                ImageViewPageArgument args = ImageViewPageArgument(
                    imgLocation:
                        '${backendURL}/public/uploads/administrasi/file_lampiran/${dataAdm!.id}/${dataAdm!.creator_kk_img}');
                Navigator.pushNamed(context, ImageViewPage.id, arguments: args);
              },
            ),
          if (admCreatorKKNum != '-') SB_height5,
          ListTileData1(
            txtLeft: 'Tempat Lahir',
            txtRight: admCreatorBornPlace,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Tanggal Lahir',
            txtRight: admCreatorBornDate,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Gender',
            txtRight: admCreatorGender,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Agama',
            txtRight: admCreatorReligion,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Status Perkawinan',
            txtRight: admCreatorWeddingStatus,
          ),
          SB_height5,
          ListTileData1(
            txtLeft: 'Pekerjaan',
            txtRight: admCreatorJob,
          ),
          if (admTypeID == '8') SB_height5,
          if (admTypeID == '8')
            ListTileData1(
              txtLeft: 'Keperluan',
              txtRight: admCreatorNotes,
            ),
        ],
      );
    }

    // if (admStatus != 'Menunggu Konfirmasi') {
    actionWidget = Row(
      children: [
        GestureDetector(
          onTap: () {
            exportPDF();
          },
          child: const Icon(Icons.picture_as_pdf),
        ),
        SB_width15,
      ],
    );
    // }
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
      appBar: AppBar(
        actions: [actionWidget],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'DETAIL ADMINISTRASI',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTileData1(
                    txtLeft: 'Administrasi',
                    txtRight: admType,
                  ),
                  SB_height5,
                  ListTileData1(
                    txtLeft: 'Status',
                    txtRight: admStatus,
                  ),
                  const Divider(
                    height: 50,
                    thickness: 2,
                  ),
                  dataPemohonWidget,
                  const Divider(
                    height: 50,
                    thickness: 2,
                  ),
                  admStatus == 'Ditolak'
                      ? ListTileData1(
                          txtLeft: 'Alasan Ditolak',
                          txtRight: admRejectedReason,
                        )
                      : const SizedBox(),
                  admStatus == 'Menunggu Konfirmasi' &&
                          user.user_role == Role.Ketua_RT
                      ? Column(
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
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
