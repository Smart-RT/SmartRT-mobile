import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/committe_provider.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:smart_rt/models/committe/committe.dart';
import 'package:provider/provider.dart';

class LihatStatusKepanitiaanSayaPage extends StatefulWidget {
  static const String id = 'LihatStatusKepanitiaanSayaPage';

  const LihatStatusKepanitiaanSayaPage({Key? key}) : super(key: key);

  @override
  State<LihatStatusKepanitiaanSayaPage> createState() =>
      _LihatStatusKepanitiaanSayaPageState();
}

class _LihatStatusKepanitiaanSayaPageState
    extends State<LihatStatusKepanitiaanSayaPage> {
  User user = AuthProvider.currentUser!;

  String tanggalDaftar = '';
  String didaftarkanOleh = '';
  String status = '';
  String alasan = '';

  void showConfirmationCancel(Committe data) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin membatalkan pendaftaran panitia anda?',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text('Tidak', style: smartRTTextNormal),
              ),
              TextButton(
                onPressed: () async {
                  bool isSuccess = await context
                      .read<CommitteProvider>()
                      .cancelReqCommitte(idCommitte: data.id);
                  Navigator.pop(context);
                  if (isSuccess) {
                    Navigator.pop(context);
                    SmartRTSnackbar.show(context,
                        message: 'Berhasil membatalkan pendaftaran panitia!',
                        backgroundColor: smartRTSuccessColor);
                  } else {
                    SmartRTSnackbar.show(context,
                        message: 'Gagal! Cobalah lagi nanti!',
                        backgroundColor: smartRTErrorColor);
                  }
                },
                child: Text(
                  'IYA, YAKIN!',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      color: smartRTStatusRedColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showConfirmationRekomendasi(Committe data) {
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Pilihlah "TERIMA" jika anda ingin bergabung menjadi PANITIA, dan pilihlah "TOLAK" dan berikan alasan jika anda tidak ingin menjadi PANITIA',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Batal'),
                child: Text('Batal', style: smartRTTextNormal),
              ),
              TextButton(
                onPressed: () async {
                  tolakPermintaan(data);
                },
                child: Text(
                  'TOLAK',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      color: smartRTStatusRedColor),
                ),
              ),
              TextButton(
                onPressed: () async {
                  bool isSuccess = await context
                      .read<CommitteProvider>()
                      .acceptReqCommitte(idCommitte: data.id);
                  Navigator.pop(context);
                  if (isSuccess) {
                    await context
                        .read<AuthProvider>()
                        .refreshDataUser(userId: user.id);
                    SmartRTSnackbar.show(context,
                        message: 'Berhasil menerima rekomendasi panitia!',
                        backgroundColor: smartRTSuccessColor);
                  } else {
                    SmartRTSnackbar.show(context,
                        message: 'Gagal! Cobalah lagi nanti!',
                        backgroundColor: smartRTErrorColor);
                  }
                },
                child: Text(
                  'TERIMA',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      color: smartRTStatusGreenColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void tolakPermintaan(Committe data) async {
    final _alasanController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Anda wajib mengisikan alasan penolakan sebagai panitia!',
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
                onPressed: () async {
                  if (_alasanController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Alasan tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    bool isSuccess = await context
                        .read<CommitteProvider>()
                        .rejectReqCommitte(
                            idCommitte: data.id,
                            alasan: _alasanController.text);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    setState(() {});
                    if (isSuccess) {
                      SmartRTSnackbar.show(context,
                          message: 'Berhasil menolak rekomendasi panitia!',
                          backgroundColor: smartRTSuccessColor);
                    } else {
                      SmartRTSnackbar.show(context,
                          message: 'Gagal! Cobalah lagi nanti!',
                          backgroundColor: smartRTErrorColor);
                    }
                  }
                },
                child: Text(
                  'KIRIM ALASAN',
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

  void getData(Committe dataPanitia) async {
    tanggalDaftar =
        DateFormat('d MMMM y', 'id_ID').format(dataPanitia.created_at);
    if (dataPanitia.data_user!.id == dataPanitia.created_by!.id) {
      didaftarkanOleh = 'Diri Sendiri';
    } else {
      didaftarkanOleh = dataPanitia.created_by!.full_name;
    }
    status = dataPanitia.status == -1 && user.user_role == Role.Warga
        ? 'Ditolak oleh Pengurus RT'
        : dataPanitia.status == -1 && user.user_role != Role.Warga
            ? 'Ditolak oleh ${dataPanitia.confirmation_by!.full_name}'
            : dataPanitia.status == 0
                ? 'Menunggu Konfirmasi'
                : dataPanitia.status == 1
                    ? 'Aktif'
                    : 'Selesai';
    alasan = dataPanitia.notes ?? '';
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Committe dataPanitia =
        context.watch<CommitteProvider>().dataMyCommitteActive;
    getData(dataPanitia);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'STATUS KEPANITIAANKU',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              ListTileData1(txtLeft: 'Tanggal Daftar', txtRight: tanggalDaftar),
              ListTileData1(
                  txtLeft: 'Didaftarkan Oleh', txtRight: didaftarkanOleh),
              ListTileData1(txtLeft: 'Status', txtRight: status),
              if (alasan != '')
                ListTileData1(txtLeft: 'Alasan', txtRight: alasan),
            ],
          ),
        ),
      ),
      bottomNavigationBar: (dataPanitia.status == 0 &&
              dataPanitia.created_by!.id == dataPanitia.data_user!.id)
          ? Container(
              padding: paddingScreen,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: smartRTErrorColor,
                ),
                onPressed: () async {
                  showConfirmationCancel(dataPanitia);
                },
                child: Text(
                  'BATALKAN PENDAFTARAN',
                  style: smartRTTextLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : (dataPanitia.status == 0 &&
                  dataPanitia.created_by!.id != dataPanitia.data_user!.id)
              ? Container(
                  padding: paddingScreen,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: smartRTPrimaryColor,
                    ),
                    onPressed: () async {
                      showConfirmationRekomendasi(dataPanitia);
                    },
                    child: Text(
                      'KONFIRMASI REKOMENDASI',
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: smartRTSecondaryColor),
                    ),
                  ),
                )
              : const SizedBox(),
    );
  }
}
