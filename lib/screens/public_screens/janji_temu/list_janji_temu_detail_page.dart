import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/meet/meeting.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/pdf_screen/pdf_screen.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import '../../../widgets/list_tile/list_tile_data_1.dart';

class ListJanjiTemuDetailPageArgument {
  Meeting dataJanjiTemu;
  ListJanjiTemuDetailPageArgument({required this.dataJanjiTemu});
}

class ListJanjiTemuDetailPage extends StatefulWidget {
  static const String id = 'ListJanjiTemuDetailPage';
  ListJanjiTemuDetailPageArgument args;
  ListJanjiTemuDetailPage({Key? key, required this.args}) : super(key: key);

  @override
  State<ListJanjiTemuDetailPage> createState() =>
      _ListJanjiTemuDetailPageState();
}

class _ListJanjiTemuDetailPageState extends State<ListJanjiTemuDetailPage> {
  Meeting? dataJanjiTemu;
  User user = AuthProvider.currentUser!;
  String pemohonName = '';
  String pemohonTelp = '';
  String pemohonAddress = '';
  String pemohonKecamatan = '';
  String pemohonKelurahan = '';
  String pemohonRTRW = '';
  String respondenName = '';
  String respondenAddress = '';
  String respondenKecamatan = '';
  String respondenKelurahan = '';
  String respondenRTRW = '';
  String keperluanTitle = '';
  String keperluanDetail = '';
  String keperluanLampiran = '';
  String keperluanLampiranPath = '';
  String meetDate = '';
  String meetTime = '';
  String meetDateTimeBy = '';
  String titleDataPemohon = 'DATA PEMOHON';
  String titleDataResponden = 'DATA RESPONDEN';
  String status = '';
  String confirmationBy = '';
  String confirmationDate = '';
  String confirmationNotes = '';
  bool showBtnBatal = false;
  bool showBtnTolak = false;
  bool showBtnTerima = false;
  bool showBtnGantiTanggalWaktu = false;
  bool showBtnGantiResponden = false;

  void _getPDFFromServer() async {
    //  Settingan file nanti
    String url =
        '$backendURL/public/uploads/meet/file_lampiran/${dataJanjiTemu!.id}/$keperluanLampiran';
    String namaFile = keperluanLampiran;

    // Download dari server
    Dio client = Dio();
    Response response = await client.get(url,
        options: Options(responseType: ResponseType.bytes));

    // Buat file temporary
    final tempOutputFile = await getTemporaryDirectory();
    final file = File("${tempOutputFile.path}/$namaFile");
    file.writeAsBytes(response.data);

    // Set Loaded True, jadi nanti muncul.
    setState(() {
      keperluanLampiranPath = file.path;
    });
  }

