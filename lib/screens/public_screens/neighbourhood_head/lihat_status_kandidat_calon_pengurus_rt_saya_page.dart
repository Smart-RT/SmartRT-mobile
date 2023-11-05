import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/committe_provider.dart';
import 'package:smart_rt/providers/neighbourhood_head_provider.dart';
import 'package:smart_rt/utilities/int/int_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:smart_rt/models/committe/committe.dart';
import 'package:provider/provider.dart';

class LihatStatusKandidatCalonPengurusRTSayaPage extends StatefulWidget {
  static const String id = 'LihatStatusKandidatCalonPengurusRTSayaPage';

  const LihatStatusKandidatCalonPengurusRTSayaPage({Key? key})
      : super(key: key);

  @override
  State<LihatStatusKandidatCalonPengurusRTSayaPage> createState() =>
      _LihatStatusKandidatCalonPengurusRTSayaPageState();
}

class _LihatStatusKandidatCalonPengurusRTSayaPageState
    extends State<LihatStatusKandidatCalonPengurusRTSayaPage> {
  User user = AuthProvider.currentUser!;

  String kandidatName = '';
  String kandidatAddress = '';
  String kandidatAge = '';
  String kandidatGender = '';
  String kandidatBornDate = '';

  String tanggalDaftar = '';
  String didaftarkanOleh = '';
  String status = '';
  String alasan = '';
  String visi = '';
  String misi = '';

  void showConfirmationMengunduranDiri(NeighbourhoodHeadCandidate data) {
    final _alasanController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin mengundurkan diri dari kandidat calon Pengurus RT? Jika yakin, anda wajib memberikan alasan pengunduran diri anda!\n\n*Setelah anda mengundurkan diri, anda tidak dapat mendaftar kembali pada periode ini!',
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
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text('Tidak', style: smartRTTextNormal),
              ),
              TextButton(
                onPressed: () async {
                  if (_alasanController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Alasan tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    bool isSuccess = await context
                        .read<NeighbourhoodHeadProvider>()
                        .resignFromCandidate(
                            idNeighbourhoodHeadCandidate: data.id,
                            notes: _alasanController.text,
                            periode: data.periode.toString());
                    Navigator.pop(context);
                    if (isSuccess) {
                      SmartRTSnackbar.show(context,
                          message: 'Berhasil mengundurkan diri!',
                          backgroundColor: smartRTSuccessColor);
                    } else {
                      SmartRTSnackbar.show(context,
                          message: 'Gagal! Cobalah lagi nanti!',
                          backgroundColor: smartRTErrorColor);
                    }
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

  void showConfirmationUbahVisiMisi(NeighbourhoodHeadCandidate data) {
    final _visiController = TextEditingController();
    final _misiController = TextEditingController();
    showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'VISI MISI',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Anda wajib mengisikan Visi Misi anda !\n\nPastikan anda mengecek kembali visi misi anda, karena anda tidak dapat merubahnya setelah anda menyimpannya!',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _visiController,
              maxLines: 1,
              autocorrect: false,
              style: smartRTTextNormal_Primary,
              decoration: const InputDecoration(
                labelText: 'Visi',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _misiController,
              maxLines: 5,
              autocorrect: false,
              style: smartRTTextNormal_Primary,
              decoration: const InputDecoration(
                labelText: 'Misi',
              ),
            ),
          ),
          SB_height30,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  if (_visiController.text == '' ||
                      _misiController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Visi dan Misi tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    bool isSuccess = await context
                        .read<NeighbourhoodHeadProvider>()
                        .fillVisiMisi(
                            idNeighbourhoodHeadCandidate: data.id,
                            visi: _visiController.text,
                            misi: _misiController.text,
                            periode: data.periode.toString());
                    Navigator.pop(context);
                    if (isSuccess) {
                      SmartRTSnackbar.show(context,
                          message: 'Berhasil menyimpan Visi Misi!',
                          backgroundColor: smartRTSuccessColor);
                    } else {
                      SmartRTSnackbar.show(context,
                          message: 'Gagal! Cobalah lagi nanti!',
                          backgroundColor: smartRTErrorColor);
                    }
                  }
                },
                child: Text(
                  'SIMPAN',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getData({required NeighbourhoodHeadCandidate dataKandidat}) async {
    kandidatName = dataKandidat.dataUser!.full_name;
    kandidatAddress = dataKandidat.dataUser!.address ?? '-';
    kandidatAge =
        StringFormat.ageNow(bornDate: dataKandidat.dataUser!.born_date!);
    kandidatGender = dataKandidat.dataUser!.gender;
    kandidatBornDate = DateFormat('d MMMM y', 'id_ID')
        .format(dataKandidat.dataUser!.born_date!);

    visi = dataKandidat.visi;
    misi = dataKandidat.misi;

    tanggalDaftar =
        DateFormat('d MMMM y', 'id_ID').format(dataKandidat.created_at);
    if (dataKandidat.dataUser!.id == dataKandidat.created_by!.id) {
      didaftarkanOleh = 'Diri Sendiri';
    } else {
      didaftarkanOleh = dataKandidat.created_by!.full_name;
    }
    status = dataKandidat.status == -2
        ? 'Mengundurkan Diri'
        : dataKandidat.status == -1
            ? 'Di Diskualifikasi'
            : 'Aktif';

    alasan = dataKandidat.discualified_notes ?? '';
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NeighbourhoodHeadCandidate dataKandidat = context
        .watch<NeighbourhoodHeadProvider>()
        .dataSayaSebagaiKandidatPengurusRTSekarang;
    getData(dataKandidat: dataKandidat);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'KANDIDAT CALON PENGURUS RT',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              ListTileData1(txtLeft: 'Nama', txtRight: kandidatName),
              ListTileData1(txtLeft: 'Alamat', txtRight: kandidatAddress),
              ListTileData1(txtLeft: 'Jenis Kelamin', txtRight: kandidatGender),
              ListTileData1(
                  txtLeft: 'Tanggal Lahir', txtRight: kandidatBornDate),
              ListTileData1(txtLeft: 'Umur', txtRight: kandidatAge),
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
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              ListTileData1(txtLeft: 'Visi', txtRight: visi),
              ListTileData1(txtLeft: 'Misi', txtRight: misi),
              SB_height15,
              if (dataKandidat.status == 1 &&
                  user.id == dataKandidat.dataUser!.id &&
                  (dataKandidat.visi == 'Belum Diisi !' ||
                      dataKandidat.misi == 'Belum Diisi !'))
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: smartRTPrimaryColor,
                    ),
                    onPressed: () async {
                      showConfirmationUbahVisiMisi(dataKandidat);
                    },
                    child: Text(
                      'ISI VISI MISI SEKARANG!',
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: smartRTSecondaryColor),
                    ),
                  ),
                ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          (dataKandidat.status == 1 && user.id == dataKandidat.dataUser!.id)
              ? Container(
                  padding: paddingScreen,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: smartRTErrorColor,
                    ),
                    onPressed: () async {
                      showConfirmationMengunduranDiri(dataKandidat);
                    },
                    child: Text(
                      'MENGUNDURKAN DIRI',
                      style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
    );
  }
}
