import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_page.dart';
import 'package:smart_rt/screens/public_screens/acara/form_acara/form_acara_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/form_tugas/form_tugas_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/tugas_page_detail.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_status_color.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/models/event/event.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/constants/style.dart';

class AcaraPageDetailArgument {
  int dataEventIdx;
  AcaraPageDetailArgument({required this.dataEventIdx});
}

class AcaraPageDetail extends StatefulWidget {
  static const String id = 'AcaraPageDetail';
  AcaraPageDetailArgument args;
  AcaraPageDetail({Key? key, required this.args}) : super(key: key);

  @override
  State<AcaraPageDetail> createState() => _AcaraPageDetailState();
}

class _AcaraPageDetailState extends State<AcaraPageDetail> {
  User user = AuthProvider.currentUser!;
  String title = '';
  String detail = '';
  String tanggal = '';
  String waktu = '';
  List<EventTask> listTask = [];
  Widget actionWidget = SizedBox();
  bool isBtnCreateNewTaskShowed = false;
  bool isPast = false;

  void confirmationDeleteEvent({required Event dataEvent}) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menghapus Acara yang berjudul ${dataEvent.title} dan dilaksanakan pada tanggal ${DateFormat('d MMMM y HH:mm WIB', 'id_ID').format(dataEvent.event_date_start_at)} ?',
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
                  deleteEvent(idEvent: dataEvent.id);
                },
                child: Text(
                  'IYA, HAPUS!',
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

  void deleteEvent({required int idEvent}) async {
    await context.read<EventProvider>().deleteEvent(idEvent: idEvent);
    Navigator.pop(context);
    Navigator.pop(context);
    SmartRTSnackbar.show(context,
        message: 'Berhasil menghapus event !',
        backgroundColor: smartRTSuccessColor);
  }

  void getData({required Event dataEvent, required int dataEventIdx}) async {
    title = dataEvent.title;
    detail = dataEvent.detail;
    tanggal =
        DateFormat('d MMMM y', 'id_ID').format(dataEvent.event_date_start_at);
    waktu =
        '${DateFormat('HH:mm', 'id_ID').format(dataEvent.event_date_start_at)} - ${DateFormat('HH:mm', 'id_ID').format(dataEvent.event_date_end_at)} WIB';

    listTask = dataEvent.tasks;

    String temp = DateFormat('yMMdd').format(dataEvent.event_date_start_at);
    DateTime startDate = DateTime.parse(temp);

    if (startDate.compareTo(DateTime.now()) < 0) {
      isPast = true;
    }

    if ((user.user_role == Role.Ketua_RT ||
            user.user_role == Role.Wakil_RT ||
            user.user_role == Role.Sekretaris) &&
        startDate.compareTo(DateTime.now()) > 0) {
      isBtnCreateNewTaskShowed = true;
      actionWidget = Row(
        children: [
          GestureDetector(
            onTap: () {
              confirmationDeleteEvent(dataEvent: dataEvent);
            },
            child: Icon(Icons.delete_forever_outlined),
          ),
          SB_width15,
          GestureDetector(
            onTap: () {
              FormAcaraPageArgument args = FormAcaraPageArgument(
                  type: 'update', dataEventIdx: dataEventIdx);
              Navigator.pushNamed(context, FormAcaraPage.id, arguments: args);
            },
            child: Icon(Icons.edit_document),
          ),
          SB_width15,
        ],
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int dataEventIdx = widget.args.dataEventIdx;
    Event dataEvent =
        context.watch<EventProvider>().dataListEvent[dataEventIdx];
    getData(dataEvent: dataEvent, dataEventIdx: dataEventIdx);
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
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Text(
                'TANGGAL DAN WAKTU',
                style: smartRTTextTitleCard,
              ),
              SB_height15,
              ListTileData1(txtLeft: 'Tanggal', txtRight: tanggal),
              ListTileData1(txtLeft: 'Waktu', txtRight: waktu),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Text(
                'TUGAS',
                style: smartRTTextTitleCard,
              ),
              SB_height15,
              if (listTask.isNotEmpty)
                SizedBox(
                  height: 250,
                  child: Scrollbar(
                    child: ListView.separated(
                      separatorBuilder: (context, int) {
                        return Divider(
                          color: smartRTPrimaryColor,
                          height: 5,
                        );
                      },
                      itemCount: listTask.length,
                      itemBuilder: (context, index) {
                        return CardListTileWithStatusColor(
                            title: listTask[index].title,
                            subtitle: listTask[index].detail,
                            bottomText:
                                'Slot Kosong : ${(listTask[index].total_worker_needed - listTask[index].total_worker_now)} orang (${listTask[index].is_general == 0 ? 'Melalui Seleksi' : 'Umum'})',
                            statusColor: listTask[index].total_worker_now ==
                                    listTask[index].total_worker_needed
                                ? smartRTStatusRedColor
                                : smartRTStatusGreenColor,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            onTap: () {
                              TugasPageDetailArgument args =
                                  TugasPageDetailArgument(
                                dataEventIdx: dataEventIdx,
                                dataTaskIdx: index,
                                isPast: isPast,
                              );
                              Navigator.pushNamed(context, TugasPageDetail.id,
                                  arguments: args);
                            });
                      },
                    ),
                  ),
                ),
              if (listTask.isNotEmpty) SB_height15,
              if (isBtnCreateNewTaskShowed)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, FormTugasPage.id,
                          arguments: FormTugasPageArgument(
                              dataEventIdx: dataEventIdx));
                    },
                    child: Text(
                      listTask.isEmpty
                          ? 'BUKA TUGAS SEKARANG!'
                          : 'BUAT TUGAS BARU',
                      style: smartRTTextLargeBold_Secondary,
                    ),
                  ),
                ),
              if (!isBtnCreateNewTaskShowed && listTask.isEmpty)
                Center(
                  child: Text(
                    'Tidak ada Tugas',
                    style: smartRTTextLarge,
                  ),
                ),
              const Divider(
                height: 50,
                thickness: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
