import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/event/event_task.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_dokumentasi_page.dart';
import 'package:smart_rt/screens/public_screens/acara/form_acara/form_acara_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/form_tugas/form_tugas_page.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/tugas_page_detail.dart';
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
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

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

  // PDF
  Future<void> _createPDF({required Event dataEvent}) async {
    String wilayah =
        'Kec. ${user.data_sub_district!.name}, Kel. ${user.data_urban_village!.name.substring(10)}\nRW ${user.rw_num} / RT ${user.rt_num}';
    String namaPembuat = dataEvent.created_by!.full_name;
    String jabatanPembuat = dataEvent.created_by!.user_role.name;
    String alamatPembuat = dataEvent.created_by!.address ?? '';
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text('LAPORAN ACARA',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Text(wilayah,
                    style: pw.TextStyle(
                      fontSize: 15,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    textAlign: pw.TextAlign.center),
                pw.Divider(
                  height: 30,
                  thickness: 5,
                  color: PdfColor.fromHex('#000000'),
                ),
                // PEMBUAT
                pw.Text(
                  'DATA PEMBUAT',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Nama',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      namaPembuat,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Jabatan',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      jabatanPembuat,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Alamat',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      alamatPembuat,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Divider(
                  height: 30,
                  thickness: 1,
                  color: PdfColor.fromHex('#000000'),
                ),
                // DATA ACARA
                pw.Text(
                  'DATA ACARA',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Tanggal',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      tanggal,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Waktu',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      waktu,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),

                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Judul',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      title,
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          'Detail',
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      pw.Text(
                        ' : ',
                        style: pw.TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          detail,
                          style: pw.TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ]),
                pw.Divider(
                  height: 30,
                  thickness: 1,
                  color: PdfColor.fromHex('#000000'),
                ),
                pw.Text(
                  'DATA TUGAS DAN PETUGAS',
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
            ...listTask.map((task) {
              return [
                pw.Text(
                  task.title,
                  style: pw.TextStyle(
                    fontSize: 15,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.left,
                ),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Jumlah Petugas',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      '${task.total_worker_now.toString()} Orang',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                pw.Row(children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Data Petugas',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  pw.Text(
                    ' : ',
                    style: pw.TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  pw.Expanded(
                    flex: 3,
                    child: pw.Text(
                      '',
                      style: pw.TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                ]),
                if (task.listPetugas.isNotEmpty)
                  ...task.listPetugas.map((petugas) {
                    if (petugas.status != 1) {
                      return [pw.SizedBox(), pw.SizedBox()];
                    }
                    return [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                          children: [
                            pw.Row(children: [
                              pw.Expanded(
                                child: pw.Text(
                                  'o ',
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Expanded(
                                flex: 10,
                                child: pw.Text(
                                  petugas.dataUser!.full_name,
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                            ]),
                            pw.Row(children: [
                              pw.Expanded(
                                child: pw.Text(
                                  '',
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                    fontWeight: pw.FontWeight.bold,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                              pw.Expanded(
                                flex: 10,
                                child: pw.Text(
                                  petugas.dataUser!.address ?? '',
                                  style: pw.TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: pw.TextAlign.left,
                                ),
                              ),
                            ]),
                          ]),
                      pw.SizedBox(height: 10)
                    ];
                  }).reduce((c, d) => [...c, ...d]),
                pw.SizedBox(height: 15)
              ];
            }).reduce((a, b) => [...a, ...b])
          ];
        },
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
  // ===

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
        user.user_role == Role.Sekretaris)) {
      if (startDate.compareTo(DateTime.now()) > 0) {
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
      } else {
        actionWidget = Row(
          children: [
            GestureDetector(
              onTap: () {
                _createPDF(dataEvent: dataEvent);
              },
              child: Icon(Icons.picture_as_pdf),
            ),
            SB_width15,
          ],
        );
      }
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
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              Text(
                'TANGGAL DAN WAKTU',
                style: smartRTTextTitleCard,
              ),
              SB_height15,
              ListTileData1(txtLeft: 'Tanggal', txtRight: tanggal),
              ListTileData1(txtLeft: 'Waktu', txtRight: waktu),
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
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
              Divider(
                color: smartRTPrimaryColor,
                height: 50,
                thickness: 1,
              ),
              if (isPast && user.user_role == Role.Ketua_RT)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AcaraDokumentasiPage.id,
                          arguments: AcaraDokumentasiPageArgument(
                              dataEventIdx: dataEventIdx));
                    },
                    child: Text(
                      'LIHAT DOKUMENTASI',
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