  void batalkan(String alasan) async {
    try {
      Response<dynamic> respCancel = await NetUtil().dioClient.patch(
          '/meet/cancel',
          data: {"meet_id": dataJanjiTemu!.id, "confirmation_notes": alasan});
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, ListJanjiTemuPage.id);
      Response<dynamic> respDataJanjiTemu = await NetUtil()
          .dioClient
          .get('/meet/get/id-meet/${dataJanjiTemu!.id}');
      Navigator.pushNamed(context, ListJanjiTemuDetailPage.id,
          arguments: ListJanjiTemuDetailPageArgument(
              dataJanjiTemu: Meeting.fromData(respDataJanjiTemu.data)));
      SmartRTSnackbar.show(context,
          message: respCancel.data, backgroundColor: smartRTSuccessColor);
    } catch (e) {
      SmartRTSnackbar.show(context,
          message: "Gagal membatalkan! Cobalah lagi nanti!",
          backgroundColor: smartRTErrorColor);
    }
  }

  void terima() async {
    try {
      Response<dynamic> respCancel = await NetUtil()
          .dioClient
          .patch('/meet/accept', data: {"meet_id": dataJanjiTemu!.id});
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, ListJanjiTemuPage.id);
      Response<dynamic> respDataJanjiTemu = await NetUtil()
          .dioClient
          .get('/meet/get/id-meet/${dataJanjiTemu!.id}');
      Navigator.pushNamed(context, ListJanjiTemuDetailPage.id,
          arguments: ListJanjiTemuDetailPageArgument(
              dataJanjiTemu: Meeting.fromData(respDataJanjiTemu.data)));
      SmartRTSnackbar.show(context,
          message: respCancel.data, backgroundColor: smartRTSuccessColor);
    } catch (e) {
      SmartRTSnackbar.show(context,
          message: "Gagal menerima! Cobalah lagi nanti!",
          backgroundColor: smartRTErrorColor);
    }
  }

  void tolak(String alasan) async {
    try {
      Response<dynamic> respCancel = await NetUtil().dioClient.patch(
          '/meet/decline',
          data: {"meet_id": dataJanjiTemu!.id, "confirmation_notes": alasan});
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, ListJanjiTemuPage.id);
      Response<dynamic> respDataJanjiTemu = await NetUtil()
          .dioClient
          .get('/meet/get/id-meet/${dataJanjiTemu!.id}');
      Navigator.pushNamed(context, ListJanjiTemuDetailPage.id,
          arguments: ListJanjiTemuDetailPageArgument(
              dataJanjiTemu: Meeting.fromData(respDataJanjiTemu.data)));
      SmartRTSnackbar.show(context,
          message: respCancel.data, backgroundColor: smartRTSuccessColor);
    } catch (e) {
      SmartRTSnackbar.show(context,
          message: "Gagal menolak! Cobalah lagi nanti!",
          backgroundColor: smartRTErrorColor);
    }
  }

  void gantiTanggal(String newDate) async {
    try {
      Response<dynamic> respCancel = await NetUtil().dioClient.patch(
          '/meet/change-date',
          data: {"meet_id": dataJanjiTemu!.id, "new_date": newDate});
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, ListJanjiTemuPage.id);
      Response<dynamic> respDataJanjiTemu = await NetUtil()
          .dioClient
          .get('/meet/get/id-meet/${dataJanjiTemu!.id}');
      Navigator.pushNamed(context, ListJanjiTemuDetailPage.id,
          arguments: ListJanjiTemuDetailPageArgument(
              dataJanjiTemu: Meeting.fromData(respDataJanjiTemu.data)));
      SmartRTSnackbar.show(context,
          message: respCancel.data, backgroundColor: smartRTSuccessColor);
    } catch (e) {
      SmartRTSnackbar.show(context,
          message: "Gagal mengajukan pergantian! Cobalah lagi nanti!",
          backgroundColor: smartRTErrorColor);
    }
  }

  void gantiResponden(String idRespondenBaru) async {
    try {
      Response<dynamic> respCancel = await NetUtil()
          .dioClient
          .patch('/meet/change-respondent', data: {
        "meet_id": dataJanjiTemu!.id,
        "new_respondent_id": idRespondenBaru
      });
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, ListJanjiTemuPage.id);
      Response<dynamic> respDataJanjiTemu = await NetUtil()
          .dioClient
          .get('/meet/get/id-meet/${dataJanjiTemu!.id}');
      Navigator.pushNamed(context, ListJanjiTemuDetailPage.id,
          arguments: ListJanjiTemuDetailPageArgument(
              dataJanjiTemu: Meeting.fromData(respDataJanjiTemu.data)));
      SmartRTSnackbar.show(context,
          message: respCancel.data, backgroundColor: smartRTSuccessColor);
    } catch (e) {
      SmartRTSnackbar.show(context,
          message: "Gagal mengajukan pergantian! Cobalah lagi nanti!",
          backgroundColor: smartRTErrorColor);
    }
  }

  void konfirmasiBatalkan() {
    final _alasanController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin membatalkan${dataJanjiTemu!.status == 0 ? ' permohonan ' : ' '}janji temu?',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          if (dataJanjiTemu!.status == 1)
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
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text(
                  'Tidak',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (dataJanjiTemu!.status == 1 &&
                      _alasanController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Alasan tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    batalkan(_alasanController.text);
                  }
                },
                child: Text(
                  'IYA, BATALKAN!',
                  style: smartRTTextNormal.copyWith(
                    fontWeight: FontWeight.bold,
                    color: smartRTStatusRedColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void konfirmasiTerima() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menerima permohonan janji temu?',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text(
                  'Tidak',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  terima();
                },
                child: Text(
                  'IYA, TERIMA!',
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

  void konfirmasiTolak() {
    final _alasanController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menolak${dataJanjiTemu!.meet_datetime_negotiated_by!.id != dataJanjiTemu!.created_by!.id ? ' pengajuan pergantian tanggal dan waktu ' : ' '}janji temu?',
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
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text(
                  'Tidak',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (dataJanjiTemu!.status == 1 &&
                      _alasanController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Alasan tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    tolak(_alasanController.text);
                  }
                },
                child: Text(
                  'IYA, TOLAK!',
                  style: smartRTTextNormal.copyWith(
                    fontWeight: FontWeight.bold,
                    color: smartRTStatusRedColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void konfirmasiGantiTanggal() {
    final _newDateTime = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Pilihlah tanggal dan waktu sesuai yang anda inginkan!\n\n*Tanggal dan waktu yang akan ajukan akan dikonfirmasi oleh pemohon, jika pemohon menerimanya maka janji temu akan menjadi terjadwalkan. Namun, jika pemohon menolak maka janji temu akan batal.',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DateTimePicker(
              type: DateTimePickerType.dateTime,
              locale: const Locale('id', 'ID'),
              dateMask: 'dd MMMM yyyy HH:mm',
              style: smartRTTextNormal_Primary,
              firstDate: DateTime.now().add(const Duration(days: 3)),
              lastDate: DateTime.now().add(const Duration(days: 90)),
              initialDate: DateTime.now().add(const Duration(days: 3)),
              dateLabelText: 'Tanggal Janjian',
              onChanged: (val) => print(val),
              onSaved: (val) => print(val),
              controller: _newDateTime,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Batal'),
                child: Text(
                  'Batal',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (dataJanjiTemu!.status == 1 && _newDateTime.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Tanggal dan Waktu tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    gantiTanggal(_newDateTime.text);
                  }
                },
                child: Text(
                  'Ajukan',
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

  void konfirmasiGantiResponden() {
    if (user.area!.wakil_ketua_id == null && user.area!.sekretaris_id == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda tidak dapat mengganti responden dikarenakan anda tidak memiliki wakil ataupun sekretaris.',
            style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Ok'),
                  child: Text(
                    'Ok',
                    style:
                        smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } else {
      String _newRespondenSelected = '';
      final List<DropdownMenuItem> _newRespondenItems = [
        if (user.area!.wakil_ketua_id != null)
          DropdownMenuItem(
              value: user.area!.wakil_ketua_id!.id.toString(),
              child: Text(user.area!.wakil_ketua_id!.full_name)),
        if (user.area!.sekretaris_id != null)
          DropdownMenuItem(
              value: user.area!.sekretaris_id!.id.toString(),
              child: Text(user.area!.sekretaris_id!.full_name)),
      ];
      _newRespondenSelected = _newRespondenItems[0].value;
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Pilihlah responden penggantimu! Anda hanya dapat memilih antara wakil atau sekretaris anda saja!\n\n*Setelah anda memberikan kepada pengurus lainnya, maka anda hanya dapat melihat dan tidak dapat melakukan aksi apapun terhadap janji temu tersebut.',
            style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField2(
                value: _newRespondenItems[0].value,
                dropdownMaxHeight: 200,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: smartRTPrimaryColor,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: _newRespondenItems
                    .map((item) => DropdownMenuItem<String>(
                        value: item.value, child: item.child))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _newRespondenSelected = value.toString();
                  });
                },
                onSaved: (value) {
                  _newRespondenSelected = value.toString();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Batal'),
                  child: Text(
                    'Batal',
                    style:
                        smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (dataJanjiTemu!.status == 1 &&
                        _newRespondenSelected == '') {
                      SmartRTSnackbar.show(context,
                          message: 'Anda wajib memilih responden baru!',
                          backgroundColor: smartRTErrorColor);
                    } else {
                      gantiResponden(_newRespondenSelected);
                    }
                  },
                  child: Text(
                    'Ajukan',
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
  }

  void getData() async {
    dataJanjiTemu = widget.args.dataJanjiTemu;

    if (dataJanjiTemu!.created_by!.id ==
        dataJanjiTemu!.meet_datetime_negotiated_by!.id) {
      meetDateTimeBy = 'Pemohon';
    } else {
      meetDateTimeBy = 'Responden';
    }

    confirmationNotes = dataJanjiTemu!.confirmated_notes ?? '';

    if (dataJanjiTemu!.created_by!.id == user.id) {
      titleDataPemohon = 'DATA PEMOHON (SAYA)';
    }

    if (dataJanjiTemu!.status == 0) {
      status = dataJanjiTemu!.created_by!.id ==
              dataJanjiTemu!.meet_datetime_negotiated_by!.id
          ? 'Menunggu Konfirmasi Responden'
          : 'Menunggu Konfirmasi Pemohon';
      if (dataJanjiTemu!.created_by!.id == user.id) {
        if (dataJanjiTemu!.meet_datetime_negotiated_by!.id ==
            dataJanjiTemu!.created_by!.id) {
          showBtnBatal = true;
        }

        if (dataJanjiTemu!.meet_datetime_negotiated_by!.id != user.id) {
          showBtnTerima = true;
          showBtnTolak = true;
        }
      } else if (dataJanjiTemu!.origin_respondent_by!.id == user.id &&
          dataJanjiTemu!.new_respondent_by == null) {
        showBtnGantiTanggalWaktu = true;
        showBtnGantiResponden = true;

        showBtnTolak = true;
        if (dataJanjiTemu!.meet_datetime_negotiated_by!.id ==
            dataJanjiTemu!.created_by!.id) {
          showBtnTerima = true;
        }
      } else if (dataJanjiTemu!.new_respondent_by != null) {
        if (dataJanjiTemu!.new_respondent_by!.id == user.id) {
          showBtnGantiTanggalWaktu = true;
          showBtnGantiResponden = true;
          if (dataJanjiTemu!.meet_datetime_negotiated_by!.id ==
              dataJanjiTemu!.created_by!.id) {
            showBtnTerima = true;
          }
          showBtnTolak = true;
        }
      }
    } else if (dataJanjiTemu!.status == 1 || dataJanjiTemu!.status < 0) {
      status = dataJanjiTemu!.status == 1
          ? 'Terjadwalkan'
          : dataJanjiTemu!.status == -1
              ? 'Ditolak'
              : 'Dibatalkan';
      confirmationDate = DateFormat('EEEE, d MMMM y HH:mm', 'id_ID')
          .format(dataJanjiTemu!.confirmated_at!);
      confirmationBy =
          '${dataJanjiTemu!.confirmated_by!.full_name} (${dataJanjiTemu!.confirmated_by!.id == dataJanjiTemu!.created_by!.id ? 'Pemohon' : 'Responden'})';
    }

    pemohonName = dataJanjiTemu!.created_by!.full_name;
    pemohonTelp = dataJanjiTemu!.created_by!.phone;
    pemohonAddress = dataJanjiTemu!.created_by!.address ?? '-';
    if (pemohonAddress != '-' && dataJanjiTemu!.created_by!.area != null) {
      pemohonKecamatan =
          'Kec. ${dataJanjiTemu!.created_by!.area!.data_kecamatan!.name}';
      pemohonKelurahan =
          'Kel. ${dataJanjiTemu!.created_by!.area!.data_kelurahan!.name.substring(10)}';
      pemohonRTRW =
          '${StringFormat.numFormatRTRW(dataJanjiTemu!.created_by!.area!.rt_num.toString())}/${StringFormat.numFormatRTRW(dataJanjiTemu!.created_by!.area!.rw_num.toString())}';
    }

    if (dataJanjiTemu!.new_respondent_by == null) {
      respondenName = dataJanjiTemu!.origin_respondent_by!.full_name;
      respondenAddress = dataJanjiTemu!.origin_respondent_by!.address ?? '-';
      if (respondenAddress != '-' &&
          dataJanjiTemu!.origin_respondent_by!.area != null) {
        respondenKecamatan =
            'Kec. ${dataJanjiTemu!.origin_respondent_by!.area!.data_kecamatan!.name}';
        respondenKelurahan =
            'Kel. ${dataJanjiTemu!.origin_respondent_by!.area!.data_kelurahan!.name.substring(10)}';
        respondenRTRW =
            '${StringFormat.numFormatRTRW(dataJanjiTemu!.origin_respondent_by!.area!.rt_num.toString())}/${StringFormat.numFormatRTRW(dataJanjiTemu!.created_by!.area!.rw_num.toString())}';
      }
      if (dataJanjiTemu!.origin_respondent_by!.id == user.id) {
        titleDataResponden = 'DATA RESPONDEN (SAYA)';
      }
    } else {
      respondenName = dataJanjiTemu!.new_respondent_by!.full_name;
      respondenAddress = dataJanjiTemu!.new_respondent_by!.address ?? '-';
      if (respondenAddress != '-' &&
          dataJanjiTemu!.new_respondent_by!.area != null) {
        respondenKecamatan =
            'Kec. ${dataJanjiTemu!.new_respondent_by!.area!.data_kecamatan!.name}';
        respondenKelurahan =
            'Kel. ${dataJanjiTemu!.new_respondent_by!.area!.data_kelurahan!.name.substring(10)}';
        respondenRTRW =
            '${StringFormat.numFormatRTRW(dataJanjiTemu!.new_respondent_by!.area!.rt_num.toString())}/${StringFormat.numFormatRTRW(dataJanjiTemu!.created_by!.area!.rw_num.toString())}';
      }
      if (dataJanjiTemu!.new_respondent_by!.id == user.id) {
        titleDataResponden = 'DATA RESPONDEN (SAYA)';
      }
    }

    keperluanTitle = dataJanjiTemu!.title;
    keperluanDetail = dataJanjiTemu!.detail;
    keperluanLampiran = dataJanjiTemu!.file_lampiran;

    meetDate = DateFormat('EEEE, d MMMM y', 'id_ID')
        .format(dataJanjiTemu!.meet_datetime);
    meetTime =
        '${DateFormat('HH:mm', 'id_ID').format(dataJanjiTemu!.meet_datetime)} WIB';

    if (user.user_role != Role.Ketua_RT) {
      showBtnGantiResponden = false;
    }
    _getPDFFromServer();
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
        title: Text('Detail Janji Temu'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'STATUS',
                style: smartRTTextTitleCard,
                textAlign: TextAlign.left,
              ),
              ListTileData1(txtLeft: 'Status', txtRight: status),
              if (confirmationBy != '' && status != 'Terjadwalkan')
                ListTileData1(txtLeft: '', txtRight: 'Oleh $confirmationBy'),
              if (confirmationNotes != '')
                ListTileData1(txtLeft: 'Alasan', txtRight: confirmationNotes),
              if (confirmationDate != '')
                ListTileData1(
                    txtLeft: 'Tanggal Konfirmasi', txtRight: confirmationDate),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Text(
                titleDataPemohon,
                style: smartRTTextTitleCard,
                textAlign: TextAlign.left,
              ),
              SB_height15,
              ListTileData1(txtLeft: 'Nama', txtRight: pemohonName),
              ListTileData1(txtLeft: 'Telepon', txtRight: pemohonTelp),
              ListTileData1(txtLeft: 'Alamat', txtRight: pemohonAddress),
              if (pemohonKecamatan != '')
                ListTileData1(txtLeft: 'Kecamatan', txtRight: pemohonKecamatan),
              if (pemohonKelurahan != '')
                ListTileData1(txtLeft: 'Kelurahan', txtRight: pemohonKelurahan),
              if (pemohonRTRW != '')
                ListTileData1(txtLeft: 'RT/RW', txtRight: pemohonRTRW),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Text(
                titleDataResponden,
                style: smartRTTextTitleCard,
                textAlign: TextAlign.left,
              ),
              ListTileData1(txtLeft: 'Nama', txtRight: respondenName),
              ListTileData1(txtLeft: 'Alamat', txtRight: respondenAddress),
              if (respondenKecamatan != '')
                ListTileData1(
                    txtLeft: 'Kecamatan', txtRight: respondenKecamatan),
              if (respondenKelurahan != '')
                ListTileData1(
                    txtLeft: 'Kelurahan', txtRight: respondenKelurahan),
              if (respondenRTRW != '')
                ListTileData1(txtLeft: 'RT/RW', txtRight: respondenRTRW),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Text(
                status == 'Terjadwalkan' || status == 'Selesai'
                    ? 'TANGGAL DAN WAKTU'
                    : 'TANGGAL DAN WAKTU\nYANG DIAJUKAN',
                style: smartRTTextTitleCard,
                textAlign: TextAlign.left,
              ),
              SB_height15,
              ListTileData1(txtLeft: 'Hari, Tanggal', txtRight: meetDate),
              ListTileData1(txtLeft: 'Waktu', txtRight: meetTime),
              if (status == 'Menunggu Konfirmasi Responden' ||
                  status == 'Menunggu Konfirmasi Pemohon')
                ListTileData1(
                    txtLeft: 'Diajukan Oleh', txtRight: meetDateTimeBy),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Text(
                'KEPERLUAN',
                style: smartRTTextTitleCard,
                textAlign: TextAlign.left,
              ),
              SB_height15,
              ListTileData1(txtLeft: 'Judul', txtRight: keperluanTitle),
              ListTileData1(txtLeft: 'Isi', txtRight: ''),
              SB_height5,
              Text(
                keperluanDetail,
                style: smartRTTextLarge,
                textAlign: TextAlign.justify,
              ),
              SB_height5,
              ListTileData1(
                txtLeft: 'Lampiran',
                txtRight: 'Lihat Lampiran',
                txtStyleRight: smartRTTextLarge.copyWith(
                    decoration: TextDecoration.underline,
                    color: smartRTActiveColor2),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PDFScreen(path: keperluanLampiranPath),
                    ),
                  );
                },
              ),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              if (showBtnGantiResponden)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: smartRTPrimaryColor,
                        ),
                        onPressed: () async {
                          konfirmasiGantiResponden();
                        },
                        child: Text(
                          'GANTI RESPONDEN',
                          style: smartRTTextLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: smartRTSecondaryColor),
                        ),
                      ),
                    ),
                    SB_height15,
                  ],
                ),
              if (showBtnGantiTanggalWaktu)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: smartRTPrimaryColor,
                        ),
                        onPressed: () async {
                          konfirmasiGantiTanggal();
                        },
                        child: Text(
                          'AJUKAN GANTI TANGGAL & WAKTU',
                          style: smartRTTextLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: smartRTSecondaryColor),
                        ),
                      ),
                    ),
                    SB_height15,
                  ],
                ),
              if (showBtnBatal)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: smartRTErrorColor,
                        ),
                        onPressed: () async {
                          konfirmasiBatalkan();
                        },
                        child: Text(
                          'BATALKAN PERMOHONAN',
                          style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SB_height15,
                  ],
                ),
              if (showBtnTerima)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: smartRTSuccessColor,
                        ),
                        onPressed: () async {
                          konfirmasiTerima();
                        },
                        child: Text(
                          'TERIMA PERMOHONAN',
                          style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SB_height15,
                  ],
                ),
              if (showBtnTolak)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: smartRTErrorColor,
                        ),
                        onPressed: () async {
                          konfirmasiTolak();
                        },
                        child: Text(
                          'TOLAK PERMOHONAN',
                          style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SB_height15,
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
