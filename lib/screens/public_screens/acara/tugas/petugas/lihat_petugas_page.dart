import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/models/event/event_task_detail.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/lihat_petugas_page_rating.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_1.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/constants/style.dart';

class LihatPetugasPageArgument {
  int dataTaskIdx;
  int dataEventIdx;
  String title;
  bool isPast;
  LihatPetugasPageArgument(
      {required this.dataTaskIdx,
      required this.dataEventIdx,
      required this.title,
      required this.isPast});
}

class LihatPetugasPage extends StatefulWidget {
  static const String id = 'LihatPetugasPage';
  LihatPetugasPageArgument args;
  LihatPetugasPage({Key? key, required this.args}) : super(key: key);

  @override
  State<LihatPetugasPage> createState() => _LihatPetugasPageState();
}

class _LihatPetugasPageState extends State<LihatPetugasPage> {
  User user = AuthProvider.currentUser!;

  void actionOnTap({
    required EventTaskDetail dataPetugas,
    required bool isPast,
    required EventTask dataTugas,
    required int dataEventIdx,
    required int dataTaskIdx,
  }) async {
    if ((user.user_role == Role.Ketua_RT ||
            user.user_role == Role.Wakil_RT ||
            user.user_role == Role.Sekretaris) &&
        !isPast) {
      showDialogKickOut(
          dataEventIdx: dataEventIdx,
          dataPetugas: dataPetugas,
          dataTaskIdx: dataTaskIdx);
    } else if (isPast) {
      LihatPetugasPageRatingArgument args = LihatPetugasPageRatingArgument(
          title: '${dataPetugas.dataUser!.full_name}\n${dataTugas.title}',
          isPast: isPast,
          dataPetugas: dataPetugas,
          dataTugas: dataTugas);
      Navigator.pushNamed(context, LihatPetugasPageRating.id, arguments: args);
    }
  }

  void showDialogKickOut({
    required EventTaskDetail dataPetugas,
    required int dataEventIdx,
    required int dataTaskIdx,
  }) async {
    final _alasanController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,\n\nApakah anda ingin mengeluarkan petugas ${dataPetugas.dataUser!.full_name}?',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Anda wajib mengisikan alasan mengeluarkan petugas',
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
                onPressed: () {
                  if (_alasanController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Alasan tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    keluarkanPetugas(
                        alasan: _alasanController.text,
                        dataEventIdx: dataEventIdx,
                        dataPetugas: dataPetugas,
                        dataTaskIdx: dataTaskIdx);
                  }
                },
                child: Text(
                  'Iya, Keluarkan!',
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

  void keluarkanPetugas({
    required EventTaskDetail dataPetugas,
    required String alasan,
    required int dataEventIdx,
    required int dataTaskIdx,
  }) async {
    await context
        .read<EventProvider>()
        .kickOutWorker(idTaskDetail: dataPetugas.id, alasan: alasan);
    Navigator.pop(context);
    Navigator.pop(context);
    SmartRTSnackbar.show(context,
        message: 'Berhasil mengeluarkan petugas !',
        backgroundColor: smartRTSuccessColor);
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.args.title;
    bool isPast = widget.args.isPast;
    int dataTaskIdx = widget.args.dataTaskIdx;
    int dataEventIdx = widget.args.dataEventIdx;
    EventTask dataTugas = context
        .watch<EventProvider>()
        .dataListEvent[dataEventIdx]
        .tasks[dataTaskIdx];
    List<EventTaskDetail> listPetugas = context
        .watch<EventProvider>()
        .dataListEvent[dataEventIdx]
        .tasks[dataTaskIdx]
        .listPetugas;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Padding(
            padding: paddingScreen,
            child: ExplainPart(title: 'DATA PETUGAS', notes: title),
          ),
          Divider(
            color: smartRTPrimaryColor,
            height: 2,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listPetugas.length,
              itemBuilder: (context, index) {
                return (listPetugas[index].status == 1)
                    ? Column(
                        children: [
                          ListTileUser1(
                            fullName: listPetugas[index].dataUser!.full_name,
                            address: listPetugas[index].dataUser!.address!,
                            initialName: StringFormat.initialName(
                                listPetugas[index].dataUser!.full_name),
                            ratingAVG: listPetugas[index].rating_avg ?? '0',
                            ratingCTR: listPetugas[index].rating_ctr.toString(),
                            onTap: () {
                              debugPrint(index.toString());
                              actionOnTap(
                                  dataPetugas: listPetugas[index],
                                  dataTugas: dataTugas,
                                  isPast: isPast,
                                  dataEventIdx: dataEventIdx,
                                  dataTaskIdx: dataTaskIdx);
                            },
                          ),
                          Divider(
                            color: smartRTPrimaryColor,
                            height: 5,
                          )
                        ],
                      )
                    : const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
