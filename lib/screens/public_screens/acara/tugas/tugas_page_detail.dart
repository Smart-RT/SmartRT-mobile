import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/models/event/event_task_detail.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/beri_tugas_warga_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/konfirmasi_petugas_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/lihat_petugas_page.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/constants/style.dart';

class TugasPageDetailArgument {
  int dataTaskIdx;
  int dataEventIdx;
  bool isPast;
  TugasPageDetailArgument(
      {required this.dataTaskIdx,
      required this.dataEventIdx,
      required this.isPast});
}

class TugasPageDetail extends StatefulWidget {
  static const String id = 'TugasPageDetail';
  TugasPageDetailArgument args;
  TugasPageDetail({Key? key, required this.args}) : super(key: key);

  @override
  State<TugasPageDetail> createState() => _TugasPageDetailState();
}

class _TugasPageDetailState extends State<TugasPageDetail> {
  User user = AuthProvider.currentUser!;
  String title = '';
  String detail = '';
  String totalWorkerNeeded = '0';
  String totalWorkerNow = '0';
  String type = '';
  List<EventTaskDetail> dataListReq = [];
  int ctrListReq = 0;
  Widget actionWidget = SizedBox();

  void getData(EventTask dataTugas) async {
    title = dataTugas.title;
    detail = dataTugas.detail;
    totalWorkerNeeded = dataTugas.total_worker_needed.toString();
    totalWorkerNow = dataTugas.total_worker_now.toString();
    type = dataTugas.is_general == 0
        ? 'Tidak untuk Umum (Membutuhkan Konfirmasi)'
        : 'untuk Umum';

    setState(() {});
  }

