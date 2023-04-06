import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/event/event_task_detail.dart';
import 'package:smart_rt/screens/public_screens/acara/tugas/petugas/lihat_petugas_page_rating.dart';
import 'package:smart_rt/utilities/net_util.dart';

class TugasSayaPage extends StatefulWidget {
  static const String id = 'TugasSayaPage';
  const TugasSayaPage({Key? key}) : super(key: key);

  @override
  State<TugasSayaPage> createState() => _TugasSayaPageState();
}

class _TugasSayaPageState extends State<TugasSayaPage> {
  String _waktuSelectedItem = '0';
  List<EventTaskDetail> listTugas = [];
  List<EventTaskDetail> listTugasSemua = [];
  List<EventTaskDetail> listTugasHariIni = [];
  List<EventTaskDetail> listTugasAkanDatang = [];
  List<EventTaskDetail> listTugasTelahBerlalu = [];
  final List<DropdownMenuItem> _waktuItems = [
    const DropdownMenuItem(
      value: '0',
      child: Text('Hari Ini'),
    ),
    const DropdownMenuItem(
      value: '1',
      child: Text('Yang Akan Datang'),
    ),
    const DropdownMenuItem(
      value: '2',
      child: Text('Yang Telah Berlalu'),
    ),
    const DropdownMenuItem(
      value: '3',
      child: Text('Semua'),
    ),
  ];

  void showReason({required EventTaskDetail dataTugas}) {
    String status = '';
    String tugas =
        'tugas ${dataTugas.dataTask!.title} di acara ${dataTugas.dataTask!.dataEvent!.title} tanggal ${DateFormat('d MMMM y HH:mm WIB', 'id_ID').format(dataTugas.dataTask!.dataEvent!.event_date_start_at)}';
    if (dataTugas.status == -3) {
      status = 'dikeluarkan dari $tugas karena ${dataTugas.notes}';
    } else if (dataTugas.status == -2) {
      status = 'ditolak dari $tugas karena slot petugas telah penuh';
    } else if (dataTugas.status == -1) {
      status = 'ditolak dari $tugas karena ${dataTugas.notes}';
    }
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Anda telah $status',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: Text(
              'OK',
              style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void showAcara({required EventTaskDetail dataTugas}) {
    String tugas =
        'tugas ${dataTugas.dataTask!.title} di acara ${dataTugas.dataTask!.dataEvent!.title} tanggal ${DateFormat('d MMMM y HH:mm WIB', 'id_ID').format(dataTugas.dataTask!.dataEvent!.event_date_start_at)}';
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Anda bertugas pada $tugas',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (dataTugas.dataTask!.dataEvent!.event_date_start_at
                      .compareTo(DateTime.now()) <
                  0)
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (dataTugas.rating_avg ?? '0').toString(),
                        textAlign: TextAlign.left,
                      ),
                      SB_width5,
                      Icon(
                        Icons.star,
                        color: smartRTStatusYellowColor,
                        size: 20,
                      ),
                      SB_width5,
                      Text(
                        '|  ${dataTugas.rating_ctr.toString()} penilaian',
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              if (dataTugas.dataTask!.dataEvent!.event_date_start_at
                      .compareTo(DateTime.now()) <
                  0)
                SB_height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (dataTugas.dataTask!.dataEvent!.event_date_start_at
                          .compareTo(DateTime.now()) <
                      0)
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        LihatPetugasPageRatingArgument args =
                            LihatPetugasPageRatingArgument(
                                title:
                                    '${dataTugas.dataUser!.full_name}\n${dataTugas.dataTask!.title}',
                                isPast: true,
                                dataPetugas: dataTugas,
                                dataTugas: dataTugas.dataTask!);
                        Navigator.pushNamed(context, LihatPetugasPageRating.id,
                            arguments: args);
                      },
                      child: Text(
                        'Lihat Penilaian',
                        style: smartRTTextNormal,
                      ),
                    ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: Text(
                      'OK',
                      style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getData() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.get('/event/task/detail/list/get/mine');
    listTugasSemua.addAll((resp.data).map<EventTaskDetail>((request) {
      return EventTaskDetail.fromData(request);
    }));
    debugPrint(listTugasSemua.length.toString());
    getDataFilter();
    listTugas = listTugasHariIni;
    setState(() {});
  }

