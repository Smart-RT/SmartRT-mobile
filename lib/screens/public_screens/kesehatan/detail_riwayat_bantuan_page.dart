import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/health/health_task_help.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class DetailRiwayatBantuanPageArguments {
  int dataBantuanID;
  String type;
  DetailRiwayatBantuanPageArguments(
      {required this.dataBantuanID, required this.type});
}

class DetailRiwayatBantuanPage extends StatefulWidget {
  static const String id = 'DetailRiwayatBantuanPage';
  DetailRiwayatBantuanPageArguments args;
  DetailRiwayatBantuanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<DetailRiwayatBantuanPage> createState() =>
      _DetailRiwayatBantuanPageState();
}

class _DetailRiwayatBantuanPageState extends State<DetailRiwayatBantuanPage> {
  int? dataBantuanID;
  HealthTaskHelp? dataBantuan;
  User user = AuthProvider.currentUser!;
  final detailPermintaanController = TextEditingController();
  String type = '';
  int statusID = -1;
  String statusName = '';
  Color statusColor = smartRTPrimaryColor;
  String tingkatKepentingan = '';
  String tanggalTerbuat = '';
  String waktuTerbuat = '';
  String tanggalKonfirmasi = '';
  String konfirmasiBy = '';
  String statusKonfirmasi = '';
  String catatanRejected = '';
  String review = '';
  int rating = -1;
  double tempCtrRating = 3;

  void getData() async {
    dataBantuanID = widget.args.dataBantuanID;
    type = widget.args.type;

    Response<dynamic> resp =
        await NetUtil().dioClient.get('/health/healthTaskHelp/$dataBantuanID');
    dataBantuan = HealthTaskHelp.fromData(resp.data);

    statusID = dataBantuan!.status!.id;
    statusName = dataBantuan!.status!.name;
    statusColor = dataBantuan!.status!.color;
    tingkatKepentingan =
        dataBantuan!.urgent_level == 1 ? 'Normal' : 'Butuh Cepat';
    detailPermintaanController.text = dataBantuan!.notes;
    tanggalTerbuat =
        DateFormat('d MMMM y', 'id_ID').format(dataBantuan!.created_at);
    waktuTerbuat = '${DateFormat('HH:mm').format(dataBantuan!.created_at)} WIB';

    if (dataBantuan!.rejected_reason != null) {
      catatanRejected = dataBantuan!.rejected_reason!;
    }

    rating = dataBantuan!.rating ?? -1;
    debugPrint(rating.toString());
    debugPrint(dataBantuan!.rating.toString());
    debugPrint(dataBantuanID.toString());
    review = dataBantuan!.review ?? '';
    setState(() {});
  }

  void updatePermintaanBantuan(
      int statusKode, int idPermintaanBantuan, String alasan) async {
    Response<dynamic> resp =
        await NetUtil().dioClient.patch('/health/healthTaskHelp', data: {
      "status": statusKode,
      "idBantuan": idPermintaanBantuan,
      "alasanPenolakan": alasan
    });
    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);

      RiwayatBantuanArguments argsRiwayatBantuan =
          RiwayatBantuanArguments(type: type);
      Navigator.pushNamed(context, RiwayatBantuanPage.id,
          arguments: argsRiwayatBantuan);