  void ambilTugas(int idTask) async {
    await context.read<EventProvider>().takeTask(idTask: idTask);
    SmartRTSnackbar.show(context,
        message: 'Berhasil mengambil tugas !',
        backgroundColor: smartRTSuccessColor);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int dataTaskIdx = widget.args.dataTaskIdx;
    int dataEventIdx = widget.args.dataEventIdx;
    EventTask? dataTugas = context
        .watch<EventProvider>()
        .dataListEvent[dataEventIdx]
        .tasks[dataTaskIdx];
    List<EventTaskDetail> listPetugas = context
        .watch<EventProvider>()
        .dataListEvent[dataEventIdx]
        .tasks[dataTaskIdx]
        .listPetugas;
    bool isPast = widget.args.isPast;
    bool isShowBtnAmbilTugas = true;
    bool isShowBtnBeriTugasWarga = true;
    bool isShowKeterangan = false;
    EventTaskDetail? dataTerakhirKu;

    // if ((user.user_role == Role.Ketua_RT ||
    //         user.user_role == Role.Wakil_RT ||
    //         user.user_role == Role.Sekretaris) &&
    //     !isPast) {
    //   actionWidget = Row(
    //     children: [
    //       GestureDetector(
    //         onTap: () {
    //           // confirmationDeleteEvent(dataEvent: dataEvent);
    //         },
    //         child: Icon(Icons.delete_forever_outlined),
    //       ),
    //       SB_width15,
    //       GestureDetector(
    //         onTap: () {
    //           // FormAcaraPageArgument args = FormAcaraPageArgument(
    //           //     type: 'update', dataEventIdx: dataEventIdx);
    //           // Navigator.pushNamed(context, FormAcaraPage.id, arguments: args);
    //         },
    //         child: Icon(Icons.edit_document),
    //       ),
    //       SB_width15,
    //     ],
    //   );
    // }
    getData(dataTugas);

    if ((totalWorkerNeeded == totalWorkerNow) || isPast) {
      isShowBtnAmbilTugas = false;
      isShowBtnBeriTugasWarga = false;
    } else {
      ctrListReq = 0;
      dataListReq.clear();
      for (var i = 0; i < listPetugas.length; i++) {
        // if (user.id == listPetugas[i].user_id && listPetugas[i].status >= 0) {
        if (user.id == listPetugas[i].user_id) {
          isShowKeterangan = true;
          dataTerakhirKu = listPetugas[i];
        }
        if (user.id == listPetugas[i].user_id &&
            user.user_role != Role.Ketua_RT &&
            user.user_role != Role.Sekretaris &&
            user.user_role != Role.Wakil_RT) {
          isShowBtnAmbilTugas = false;
        }

        if (user.id == listPetugas[i].user_id &&
            (user.user_role == Role.Ketua_RT ||
                user.user_role == Role.Sekretaris ||
                user.user_role == Role.Wakil_RT) &&
            listPetugas[i].status >= 0) {
          isShowBtnAmbilTugas = false;
        }

        if (listPetugas[i].status == 0) {
          dataListReq.add(listPetugas[i]);
          ctrListReq++;
        }
      }
    }

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
              ExplainPart(
                title: title.toUpperCase(),
                notes: detail,
              ),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              Text(
                'DATA PETUGAS',
                style: smartRTTextTitleCard,
              ),
              SB_height15,
              ListTileData1(
                  txtLeft: 'Total Petugas',
                  txtRight: '$totalWorkerNow / $totalWorkerNeeded orang'),
              ListTileData1(txtLeft: 'Tipe', txtRight: type),
              if (isShowKeterangan)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SB_height15,
                    Text(
                      'DATAKU',
                      style: smartRTTextTitleCard,
                    ),
                    SB_height15,
                    ListTileData1(
                        txtLeft: 'Tanggal Daftar',
                        txtRight: StringFormat.formatDate(
                            dateTime: dataTerakhirKu!.created_at,
                            isWithTime: false)),
                    ListTileData1(
                        txtLeft: 'Status',
                        txtRight: (dataTerakhirKu.status == -3)
                            ? 'Dikeluarkan'
                            : (dataTerakhirKu.status == -2 ||
                                    dataTerakhirKu.status == -1)
                                ? 'Ditolak'
                                : (dataTerakhirKu.status == 0)
                                    ? 'Menunggu Konfirmasi'
                                    : 'Aktif'),
                    ListTileData1(
                        txtLeft: dataTerakhirKu.status < 0 ? 'Alasan' : '',
                        txtRight: (dataTerakhirKu.status == -2)
                            ? 'Slot telah penuh'
                            : (dataTerakhirKu.status == -3 ||
                                    dataTerakhirKu.status == -1)
                                ? dataTerakhirKu.notes ?? '-'
                                : (dataTerakhirKu.created_by == user.id)
                                    ? 'Mendaftar Sendiri'
                                    : 'Diajukan Pengurus RT'),
                    ListTileData1(
                        txtLeft: 'Catatan',
                        txtRight: (user.user_role != Role.Ketua_RT &&
                                user.user_role != Role.Wakil_RT &&
                                user.user_role != Role.Sekretaris &&
                                dataTerakhirKu.status < 0 &&
                                dataTugas.is_general == 1)
                            ? 'Anda tidak dapat mengambil tugas kembali! Jika anda ingin bertugas maka mintalah Ketua, Wakil, atau Sekretaris untuk mengajukan dirimu untuk bertugas!'
                            : (user.user_role != Role.Ketua_RT &&
                                    user.user_role != Role.Wakil_RT &&
                                    user.user_role != Role.Sekretaris &&
                                    dataTerakhirKu.status < 0 &&
                                    dataTugas.is_general == 0)
                                ? 'Anda tidak dapat request ambil tugas kembali! Jika anda ingin bertugas maka mintalah Ketua, Wakil, atau Sekretaris untuk mengajukan dirimu untuk bertugas!'
                                : (user.user_role != Role.Ketua_RT &&
                                        user.user_role != Role.Wakil_RT &&
                                        user.user_role != Role.Sekretaris &&
                                        dataTerakhirKu.status == 0)
                                    ? 'Anda baru dapat menjadi petugas jika permintaan anda telah di terima oleh Pengurus RT'
                                    : '-')
                  ],
                ),
              SB_height15,
              if (type != 'untuk Umum' &&
                  ctrListReq != 0 &&
                  listPetugas.where((element) => element.status == 1).length <
                      dataTugas.total_worker_needed &&
                  (user.user_role == Role.Ketua_RT ||
                      user.user_role == Role.Wakil_RT ||
                      user.user_role == Role.Sekretaris))
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      List<EventTaskDetail> dataReq = [];
                      for (var i = 0; i < listPetugas.length; i++) {
                        if (listPetugas[i].status == 0) {
                          dataReq.add(listPetugas[i]);
                        }
                      }
                      KonfirmasiPetugasPageArgument args =
                          KonfirmasiPetugasPageArgument(
                              dataReq: dataReq, title: title);
                      Navigator.pushNamed(context, KonfirmasiPetugasPage.id,
                          arguments: args);
                    },
                    child: Text(
                      'KONFIRMASI PETUGAS ($ctrListReq)',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
              if (type != 'untuk Umum' &&
                  ctrListReq != 0 &&
                  (user.user_role == Role.Ketua_RT ||
                      user.user_role == Role.Wakil_RT ||
                      user.user_role == Role.Sekretaris))
                SB_height15,
              if (totalWorkerNow != '0')
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      List<EventTaskDetail> listPetugasActive = [];
                      for (var i = 0; i < listPetugas.length; i++) {
                        if (listPetugas[i].status == 1) {
                          listPetugasActive.add(listPetugas[i]);
                        }
                      }
                      LihatPetugasPageArgument args = LihatPetugasPageArgument(
                          dataEventIdx: dataEventIdx,
                          dataTaskIdx: dataTaskIdx,
                          title: dataTugas.title,
                          isPast: isPast);
                      Navigator.pushNamed(context, LihatPetugasPage.id,
                          arguments: args);
                    },
                    child: Text(
                      (isPast)
                          ? 'LIHAT PETUGAS DAN PENILAIAN'
                          : 'LIHAT PETUGAS',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
              SB_height15,
              if ((user.user_role == Role.Ketua_RT ||
                      user.user_role == Role.Wakil_RT ||
                      user.user_role == Role.Sekretaris) &&
                  isShowBtnBeriTugasWarga)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      List<int> listPetugasActiveID = [];
                      List<int> listPetugasRequestID = [];
                      for (var i = 0; i < listPetugas.length; i++) {
                        if (listPetugas[i].status == 1) {
                          listPetugasActiveID.add(listPetugas[i].user_id);
                        }

                        if (listPetugas[i].status == 0) {
                          listPetugasRequestID.add(listPetugas[i].user_id);
                        }
                      }

                      BeriTugasWargaPageArgument args =
                          BeriTugasWargaPageArgument(
                              listPetugasActiveID: listPetugasActiveID,
                              listPetugasRequestID: listPetugasRequestID,
                              totalSlotKosong: int.parse(totalWorkerNeeded) -
                                  int.parse(totalWorkerNow),
                              taskID: dataTugas.id,
                              dataTugas: dataTugas,
                              isPast: isPast,
                              title: title);
                      Navigator.pushNamed(context, BeriTugasWargaPage.id,
                          arguments: args);
                    },
                    child: Text(
                      'BERI TUGAS WARGA',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
              if ((user.user_role == Role.Ketua_RT ||
                      user.user_role == Role.Wakil_RT ||
                      user.user_role == Role.Sekretaris) &&
                  isShowBtnBeriTugasWarga)
                SB_height15,
              if (isShowBtnAmbilTugas)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ambilTugas(dataTugas.id);
                    },
                    child: Text(
                      type == 'untuk Umum' ||
                              (user.user_role == Role.Ketua_RT ||
                                  user.user_role == Role.Wakil_RT ||
                                  user.user_role == Role.Sekretaris)
                          ? 'AMBIL TUGAS'
                          : 'REQ AMBIL TUGAS',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