  void getDataFilter() async {
    for (var i = 0; i < listTugasSemua.length; i++) {
      if (listTugasSemua[i].status == 1) {
        if (listTugasSemua[i]
                .dataTask!
                .dataEvent!
                .event_date_start_at
                .compareTo(DateTime.now()) ==
            0) {
          listTugasHariIni.add(listTugasSemua[i]);
        } else if (listTugasSemua[i]
                .dataTask!
                .dataEvent!
                .event_date_start_at
                .compareTo(DateTime.now()) <
            0) {
          listTugasTelahBerlalu.add(listTugasSemua[i]);
        } else if (listTugasSemua[i]
                .dataTask!
                .dataEvent!
                .event_date_start_at
                .compareTo(DateTime.now()) >
            0) {
          listTugasAkanDatang.add(listTugasSemua[i]);
        }
      }
    }
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
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: paddingScreen.left,
                right: paddingScreen.right,
                top: paddingScreen.top),
            child: Column(
              children: [
                DropdownButtonFormField2(
                  dropdownMaxHeight: 200,
                  value: _waktuItems[0].value,
                  scrollbarRadius: const Radius.circular(40),
                  scrollbarThickness: 6,
                  scrollbarAlwaysShow: true,
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                  items: _waktuItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item.value,
                            enabled: item.enabled,
                            child: item.child,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _waktuSelectedItem = value.toString();
                      if (_waktuSelectedItem == '0') {
                        listTugas = listTugasHariIni;
                      } else if (_waktuSelectedItem == '1') {
                        listTugas = listTugasAkanDatang;
                      } else if (_waktuSelectedItem == '2') {
                        listTugas = listTugasTelahBerlalu;
                      } else if (_waktuSelectedItem == '3') {
                        listTugas = listTugasSemua;
                      }
                    });
                  },
                  onSaved: (value) {
                    _waktuSelectedItem = value.toString();
                  },
                ),
                SB_height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: smartRTStatusGreenColor,
                          shape: BoxShape.circle),
                    ),
                    SB_width5,
                    Text('Aktif'),
                    SB_width15,
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: smartRTStatusYellowColor,
                          shape: BoxShape.circle),
                    ),
                    SB_width5,
                    Text('Request'),
                    SB_width15,
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: smartRTStatusRedColor, shape: BoxShape.circle),
                    ),
                    SB_width5,
                    Text('Dikeluarkan/Ditolak'),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 50,
            thickness: 5,
          ),
          if (listTugas.isEmpty)
            Expanded(
                child: Center(
              child: Text(
                'Tidak ada Tugas',
                style: smartRTTextLarge,
              ),
            )),
          if (listTugas.isNotEmpty)
            Expanded(
              child: Scrollbar(
                child: ListView.separated(
                  separatorBuilder: (context, int) {
                    return Divider(
                      color: smartRTPrimaryColor,
                      height: 5,
                    );
                  },
                  itemCount: listTugas.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: paddingCard,
                      child: GestureDetector(
                        onTap: () {
                          if ((listTugas[index].status < 0)) {
                            showReason(dataTugas: listTugas[index]);
                          } else {
                            showAcara(dataTugas: listTugas[index]);
                          }
                        },
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              color: (listTugas[index].status == 1)
                                  ? smartRTStatusGreenColor
                                  : (listTugas[index].status < 0)
                                      ? smartRTStatusRedColor
                                      : smartRTStatusYellowColor,
                              height: 50,
                            )),
                            SB_width15,
                            Expanded(
                                flex: 15,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      listTugas[index]
                                          .dataTask!
                                          .dataEvent!
                                          .title,
                                      style: smartRTTextTitleCard,
                                    ),
                                    Text(
                                      listTugas[index].dataTask!.title,
                                      style: smartRTTextLarge,
                                    ),
                                    Text(
                                      DateFormat('d MMMM y HH:mm WIB', 'id_ID')
                                          .format(listTugas[index]
                                              .dataTask!
                                              .dataEvent!
                                              .event_date_start_at),
                                      style: smartRTTextLarge,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