      DetailRiwayatBantuanPageArguments arguments =
          DetailRiwayatBantuanPageArguments(
              dataBantuanID: dataBantuanID!, type: type);
      Navigator.pushNamed(context, DetailRiwayatBantuanPage.id,
          arguments: arguments);
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  void terimaPermintaan() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin menerima permintaan bantuan ini?',
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
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold, color: smartRTErrorColor2),
                ),
              ),
              TextButton(
                onPressed: () {
                  updatePermintaanBantuan(1, dataBantuanID!, '');
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
          'Anda wajib mengisikan alasan penolakan permintaan tersebut',
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
                    updatePermintaanBantuan(
                        -1, dataBantuanID!, _alasanController.text);
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

  void beriPenilaianPopUp() async {
    final _reviewController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Anda dapat memberikan penilaian pada pemberi bantuan untuk meningkatkan performa',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: RatingBar.builder(
                  initialRating: tempCtrRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemPadding: EdgeInsets.all(5),
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    tempCtrRating = rating;
                  },
                ),
              ),
            ],
          ),
          SB_height30,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _reviewController,
              maxLines: 5,
              autocorrect: false,
              style: smartRTTextNormal_Primary,
              decoration: const InputDecoration(
                labelText: 'Review',
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
                  _reviewController.text = '';
                  tempCtrRating = 3;
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
                  if (_reviewController.text == '') {
                    SmartRTSnackbar.show(context,
                        message: 'Review tidak boleh kosong',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    updateKirimPenilaian(_reviewController.text);
                  }
                },
                child: Text(
                  'KIRIM',
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

  void updateKirimPenilaian(String reviewText) async {
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .patch('/health/userReported/rating', data: {
      "idTaskHelp": dataBantuan!.id,
      "rating": tempCtrRating,
      "review": reviewText
    });
    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);

      RiwayatBantuanArguments argsRiwayatBantuan =
          RiwayatBantuanArguments(type: type);
      Navigator.pushNamed(context, RiwayatBantuanPage.id,
          arguments: argsRiwayatBantuan);

      DetailRiwayatBantuanPageArguments arguments =
          DetailRiwayatBantuanPageArguments(
              dataBantuanID: dataBantuanID!, type: type);
      Navigator.pushNamed(context, DetailRiwayatBantuanPage.id,
          arguments: arguments);
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'DETAIL BANTUAN',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        statusName,
                        style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                  catatanRejected != ''
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Alasan Ditolak',
                              style: smartRTTextLarge,
                            ),
                            Text(catatanRejected, style: smartRTTextLarge),
                          ],
                        )
                      : SizedBox(),
                  const Divider(
                    height: 50,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tingkat Kepentingan',
                        style: smartRTTextLarge,
                      ),
                      Text(tingkatKepentingan, style: smartRTTextLarge),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'DETAIL PERMINTAAN',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SB_height5,
                  TextFormField(
                    readOnly: true,
                    controller: detailPermintaanController,
                    autocorrect: false,
                    style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.normal),
                    maxLines: 10,
                  ),
                ],
              ),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal Terbuat',
                        style: smartRTTextLarge,
                      ),
                      Text(tanggalTerbuat, style: smartRTTextLarge),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Waktu Terbuat',
                        style: smartRTTextLarge,
                      ),
                      Text(waktuTerbuat, style: smartRTTextLarge),
                    ],
                  ),
                ],
              ),
              rating != -1
                  ? Column(
                      children: [
                        const Divider(
                          height: 50,
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rating',
                              style: smartRTTextLarge,
                            ),
                            Row(
                              children: [
                                Text('$rating', style: smartRTTextLarge),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Review',
                                style: smartRTTextLarge,
                              ),
                            ),
                            Expanded(
                                child: Text(
                              review,
                              style: smartRTTextLarge,
                              textAlign: TextAlign.right,
                            )),
                          ],
                        ),
                      ],
                    )
                  : SizedBox(),
              const Divider(
                height: 50,
                thickness: 1,
              ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       'Detail Permintaan',
              //       style: smartRTTextNormalBold_Primary,
              //     ),
              //     Text(
              //       detailPermintaan,
              //       style: smartRTTextNormal_Primary,
              //     ),
              //     SB_height30,
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Tanggal Terbuat',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           tanggalTerbuat,
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Dibuat Oleh',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           'Laa',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     SB_height15,
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Tanggal Konfirmasi',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Dikonfirmasi Oleh',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Catatan',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     SB_height15,
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Tanggal Selesai',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Diselesaikan Oleh',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     SB_height15,
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Penilaian',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Ulasan',
              //           style: smartRTTextNormalBold_Primary,
              //         ),
              //         Text(
              //           '-',
              //           style: smartRTTextNormal_Primary,
              //         ),
              //       ],
              //     ),
              //   ],
              // ),

              statusID == 0 && user.id == dataBantuan!.created_by
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          updatePermintaanBantuan(-2, dataBantuanID!, '');
                        },
                        child: Text(
                          'BATALKAN',
                          style: smartRTTextLargeBold_Secondary,
                        ),
                      ),
                    )
                  : const SizedBox(),

              statusID == 2 &&
                      user.id == dataBantuan!.created_by &&
                      dataBantuan!.rating == null
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          beriPenilaianPopUp();
                        },
                        child: Text(
                          'BERI PENILAIAN SEKARANG',
                          style: smartRTTextLargeBold_Secondary,
                        ),
                      ),
                    )
                  : const SizedBox(),

              statusID == 1 &&
                      (user.user_role == Role.Ketua_RT ||
                          user.user_role == Role.Wakil_RT ||
                          user.user_role == Role.Sekretaris)
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          updatePermintaanBantuan(2, dataBantuanID!, '');
                        },
                        child: Text(
                          'SELESAI',
                          style: smartRTTextLargeBold_Secondary,
                        ),
                      ),
                    )
                  : const SizedBox(),

              statusID == 0 &&
                      (user.user_role == Role.Ketua_RT ||
                          user.user_role == Role.Wakil_RT ||
                          user.user_role == Role.Sekretaris)
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
        ),
      ),
    );
  }
}
