import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/committe/committe.dart';
import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/models/voting/voting.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/committe_provider.dart';
import 'package:smart_rt/providers/neighbourhood_head_provider.dart';
import 'package:smart_rt/providers/setting_provider.dart';
import 'package:smart_rt/providers/voting_provider.dart';
import 'package:smart_rt/screens/public_screens/langganan/kelebihan_dan_aturan_langganan_page.dart';
import 'package:smart_rt/screens/public_screens/langganan/langganan_page.dart';
import 'package:smart_rt/screens/public_screens/voting/voting_absensi_page.dart';
import 'package:smart_rt/screens/public_screens/voting/voting_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
import 'package:smart_rt/screens/public_screens/committe/lihat_panitia/lihat_panitia_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/konfirmasi_gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_page.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_semua_kandidat/lihat_semua_kandidat_page.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_status_kandidat_calon_pengurus_rt_saya_page.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/rekomendasikan_kandidat_page.dart';
import 'package:smart_rt/utilities/bool/checker_return_bool.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/widgets/cards/card_big_icon_text_home.dart';
import 'package:smart_rt/widgets/cards/card_icon_with_text.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_button.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/screens/public_screens/committe/lihat_status_kepanitiaan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/committe/rekomendasikan_panitia_page.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_4.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  User user = AuthProvider.currentUser!;
  bool isShowJadwal = false;

  // POLL
  bool isShowPollingCard = false;

  // COMMITTE
  bool isShowWidgetCommitte = false;
  String titleWidgetCommitte = '';
  String detailWidgetCommitte = '';
  String committeTxtBtn1 = '';
  Function() committeFuncBtn1 = () {};

  // PENGURUS RT
  bool isShowWidgetPengurusRT = false;
  String titleWidgetPengurusRT = '';
  String detailWidgetPengurusRT = '';
  String txtBtn1WidgetPengurusRT = '';
  Function() funcBtn1WidgetPengurusRT = () {};

  void acara() async {
    if (user.area == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
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
    } else {
      Navigator.pushNamed(context, AcaraPage.id);
    }
  }

  void janjiTemu() async {
    if (user.area == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
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
    } else {
      Navigator.pushNamed(context, ListJanjiTemuPage.id);
    }
  }

  void administrasi() async {
    if (user.area == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
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
    } else {
      Navigator.pushNamed(context, AdministrationPage.id);
    }
  }

  void arisan() async {
    if (user.area == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
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
    } else {
      Navigator.pushNamed(context, ArisanPage.id);
    }
  }

  void performaSaya() async {
    if (user.area == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
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
    } else {
      // Navigator.pushNamed(context, KesehatankuPage.id);
      // Halaman Performa Saya
    }
  }

  void kesehatan() async {
    if (user.area == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
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
    } else {
      Navigator.pushNamed(context, KesehatankuPage.id);
    }
  }

  void gabungWilayah() async {
    Navigator.pushNamed(context, GabungWilayahPage.id);
  }

  void langgananPro() async {
    if (user.area == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
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
    } else {
      int subscribeAmount = context.read<SettingProvider>().subscribeAmount;
      if (user.area!.is_subscribe_pro == 0) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
              'Hai Sobat Pintar,',
              style: smartRTTextTitleCard,
            ),
            content: Text(
              'Anda belum bergabung menjadi pengguna Smart RT Pro! Apakah anda berminat untuk mendaftar dan bergabung berlangganan untuk dapat mengakses semua fitur?\n\nBiaya Langganan : \n${CurrencyFormat.convertToIdr(subscribeAmount, 2)}/bulan',
              style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ))),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, KelebihanDanAturanLangganan.id);
                    },
                    child: Text(
                      'DAFTAR SEKARANG!',
                      style: smartRTTextLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: smartRTQuaternaryColor),
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.pop(context, 'Batal'),
                  child: Text(
                    'Batal',
                    style: smartRTTextNormal,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        Navigator.pushNamed(context, LanggananPage.id);
      }
    }
  }

  void showVoteDone(String dateTime) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Anda sudah melakukan voting pada tanggal $dateTime !',
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

  void getData() async {
    await context.read<CommitteProvider>().getDataMyCommitteActive();
    await context.read<SettingProvider>().getKarosel();
    if (user.area != null) {
      if (user.is_committe == 0) {
        await context
            .read<NeighbourhoodHeadProvider>()
            .getDataMyNeighbourhoodHeadCandidateThisPeriod(
                periode: user.area!.periode.toString());
      }
      await context
          .read<VotingProvider>()
          .getMyVoteData(periode: user.area!.periode.toString());
    }
  }

// === POLL
  void getDataCardPoll() {
    if (user.area != null) {
      DateTime dateNow = DateTime.now();
      DateTime dateTenureEndMin14Days =
          user.area!.tenure_end_at.add(const Duration(days: -14));
      String dt1 = DateFormat('d MMMM y', 'id_ID').format(dateNow);
      String dt2 =
          DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin14Days);

      if (dt1 == dt2) {
        isShowPollingCard = true;
      }
    }
    setState(() {});
  }
// === END POLL

// === COMMITTE
  /// - Pendaftaran panitia dibuka dateTenureEndMin60Days~dateTenureEndMin45Days
  /// - Widget Card Committe akan muncul dari dateTenureEndMin60Days~dateTenureEnd
  /// - Yang dapat daftar menjadi panitia cuma Role Warga
  /// - Pengurus RT saat ini dapat merekomendasikan

  void showConfirmationDaftarPanitia(Committe data) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin mendaftar sebagai panitia pemilihan pengurus RT?\n\nJika anda menjadi panitia maka anda tidak dapat mencalonkan diri sebagai pengurus RT!',
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
                  Response<dynamic> resp =
                      await NetUtil().dioClient.post('/committe/req/add');
                  Navigator.pop(context);
                  if (resp.statusCode.toString() == '200') {
                    getData();
                    setState(() {});
                    SmartRTSnackbar.show(context,
                        message: resp.data,
                        backgroundColor: smartRTSuccessColor);
                  } else {
                    SmartRTSnackbar.show(context,
                        message: resp.data, backgroundColor: smartRTErrorColor);
                  }
                },
                child: Text(
                  'IYA, DAFTAR!',
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

  bool isShowCommitteCheck() {
    if (user.area != null) {
      DateTime dateTimeNow = DateTime.now();
      DateTime dateTenureEnd = user.area!.tenure_end_at;
      DateTime dateTenureEndMin60Days =
          user.area!.tenure_end_at.add(const Duration(days: -60));

      if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow, dt2: dateTenureEndMin60Days, dt3: dateTenureEnd)) {
        return true;
      }
    }
    return false;
  }

  void getTitleAndDetailWidgetCommitte(Committe data) {
    titleWidgetCommitte = 'PANITIA PEMILIHAN CALON PENGURUS RT!';
    detailWidgetCommitte = '';

    DateTime dateTimeNow = DateTime.now();
    DateTime dateTenureEndMin60Days =
        user.area!.tenure_end_at.add(const Duration(days: -60));
    DateTime dateTenureEndMin45Days =
        user.area!.tenure_end_at.add(const Duration(days: -45));

    if (data.id == -1 &&
        user.user_role == Role.Warga &&
        CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow,
          dt2: dateTenureEndMin60Days,
          dt3: dateTenureEndMin45Days,
        )) {
      detailWidgetCommitte =
          'Daftarkan dirimu menjadi panitia pemilihan pengurus RT untuk menyeleksi hingga membantu keberlangsungan acara!\n\n*Catatan : \nAnda tidak dapat mencalonkan diri menjadi pengurus RT ketika anda menjadi panitia!\n\nPendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin60Days)} dan batas akhir pendaftaran Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin45Days)} !';
    } else {
      detailWidgetCommitte =
          'Pendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin60Days)} dan batas akhir pendaftaran Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin45Days)} !';
    }
  }

  void getDataCommitteBtn1(Committe data) {
    DateTime dateTimeNow = DateTime.now();
    DateTime dateTenureEndMin60Days =
        user.area!.tenure_end_at.add(const Duration(days: -60));
    DateTime dateTenureEndMin45Days =
        user.area!.tenure_end_at.add(const Duration(days: -45));

    if (user.user_role == Role.Warga) {
      if (data.status >= -1) {
        committeTxtBtn1 = 'LIHAT STATUS SAYA';
        committeFuncBtn1 = () {
          Navigator.pushNamed(context, LihatStatusKepanitiaanSayaPage.id);
        };
      } else if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
        dt1: dateTimeNow,
        dt2: dateTenureEndMin60Days,
        dt3: dateTenureEndMin45Days,
      )) {
        committeTxtBtn1 = 'DAFTAR SEKARANG';
        committeFuncBtn1 = () {
          String tahunSekarang = DateFormat('y').format(DateTime.now());
          String tahunLahir = DateFormat('y').format(user.born_date!);
          int umur = int.parse(tahunSekarang) - int.parse(tahunLahir);
          if (user.user_role == Role.Warga && umur >= 17) {
            showConfirmationDaftarPanitia(data);
          }
        };
      }
    } else if ((user.user_role == Role.Ketua_RT ||
            user.user_role == Role.Wakil_RT ||
            user.user_role == Role.Sekretaris ||
            user.user_role == Role.Bendahara) &&
        (CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow,
          dt2: dateTenureEndMin60Days,
          dt3: dateTenureEndMin45Days,
        ))) {
      committeTxtBtn1 = 'REKOMENDASIKAN PANITIA';
      committeFuncBtn1 = () {
        Navigator.pushNamed(context, RekomendasikanPanitiaPage.id);
      };
    }
  }

  void getDataWidgetCommitte({required Committe data}) async {
    isShowWidgetCommitte = isShowCommitteCheck();

    if (isShowWidgetCommitte) {
      getTitleAndDetailWidgetCommitte(data);
      getDataCommitteBtn1(data);
      setState(() {});
    }
  }
// === END COMMITTE

// === PENGURUS RT
  /// - Pendaftaran pengurus RT dibuka dateTenureEndMin44Days~dateTenureEndMin30Days
  /// - Widget Card Kandidat Pengurus RT akan muncul dari dateTenureEndMin44Days~dateTenureEnd
  /// - Yang dapat daftar menjadi kandidat pengurus RT cuma yang bukan panitia
  void showConfirmationDaftarCalonPengurusRT() {
    final _visiController = TextEditingController();
    final _misiController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin mendaftar sebagai calon Pengurus RT?\nJika anda yakin, anda wajib mengisikan visi misi anda sebagai Pengurus RT!',
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
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text('Tidak', style: smartRTTextNormal),
              ),
              TextButton(
                onPressed: () async {
                  daftarCalonPengurusRT(
                      visi: _visiController.text, misi: _misiController.text);
                },
                child: Text(
                  'IYA, DAFTAR!',
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

  void daftarCalonPengurusRT(
      {required String visi, required String misi}) async {
    int periode = user.area!.periode;
    Response<dynamic> resp = await NetUtil().dioClient.post(
        '/neighbourhood-head/add',
        data: {"visi": visi, "misi": misi, "periode": periode});
    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);
      getData();
      setState(() {});
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  bool isShowWidgetPengurusRTCheck() {
    if (user.area != null) {
      DateTime dateTimeNow = DateTime.now();
      DateTime dateTenureEnd = user.area!.tenure_end_at;
      DateTime dateTenureEndMin44Days =
          user.area!.tenure_end_at.add(const Duration(days: -44));

      if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow, dt2: dateTenureEndMin44Days, dt3: dateTenureEnd)) {
        return true;
      }
    }
    return false;
  }

  void getTitleAndDetailWidgetPengurusRT(
      {required NeighbourhoodHeadCandidate data}) {
    titleWidgetPengurusRT = 'KANDIDAT CALON PENGURUS RT';
    detailWidgetPengurusRT = '';

    DateTime dateTimeNow = DateTime.now();
    DateTime dateTenureEndMin44Days =
        user.area!.tenure_end_at.add(const Duration(days: -44));
    DateTime dateTenureEndMin30Days =
        user.area!.tenure_end_at.add(const Duration(days: -30));
    DateTime dateTenureEndMin29Days =
        user.area!.tenure_end_at.add(const Duration(days: -29));
    DateTime dateTenureEndMin15Days =
        user.area!.tenure_end_at.add(const Duration(days: -15));

    if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow,
          dt2: dateTenureEndMin44Days,
          dt3: dateTenureEndMin30Days,
        ) &&
        user.is_committe == 0 &&
        data.status == -99) {
      detailWidgetPengurusRT =
          'Daftarkan dirimu menjadi Kandidat calon pengurus RT!\n\nPendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin44Days)} dan batas akhir bergabung dalam Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin30Days)} !';
    } else {
      detailWidgetPengurusRT =
          'Pendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin44Days)} dan batas akhir bergabung menjadi Kandidat Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin30Days)} !\n\nKampanye dapat dilaksanakan pada tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin29Days)} hingga ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin15Days)} !';
    }
  }

  void getBtn1WidgetPengurusRT({required NeighbourhoodHeadCandidate data}) {
    DateTime dateTimeNow = DateTime.now();
    DateTime dateTenureEndMin44Days =
        user.area!.tenure_end_at.add(const Duration(days: -44));
    DateTime dateTenureEndMin30Days =
        user.area!.tenure_end_at.add(const Duration(days: -30));

    if (user.is_committe == 0) {
      if (data.status != -99) {
        txtBtn1WidgetPengurusRT = 'LIHAT STATUS SAYA';
        funcBtn1WidgetPengurusRT = () {
          Navigator.pushNamed(
              context, LihatStatusKandidatCalonPengurusRTSayaPage.id);
        };
      } else if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
        dt1: dateTimeNow,
        dt2: dateTenureEndMin44Days,
        dt3: dateTenureEndMin30Days,
      )) {
        txtBtn1WidgetPengurusRT = 'DAFTAR SEKARANG';
        funcBtn1WidgetPengurusRT = () {
          String tahunSekarang = DateFormat('y').format(DateTime.now());
          String tahunLahir = DateFormat('y').format(user.born_date!);
          int umur = int.parse(tahunSekarang) - int.parse(tahunLahir);
          if (umur >= 17) {
            showConfirmationDaftarCalonPengurusRT();
          }
        };
      }
    } else {
      if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
        dt1: dateTimeNow,
        dt2: dateTenureEndMin44Days,
        dt3: dateTenureEndMin30Days,
      )) {
        txtBtn1WidgetPengurusRT = 'REKOMENDASIKAN\nCALON PENGURUS RT';
        funcBtn1WidgetPengurusRT = () {
          Navigator.pushNamed(context, RekomendasikanKandidatPage.id);
        };
      }
    }
  }

  void getDataWidgetPengurusRT(
      {required NeighbourhoodHeadCandidate data}) async {
    isShowWidgetPengurusRT = isShowWidgetPengurusRTCheck();
    if (isShowWidgetPengurusRT) {
      getTitleAndDetailWidgetPengurusRT(data: data);
      getBtn1WidgetPengurusRT(data: data);
    }
    setState(() {});
  }

// === END PENGURUS RT

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    Committe dataMyCommitteActive =
        context.watch<CommitteProvider>().dataMyCommitteActive;
    getDataWidgetCommitte(data: dataMyCommitteActive);
    NeighbourhoodHeadCandidate dataSayaSebagaiKandidatPengurusRTSekarang =
        context
            .watch<NeighbourhoodHeadProvider>()
            .dataSayaSebagaiKandidatPengurusRTSekarang;
    getDataWidgetPengurusRT(data: dataSayaSebagaiKandidatPengurusRTSekarang);

    Voting myVoteData = context.watch<VotingProvider>().myVoteData;
    debugPrint("myVoteData.id.toString()");
    debugPrint(myVoteData.id.toString());
    getDataCardPoll();

    String _dateTenureEndMin60DaysString = '';
    String _dateTenureEndMin45DaysString = '';
    String _dateTenureEndMin44DaysString = '';
    String _dateTenureEndMin30DaysString = '';
    String _dateTenureEndMin29DaysString = '';
    String _dateTenureEndMin15DaysString = '';
    String _dateTenureEndMin14DaysString = '';
    String _dateTenureEndMin13DaysString = '';
    String _dateTenureEndString = '';

    if (user.area != null) {
      DateTime _dateTenureEndMin60Days =
          user.area!.tenure_end_at.add(const Duration(days: -60));
      DateTime _dateTenureEndMin45Days =
          user.area!.tenure_end_at.add(const Duration(days: -45));
      DateTime _dateTenureEndMin44Days =
          user.area!.tenure_end_at.add(const Duration(days: -44));
      DateTime _dateTenureEndMin30Days =
          user.area!.tenure_end_at.add(const Duration(days: -30));
      DateTime _dateTenureEndMin29Days =
          user.area!.tenure_end_at.add(const Duration(days: -29));
      DateTime _dateTenureEndMin15Days =
          user.area!.tenure_end_at.add(const Duration(days: -15));
      DateTime _dateTenureEndMin14Days =
          user.area!.tenure_end_at.add(const Duration(days: -14));
      DateTime _dateTenureEndMin13Days =
          user.area!.tenure_end_at.add(const Duration(days: -13));
      DateTime _dateTenureEnd = user.area!.tenure_end_at;

      _dateTenureEndMin60DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin60Days);
      _dateTenureEndMin45DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin45Days);
      _dateTenureEndMin44DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin44Days);
      _dateTenureEndMin30DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin30Days);
      _dateTenureEndMin29DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin29Days);
      _dateTenureEndMin15DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin15Days);
      _dateTenureEndMin14DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin14Days);
      _dateTenureEndMin13DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin13Days);
      _dateTenureEndString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEnd);
    }

    List<Map<String, dynamic>> karosel =
        context.watch<SettingProvider>().karosel;

    List<String> list = [
      'assets/img/carousel/1.png',
      'assets/img/carousel/2.png',
      'assets/img/carousel/3.png',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              CarouselSlider(
                  options: CarouselOptions(autoPlay: true, viewportFraction: 1),
                  items: karosel
                      .map((item) => Container(
                            child: Image.network(
                              '${backendURL}/public/uploads/carousel-home/${item["detail"]}',
                              fit: BoxFit.fitWidth,
                            ),
                          ))
                      .toList()
                  // items: list
                  //     .map((item) => Container(
                  //           child: Image.asset(
                  //             item,
                  //             fit: BoxFit.fitWidth,
                  //           ),
                  //         ))
                  //     .toList(),
                  ),
              Divider(
                color: smartRTPrimaryColor,
                thickness: 10,
                height: 0,
              ),
              Padding(
                padding: paddingScreen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Text(
                    //   'Halo,',
                    //   style: smartRTTextTitleCard,
                    // ),
                    // Text(
                    //   StringFormat.convertMax2Words(user.full_name),
                    //   style: smartRTTextTitle,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    // Text(
                    //   '${user.is_committe == 1 ? 'Panitia Pemilihan Calon Pengurus RT\n' : ''}${user.user_role.name.replaceAll("_", " ")}',
                    //   style: smartRTTextLarge,
                    // ),
                    // SB_height30,

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CardIconWithText(
                                icon: Icons.calendar_month,
                                iconColor: smartRTPrimaryColor,
                                title: 'Acara',
                                onTap: () async {
                                  acara();
                                },
                              ),
                            ),
                            Expanded(
                              child: CardIconWithText(
                                icon: Icons.handshake,
                                iconColor: smartRTPrimaryColor,
                                title: 'Janji Temu',
                                onTap: () async {
                                  janjiTemu();
                                },
                              ),
                            ),
                            Expanded(
                              child: CardIconWithText(
                                icon: Icons.article,
                                iconColor: smartRTPrimaryColor,
                                title: 'ADM',
                                onTap: () async {
                                  administrasi();
                                },
                              ),
                            ),
                            Expanded(
                              child: CardIconWithText(
                                icon: Icons.group,
                                iconColor: smartRTPrimaryColor,
                                title: 'Arisan',
                                onTap: () async {
                                  arisan();
                                },
                              ),
                            ),
                          ],
                        ),
                        SB_height15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CardIconWithText(
                                icon: Icons.analytics,
                                iconColor: smartRTPrimaryColor,
                                title: 'Performa Saya',
                                onTap: () async {
                                  performaSaya();
                                },
                              ),
                            ),
                            Expanded(
                              child: CardIconWithText(
                                icon: Icons.health_and_safety,
                                iconColor: smartRTPrimaryColor,
                                title: 'Kesehatan',
                                onTap: () async {
                                  kesehatan();
                                },
                              ),
                            ),
                            Expanded(
                              child: CardIconWithText(
                                icon: Icons.diamond,
                                iconColor: smartRTPrimaryColor,
                                title: 'Langganan Pro',
                                onTap: () async {
                                  langgananPro();
                                },
                              ),
                            ),
                            Expanded(
                              child: CardIconWithText(
                                icon: Icons.question_mark,
                                iconColor: smartRTPrimaryColor,
                                title: 'Pusat Bantuan',
                                onTap: () async {
                                  ApplicationProvider.showNotification(
                                      hashCode: 1,
                                      notificationBody: "Test VBoasdas",
                                      notificationTitle: "ASDASD");
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (user.user_role == Role.Ketua_RT ||
                        user.user_role == Role.Guest)
                      SB_height30,
                    if (user.user_role == Role.Ketua_RT)
                      Row(
                        children: [
                          CardBigIconAndText(
                            icon: Icons.domain_add,
                            title: 'Konfirmasi Gabung Wilayah',
                            onTap: () async {
                              Navigator.pushNamed(
                                  context, KonfirmasiGabungWilayahPage.id);
                            },
                          ),
                        ],
                      ),
                    if (user.user_role == Role.Guest)
                      Row(
                        children: [
                          CardBigIconAndText(
                            icon: Icons.domain_add,
                            title: 'Gabung Wilayah',
                            onTap: () async {
                              gabungWilayah();
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: smartRTPrimaryColor,
            thickness: 10,
            height: 0,
          ),
          Column(
            children: [
              Container(
                padding: paddingCard,
                color: smartRTActiveColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SEBENTAR LAGI !',
                                style: smartRTTextLarge.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              SB_height5,
                              Text(
                                'SAATNYA UNTUK PERGANTIAN PENGURUS RT',
                                style: smartRTTextNormal,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Lottie.asset(
                              'assets/lotties/decoration/team-jump.json',
                              fit: BoxFit.fitWidth),
                        ),
                      ],
                    ),
                    SB_height15,
                    if (isShowJadwal)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'JADWAL',
                            style: smartRTTextLarge.copyWith(
                                fontWeight: FontWeight.bold, letterSpacing: 5),
                          ),
                          Divider(thickness: 2, color: smartRTSecondaryColor),
                          SB_height5,
                          ListTileData4(
                              title: 'Pendaftaran Panitia',
                              subTitle:
                                  '$_dateTenureEndMin60DaysString - $_dateTenureEndMin45DaysString'),
                          ListTileData4(
                              title: 'Pendaftaran Calon Pengurus RT',
                              subTitle:
                                  '$_dateTenureEndMin44DaysString - $_dateTenureEndMin30DaysString'),
                          ListTileData4(
                              title: 'Seleksi dan Kampanye',
                              subTitle:
                                  '$_dateTenureEndMin29DaysString - $_dateTenureEndMin15DaysString'),
                          ListTileData4(
                              title: 'Pemilihan Pengurus RT Baru',
                              subTitle: _dateTenureEndMin14DaysString),
                          ListTileData4(
                              title: 'Pengumuman Pengurus RT Baru',
                              subTitle: _dateTenureEndMin13DaysString),
                          ListTileData4(
                              title: 'Pergantian Jabatan',
                              subTitle: _dateTenureEndString),
                        ],
                      ),
                    if (isShowJadwal) SB_height15,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (isShowJadwal) {
                            isShowJadwal = false;
                          } else {
                            isShowJadwal = true;
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (isShowJadwal) ? 'TUTUP JADWAL' : 'LIHAT JADWAL',
                            style: smartRTTextSmall.copyWith(
                                color: smartRTTertiaryColor),
                          ),
                          Icon(
                              (isShowJadwal)
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              color: smartRTTertiaryColor)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SB_height5,
              SB_height5,
            ],
          ),
          if (isShowPollingCard)
            Divider(
              color: smartRTPrimaryColor,
              thickness: 10,
              height: 0,
            ),
          if (isShowPollingCard)
            Column(
              children: [
                Container(
                  padding: paddingCard,
                  color: smartRTActiveColor,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Lottie.asset(
                                'assets/lotties/decoration/vote.json',
                                fit: BoxFit.fitWidth),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'WAKTUNYA TIBA !',
                                  style: smartRTTextLarge.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                SB_height5,
                                Text(
                                  'YUK VOTING KANDIDAT PENGURUS RT SEKARANG !',
                                  style: smartRTTextNormal,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, VotingAbsensiPage.id);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'LIHAT ABSENSI',
                              style: smartRTTextSmall.copyWith(
                                  color: smartRTTertiaryColor),
                            ),
                            Icon(Icons.keyboard_arrow_right,
                                color: smartRTTertiaryColor)
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (myVoteData.id == -1) {
                            Navigator.pushNamed(context, VotingPage1.id);
                          } else {
                            String dateTime =
                                DateFormat('d MMMM y HH:mm', 'id_ID')
                                    .format(myVoteData.created_at);
                            showVoteDone(dateTime);
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'VOTING SEKARANG',
                              style: smartRTTextSmall.copyWith(
                                  color: smartRTTertiaryColor),
                            ),
                            Icon(Icons.keyboard_arrow_right,
                                color: smartRTTertiaryColor)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SB_height5,
                SB_height5,
              ],
            ),
          if (isShowWidgetCommitte)
            Divider(
              color: smartRTPrimaryColor,
              thickness: 10,
              height: 0,
            ),
          if (isShowWidgetCommitte)
            Padding(
              padding: paddingScreen,
              child: CardListTileWithButton(
                title: titleWidgetCommitte,
                subtitle: detailWidgetCommitte,
                buttonText: committeTxtBtn1,
                onTapButton: committeFuncBtn1,
                buttonText2: 'LIHAT PANITIA',
                onTapButton2: () {
                  Navigator.pushNamed(context, LihatPanitiaPage.id);
                },
              ),
            ),
          if (isShowWidgetPengurusRT)
            Divider(
              color: smartRTPrimaryColor,
              thickness: 10,
              height: 0,
            ),
          if (isShowWidgetPengurusRT)
            Padding(
              padding: paddingScreen,
              child: CardListTileWithButton(
                title: titleWidgetPengurusRT,
                subtitle: detailWidgetPengurusRT,
                buttonText: txtBtn1WidgetPengurusRT,
                onTapButton: funcBtn1WidgetPengurusRT,
                buttonText2: 'LIHAT SEMUA KANDIDAT',
                onTapButton2: () {
                  Navigator.pushNamed(context, LihatSemuaKandidatPage.id);
                },
              ),
            ),
        ],
      ),
    );
  }
}


/**
 * 
 * import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/committe/committe.dart';
import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/committe_provider.dart';
import 'package:smart_rt/providers/neighbourhood_head_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
import 'package:smart_rt/screens/public_screens/committe/lihat_panitia/lihat_panitia_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/gabung_wilayah/konfirmasi_gabung_wilayah_page.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
import 'package:smart_rt/screens/public_screens/acara/acara_page.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_semua_kandidat/lihat_semua_kandidat_page.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_status_kandidat_calon_pengurus_rt_saya_page.dart';
import 'package:smart_rt/screens/public_screens/neighbourhood_head/rekomendasikan_kandidat_page.dart';
import 'package:smart_rt/utilities/bool/checker_return_bool.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/cards/card_big_icon_text_home.dart';
import 'package:smart_rt/widgets/cards/card_icon_with_text.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_button.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/screens/public_screens/committe/lihat_status_kepanitiaan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/committe/rekomendasikan_panitia_page.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_4.dart';

class BerandaPage extends StatefulWidget {
  const BerandaPage({super.key});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  User user = AuthProvider.currentUser!;
  bool isShowJadwal = false;

  // COMMITTE
  bool isShowWidgetCommitte = false;
  String titleWidgetCommitte = '';
  String detailWidgetCommitte = '';
  String committeTxtBtn1 = '';
  Function() committeFuncBtn1 = () {};

  // PENGURUS RT
  bool isShowWidgetPengurusRT = false;
  String titleWidgetPengurusRT = '';
  String detailWidgetPengurusRT = '';
  String txtBtn1WidgetPengurusRT = '';
  Function() funcBtn1WidgetPengurusRT = () {};

  void acara() async {
    Navigator.pushNamed(context, AcaraPage.id);
  }

  void janjiTemu() async {
    Navigator.pushNamed(context, ListJanjiTemuPage.id);
  }

  void administrasi() async {
    Navigator.pushNamed(context, AdministrationPage.id);
  }

  void arisan() async {
    if (user.area == null) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Hai Sobat Pintar,',
            style: smartRTTextTitleCard,
          ),
          content: Text(
            'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
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
    } else {
      Navigator.pushNamed(context, ArisanPage.id);
    }
  }

  void performaSaya() async {}
  void kesehatan() async {
    Navigator.pushNamed(context, KesehatankuPage.id);
  }

  void gabungWilayah() async {
    Navigator.pushNamed(context, GabungWilayahPage.id);
  }

  void getData() async {
    await context.read<CommitteProvider>().getDataMyCommitteActive();

    if (user.area != null && user.is_committe == 0) {
      await context
          .read<NeighbourhoodHeadProvider>()
          .getDataMyNeighbourhoodHeadCandidateThisPeriod(
              periode: user.area!.periode.toString());
    }
  }

// === COMMITTE
  /// - Pendaftaran panitia dibuka dateTenureEndMin60Days~dateTenureEndMin45Days
  /// - Widget Card Committe akan muncul dari dateTenureEndMin60Days~dateTenureEnd
  /// - Yang dapat daftar menjadi panitia cuma Role Warga
  /// - Pengurus RT saat ini dapat merekomendasikan

  void showConfirmationDaftarPanitia(Committe data) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin mendaftar sebagai panitia pemilihan pengurus RT?\n\nJika anda menjadi panitia maka anda tidak dapat mencalonkan diri sebagai pengurus RT!',
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
                  Response<dynamic> resp =
                      await NetUtil().dioClient.post('/committe/req/add');
                  Navigator.pop(context);
                  if (resp.statusCode.toString() == '200') {
                    getData();
                    setState(() {});
                    SmartRTSnackbar.show(context,
                        message: resp.data,
                        backgroundColor: smartRTSuccessColor);
                  } else {
                    SmartRTSnackbar.show(context,
                        message: resp.data, backgroundColor: smartRTErrorColor);
                  }
                },
                child: Text(
                  'IYA, DAFTAR!',
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

  bool isShowCommitteCheck() {
    if (user.area != null) {
      DateTime dateTimeNow = DateTime.now();
      DateTime dateTenureEnd = user.area!.tenure_end_at;
      DateTime dateTenureEndMin60Days =
          user.area!.tenure_end_at.add(const Duration(days: -60));

      if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow, dt2: dateTenureEndMin60Days, dt3: dateTenureEnd)) {
        return true;
      }
    }
    return false;
  }

  void getTitleAndDetailWidgetCommitte(Committe data) {
    titleWidgetCommitte = 'PANITIA PEMILIHAN CALON PENGURUS RT!';
    detailWidgetCommitte = '';

    DateTime dateTimeNow = DateTime.now();
    DateTime dateTenureEndMin60Days =
        user.area!.tenure_end_at.add(const Duration(days: -60));
    DateTime dateTenureEndMin45Days =
        user.area!.tenure_end_at.add(const Duration(days: -45));

    if (data.id == -1 &&
        user.user_role == Role.Warga &&
        CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow,
          dt2: dateTenureEndMin60Days,
          dt3: dateTenureEndMin45Days,
        )) {
      detailWidgetCommitte =
          'Daftarkan dirimu menjadi panitia pemilihan pengurus RT untuk menyeleksi hingga membantu keberlangsungan acara!\n\n*Catatan : \nAnda tidak dapat mencalonkan diri menjadi pengurus RT ketika anda menjadi panitia!\n\nPendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin60Days)} dan batas akhir pendaftaran Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin45Days)} !';
    } else {
      detailWidgetCommitte =
          'Pendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin60Days)} dan batas akhir pendaftaran Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin45Days)} !';
    }
  }

  void getDataCommitteBtn1(Committe data) {
    DateTime dateTimeNow = DateTime.now();
    DateTime dateTenureEndMin60Days =
        user.area!.tenure_end_at.add(const Duration(days: -60));
    DateTime dateTenureEndMin45Days =
        user.area!.tenure_end_at.add(const Duration(days: -45));

    if (user.user_role == Role.Warga) {
      if (data.status >= -1) {
        committeTxtBtn1 = 'LIHAT STATUS SAYA';
        committeFuncBtn1 = () {
          Navigator.pushNamed(context, LihatStatusKepanitiaanSayaPage.id);
        };
      } else if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
        dt1: dateTimeNow,
        dt2: dateTenureEndMin60Days,
        dt3: dateTenureEndMin45Days,
      )) {
        committeTxtBtn1 = 'DAFTAR SEKARANG';
        committeFuncBtn1 = () {
          String tahunSekarang = DateFormat('y').format(DateTime.now());
          String tahunLahir = DateFormat('y').format(user.born_date!);
          int umur = int.parse(tahunSekarang) - int.parse(tahunLahir);
          if (user.user_role == Role.Warga && umur >= 17) {
            showConfirmationDaftarPanitia(data);
          }
        };
      }
    } else if ((user.user_role == Role.Ketua_RT ||
            user.user_role == Role.Wakil_RT ||
            user.user_role == Role.Sekretaris ||
            user.user_role == Role.Bendahara) &&
        (CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow,
          dt2: dateTenureEndMin60Days,
          dt3: dateTenureEndMin45Days,
        ))) {
      committeTxtBtn1 = 'REKOMENDASIKAN PANITIA';
      committeFuncBtn1 = () {
        Navigator.pushNamed(context, RekomendasikanPanitiaPage.id);
      };
    }
  }

  void getDataWidgetCommitte({required Committe data}) async {
    isShowWidgetCommitte = isShowCommitteCheck();

    if (isShowWidgetCommitte) {
      getTitleAndDetailWidgetCommitte(data);
      getDataCommitteBtn1(data);
      setState(() {});
    }
  }
// === END COMMITTE

// === PENGURUS RT
  /// - Pendaftaran pengurus RT dibuka dateTenureEndMin44Days~dateTenureEndMin30Days
  /// - Widget Card Kandidat Pengurus RT akan muncul dari dateTenureEndMin44Days~dateTenureEnd
  /// - Yang dapat daftar menjadi kandidat pengurus RT cuma yang bukan panitia
  void showConfirmationDaftarCalonPengurusRT() {
    final _visiController = TextEditingController();
    final _misiController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin mendaftar sebagai calon Pengurus RT?\nJika anda yakin, anda wajib mengisikan visi misi anda sebagai Pengurus RT!',
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
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text('Tidak', style: smartRTTextNormal),
              ),
              TextButton(
                onPressed: () async {
                  daftarCalonPengurusRT(
                      visi: _visiController.text, misi: _misiController.text);
                },
                child: Text(
                  'IYA, DAFTAR!',
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

  void daftarCalonPengurusRT(
      {required String visi, required String misi}) async {
    int periode = user.area!.periode;
    Response<dynamic> resp = await NetUtil().dioClient.post(
        '/neighbourhood-head/add',
        data: {"visi": visi, "misi": misi, "periode": periode});
    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);
      getData();
      setState(() {});
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  bool isShowWidgetPengurusRTCheck() {
    if (user.area != null) {
      DateTime dateTimeNow = DateTime.now();
      DateTime dateTenureEnd = user.area!.tenure_end_at;
      DateTime dateTenureEndMin44Days =
          user.area!.tenure_end_at.add(const Duration(days: -44));

      if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow, dt2: dateTenureEndMin44Days, dt3: dateTenureEnd)) {
        return true;
      }
    }
    return false;
  }

  void getTitleAndDetailWidgetPengurusRT(
      {required NeighbourhoodHeadCandidate data}) {
    titleWidgetPengurusRT = 'KANDIDAT CALON PENGURUS RT';
    detailWidgetPengurusRT = '';

    DateTime dateTimeNow = DateTime.now();
    DateTime dateTenureEndMin44Days =
        user.area!.tenure_end_at.add(const Duration(days: -44));
    DateTime dateTenureEndMin30Days =
        user.area!.tenure_end_at.add(const Duration(days: -30));
    DateTime dateTenureEndMin29Days =
        user.area!.tenure_end_at.add(const Duration(days: -29));
    DateTime dateTenureEndMin15Days =
        user.area!.tenure_end_at.add(const Duration(days: -15));

    if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
          dt1: dateTimeNow,
          dt2: dateTenureEndMin44Days,
          dt3: dateTenureEndMin30Days,
        ) &&
        user.is_committe == 0 &&
        data.status == -99) {
      detailWidgetPengurusRT =
          'Daftarkan dirimu menjadi Kandidat calon pengurus RT!\n\nPendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin44Days)} dan batas akhir bergabung dalam Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin30Days)} !';
    } else {
      detailWidgetPengurusRT =
          'Pendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin44Days)} dan batas akhir bergabung menjadi Kandidat Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin30Days)} !\n\nKampanye dapat dilaksanakan pada tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin29Days)} hingga ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin15Days)} !';
    }
  }

  void getBtn1WidgetPengurusRT({required NeighbourhoodHeadCandidate data}) {
    DateTime dateTimeNow = DateTime.now();
    DateTime dateTenureEndMin44Days =
        user.area!.tenure_end_at.add(const Duration(days: -44));
    DateTime dateTenureEndMin30Days =
        user.area!.tenure_end_at.add(const Duration(days: -30));

    if (user.is_committe == 0) {
      if (data.status != -99) {
        txtBtn1WidgetPengurusRT = 'LIHAT STATUS SAYA';
        funcBtn1WidgetPengurusRT = () {
          Navigator.pushNamed(
              context, LihatStatusKandidatCalonPengurusRTSayaPage.id);
        };
      } else if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
        dt1: dateTimeNow,
        dt2: dateTenureEndMin44Days,
        dt3: dateTenureEndMin30Days,
      )) {
        txtBtn1WidgetPengurusRT = 'DAFTAR SEKARANG';
        funcBtn1WidgetPengurusRT = () {
          String tahunSekarang = DateFormat('y').format(DateTime.now());
          String tahunLahir = DateFormat('y').format(user.born_date!);
          int umur = int.parse(tahunSekarang) - int.parse(tahunLahir);
          if (umur >= 17) {
            showConfirmationDaftarCalonPengurusRT();
          }
        };
      }
    } else {
      if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
        dt1: dateTimeNow,
        dt2: dateTenureEndMin44Days,
        dt3: dateTenureEndMin30Days,
      )) {
        txtBtn1WidgetPengurusRT = 'REKOMENDASIKAN\nCALON PENGURUS RT';
        funcBtn1WidgetPengurusRT = () {
          Navigator.pushNamed(context, RekomendasikanKandidatPage.id);
        };
      }
    }
  }

  void getDataWidgetPengurusRT(
      {required NeighbourhoodHeadCandidate data}) async {
    isShowWidgetPengurusRT = isShowWidgetPengurusRTCheck();
    if (isShowWidgetPengurusRT) {
      getTitleAndDetailWidgetPengurusRT(data: data);
      getBtn1WidgetPengurusRT(data: data);
    }
    setState(() {});
  }

// === END PENGURUS RT

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    Committe dataMyCommitteActive =
        context.watch<CommitteProvider>().dataMyCommitteActive;
    getDataWidgetCommitte(data: dataMyCommitteActive);
    NeighbourhoodHeadCandidate dataSayaSebagaiKandidatPengurusRTSekarang =
        context
            .watch<NeighbourhoodHeadProvider>()
            .dataSayaSebagaiKandidatPengurusRTSekarang;
    getDataWidgetPengurusRT(data: dataSayaSebagaiKandidatPengurusRTSekarang);

    String _dateTenureEndMin60DaysString = '';
    String _dateTenureEndMin45DaysString = '';
    String _dateTenureEndMin44DaysString = '';
    String _dateTenureEndMin30DaysString = '';
    String _dateTenureEndMin29DaysString = '';
    String _dateTenureEndMin15DaysString = '';
    String _dateTenureEndMin14DaysString = '';
    String _dateTenureEndMin13DaysString = '';
    String _dateTenureEndString = '';

    if (user.area != null) {
      DateTime _dateTenureEndMin60Days =
          user.area!.tenure_end_at.add(const Duration(days: -60));
      DateTime _dateTenureEndMin45Days =
          user.area!.tenure_end_at.add(const Duration(days: -45));
      DateTime _dateTenureEndMin44Days =
          user.area!.tenure_end_at.add(const Duration(days: -44));
      DateTime _dateTenureEndMin30Days =
          user.area!.tenure_end_at.add(const Duration(days: -30));
      DateTime _dateTenureEndMin29Days =
          user.area!.tenure_end_at.add(const Duration(days: -29));
      DateTime _dateTenureEndMin15Days =
          user.area!.tenure_end_at.add(const Duration(days: -15));
      DateTime _dateTenureEndMin14Days =
          user.area!.tenure_end_at.add(const Duration(days: -14));
      DateTime _dateTenureEndMin13Days =
          user.area!.tenure_end_at.add(const Duration(days: -13));
      DateTime _dateTenureEnd = user.area!.tenure_end_at;

      _dateTenureEndMin60DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin60Days);
      _dateTenureEndMin45DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin45Days);
      _dateTenureEndMin44DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin44Days);
      _dateTenureEndMin30DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin30Days);
      _dateTenureEndMin29DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin29Days);
      _dateTenureEndMin15DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin15Days);
      _dateTenureEndMin14DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin14Days);
      _dateTenureEndMin13DaysString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin13Days);
      _dateTenureEndString =
          DateFormat('d MMMM y', 'id_ID').format(_dateTenureEnd);
    }

    return SingleChildScrollView(
      child: Padding(
        padding: paddingScreen,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Halo,',
              style: smartRTTextTitleCard,
            ),
            Text(
              StringFormat.convertMax2Words(user.full_name),
              style: smartRTTextTitle,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '${user.is_committe == 1 ? 'Panitia Pemilihan Calon Pengurus RT\n' : ''}${user.user_role.name.replaceAll("_", " ")}',
              style: smartRTTextLarge,
            ),
            SB_height30,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.calendar_month,
                        iconColor: smartRTPrimaryColor,
                        title: 'Acara',
                        onTap: () async {
                          acara();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.handshake,
                        iconColor: smartRTPrimaryColor,
                        title: 'Janji Temu',
                        onTap: () async {
                          janjiTemu();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.article,
                        iconColor: smartRTPrimaryColor,
                        title: 'ADM',
                        onTap: () async {
                          administrasi();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.group,
                        iconColor: smartRTPrimaryColor,
                        title: 'Arisan',
                        onTap: () async {
                          arisan();
                        },
                      ),
                    ),
                  ],
                ),
                SB_height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.analytics,
                        iconColor: smartRTPrimaryColor,
                        title: 'Performa Saya',
                        onTap: () async {
                          performaSaya();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.health_and_safety,
                        iconColor: smartRTPrimaryColor,
                        title: 'Kesehatan',
                        onTap: () async {
                          kesehatan();
                        },
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.close,
                        iconColor: smartRTPrimaryColor,
                        title: '-',
                        onTap: () async {},
                      ),
                    ),
                    Expanded(
                      child: CardIconWithText(
                        icon: Icons.close,
                        iconColor: smartRTPrimaryColor,
                        title: '-',
                        onTap: () async {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (user.user_role == Role.Ketua_RT || user.user_role == Role.Guest)
              SB_height30,
            if (user.user_role == Role.Ketua_RT)
              Row(
                children: [
                  CardBigIconAndText(
                    icon: Icons.domain_add,
                    title: 'Konfirmasi Gabung Wilayah',
                    onTap: () async {
                      Navigator.pushNamed(
                          context, KonfirmasiGabungWilayahPage.id);
                    },
                  ),
                ],
              ),
            if (user.user_role == Role.Guest)
              Row(
                children: [
                  CardBigIconAndText(
                    icon: Icons.domain_add,
                    title: 'Gabung Wilayah',
                    onTap: () async {
                      gabungWilayah();
                    },
                  ),
                ],
              ),
            const Divider(
              height: 50,
              thickness: 5,
            ),
            Container(
              padding: paddingCard,
              decoration: BoxDecoration(
                  color: smartRTQuaternaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SEBENTAR LAGI !',
                              style: smartRTTextLarge.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            SB_height5,
                            Text(
                              'SAATNYA UNTUK PERGANTIAN PENGURUS RT',
                              style: smartRTTextNormal,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Lottie.asset(
                            'assets/lotties/decoration/team-jump.json',
                            fit: BoxFit.fitWidth),
                      ),
                    ],
                  ),
                  SB_height15,
                  if (isShowJadwal)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'JADWAL',
                          style: smartRTTextLarge.copyWith(
                              fontWeight: FontWeight.bold, letterSpacing: 5),
                        ),
                        Divider(thickness: 2, color: smartRTSecondaryColor),
                        SB_height5,
                        ListTileData4(
                            title: 'Pendaftaran Panitia',
                            subTitle:
                                '$_dateTenureEndMin60DaysString - $_dateTenureEndMin45DaysString'),
                        ListTileData4(
                            title: 'Pendaftaran Calon Pengurus RT',
                            subTitle:
                                '$_dateTenureEndMin44DaysString - $_dateTenureEndMin30DaysString'),
                        ListTileData4(
                            title: 'Seleksi dan Kampanye',
                            subTitle:
                                '$_dateTenureEndMin29DaysString - $_dateTenureEndMin15DaysString'),
                        ListTileData4(
                            title: 'Pemilihan Pengurus RT Baru',
                            subTitle: _dateTenureEndMin14DaysString),
                        ListTileData4(
                            title: 'Pengumuman Pengurus RT Baru',
                            subTitle: _dateTenureEndMin13DaysString),
                        ListTileData4(
                            title: 'Pergantian Jabatan',
                            subTitle: _dateTenureEndString),
                      ],
                    ),
                  if (isShowJadwal) SB_height15,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isShowJadwal) {
                          isShowJadwal = false;
                        } else {
                          isShowJadwal = true;
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (isShowJadwal) ? 'TUTUP JADWAL' : 'LIHAT JADWAL',
                          style: smartRTTextSmall.copyWith(
                              color: smartRTTertiaryColor),
                        ),
                        Icon(
                            (isShowJadwal)
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: smartRTTertiaryColor)
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (isShowWidgetCommitte)
              const Divider(
                height: 50,
                thickness: 5,
              ),
            if (isShowWidgetCommitte)
              CardListTileWithButton(
                title: titleWidgetCommitte,
                subtitle: detailWidgetCommitte,
                buttonText: committeTxtBtn1,
                onTapButton: committeFuncBtn1,
                buttonText2: 'LIHAT PANITIA',
                onTapButton2: () {
                  Navigator.pushNamed(context, LihatPanitiaPage.id);
                },
              ),
            if (isShowWidgetPengurusRT)
              const Divider(
                height: 50,
                thickness: 5,
              ),
            if (isShowWidgetPengurusRT)
              CardListTileWithButton(
                title: titleWidgetPengurusRT,
                subtitle: detailWidgetPengurusRT,
                buttonText: txtBtn1WidgetPengurusRT,
                onTapButton: funcBtn1WidgetPengurusRT,
                buttonText2: 'LIHAT SEMUA KANDIDAT',
                onTapButton2: () {
                  Navigator.pushNamed(context, LihatSemuaKandidatPage.id);
                },
              ),
          ],
        ),
      ),
    );
  }
}

 */

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_rt/constants/colors.dart';
// import 'package:smart_rt/constants/size.dart';
// import 'package:smart_rt/constants/style.dart';
// import 'package:smart_rt/models/app_setting/app_setting.dart';
// import 'package:smart_rt/models/committe/committe.dart';
// import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
// import 'package:smart_rt/models/user/user.dart';
// import 'package:smart_rt/models/voting/voting.dart';
// import 'package:smart_rt/providers/auth_provider.dart';
// import 'package:smart_rt/providers/committe_provider.dart';
// import 'package:smart_rt/providers/neighbourhood_head_provider.dart';
// import 'package:smart_rt/providers/setting_provider.dart';
// import 'package:smart_rt/providers/voting_provider.dart';
// import 'package:smart_rt/screens/public_screens/langganan/kelebihan_dan_aturan_langganan_page.dart';
// import 'package:smart_rt/screens/public_screens/langganan/langganan_page.dart';
// import 'package:smart_rt/screens/public_screens/voting/voting_absensi_page.dart';
// import 'package:smart_rt/screens/public_screens/voting/voting_page_1.dart';
// import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
// import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
// import 'package:smart_rt/screens/public_screens/committe/lihat_panitia/lihat_panitia_page.dart';
// import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
// import 'package:smart_rt/screens/public_screens/gabung_wilayah/konfirmasi_gabung_wilayah_page.dart';
// import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
// import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
// import 'package:smart_rt/screens/public_screens/acara/acara_page.dart';
// import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_semua_kandidat/lihat_semua_kandidat_page.dart';
// import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_status_kandidat_calon_pengurus_rt_saya_page.dart';
// import 'package:smart_rt/screens/public_screens/neighbourhood_head/rekomendasikan_kandidat_page.dart';
// import 'package:smart_rt/utilities/bool/checker_return_bool.dart';
// import 'package:smart_rt/utilities/net_util.dart';
// import 'package:smart_rt/utilities/string/currency_format.dart';
// import 'package:smart_rt/utilities/string/string_format.dart';
// import 'package:smart_rt/widgets/cards/card_big_icon_text_home.dart';
// import 'package:smart_rt/widgets/cards/card_icon_with_text.dart';
// import 'package:smart_rt/widgets/cards/card_list_tile_with_button.dart';
// import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
// import 'package:smart_rt/screens/public_screens/committe/lihat_status_kepanitiaan_saya_page.dart';
// import 'package:smart_rt/screens/public_screens/committe/rekomendasikan_panitia_page.dart';
// import 'package:smart_rt/widgets/list_tile/list_tile_data_4.dart';
// import 'package:smart_rt/providers/application_provider.dart';

// class BerandaPage extends StatefulWidget {
//   const BerandaPage({super.key});

//   @override
//   State<BerandaPage> createState() => _BerandaPageState();
// }

// class _BerandaPageState extends State<BerandaPage> {
//   User user = AuthProvider.currentUser!;
//   bool isShowJadwal = false;

//   // POLL
//   bool isShowPollingCard = false;

//   // COMMITTE
//   bool isShowWidgetCommitte = false;
//   String titleWidgetCommitte = '';
//   String detailWidgetCommitte = '';
//   String committeTxtBtn1 = '';
//   Function() committeFuncBtn1 = () {};

//   // PENGURUS RT
//   bool isShowWidgetPengurusRT = false;
//   String titleWidgetPengurusRT = '';
//   String detailWidgetPengurusRT = '';
//   String txtBtn1WidgetPengurusRT = '';
//   Function() funcBtn1WidgetPengurusRT = () {};

//   void acara() async {
//     Navigator.pushNamed(context, AcaraPage.id);
//   }

//   void janjiTemu() async {
//     Navigator.pushNamed(context, ListJanjiTemuPage.id);
//   }

//   void administrasi() async {
//     Navigator.pushNamed(context, AdministrationPage.id);
//   }

//   void arisan() async {
//     if (user.area == null) {
//       showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: Text(
//             'Hai Sobat Pintar,',
//             style: smartRTTextTitleCard,
//           ),
//           content: Text(
//             'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
//             style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'OK'),
//               child: Text(
//                 'OK',
//                 style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       Navigator.pushNamed(context, ArisanPage.id);
//     }
//   }

//   void performaSaya() async {}
//   void kesehatan() async {
//     Navigator.pushNamed(context, KesehatankuPage.id);
//   }

//   void gabungWilayah() async {
//     Navigator.pushNamed(context, GabungWilayahPage.id);
//   }

//   void langgananPro() async {
//     int subscribeAmount = context.read<SettingProvider>().subscribeAmount;
//     if (user.area!.is_subscribe_pro == 0) {
//       showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: Text(
//             'Hai Sobat Pintar,',
//             style: smartRTTextTitleCard,
//           ),
//           content: Text(
//             'Anda belum bergabung menjadi pengguna Smart RT Pro! Apakah anda berminat untuk mendaftar dan bergabung berlangganan untuk dapat mengakses semua fitur?\n\nBiaya Langganan : \n${CurrencyFormat.convertToIdr(subscribeAmount, 2)}/bulan',
//             style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
//           ),
//           actions: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                           RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(0),
//                   ))),
//                   onPressed: () {
//                     Navigator.pushNamed(
//                         context, KelebihanDanAturanLangganan.id);
//                   },
//                   child: Text(
//                     'DAFTAR SEKARANG!',
//                     style: smartRTTextLarge.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: smartRTQuaternaryColor),
//                   ),
//                 ),
//               ),
//             ),
//             Center(
//               child: TextButton(
//                 onPressed: () => Navigator.pop(context, 'Batal'),
//                 child: Text(
//                   'Batal',
//                   style: smartRTTextNormal,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       Navigator.pushNamed(context, LanggananPage.id);
//     }
//   }

//   void showVoteDone(String dateTime) async {
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text(
//           'Hai Sobat Pintar,',
//           style: smartRTTextTitleCard,
//         ),
//         content: Text(
//           'Anda sudah melakukan voting pada tanggal $dateTime !',
//           style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () => Navigator.pop(context, 'OK'),
//             child: Text(
//               'OK',
//               style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void getData() async {
//     await context.read<CommitteProvider>().getDataMyCommitteActive();

//     if (user.area != null) {
//       if (user.is_committe == 0) {
//         await context
//             .read<NeighbourhoodHeadProvider>()
//             .getDataMyNeighbourhoodHeadCandidateThisPeriod(
//                 periode: user.area!.periode.toString());
//       }
//       await context
//           .read<VotingProvider>()
//           .getMyVoteData(periode: user.area!.periode.toString());
//     }
//   }

// // === POLL
//   void getDataCardPoll() {
//     if (user.area != null) {
//       DateTime dateNow = DateTime.now();
//       DateTime dateTenureEndMin14Days =
//           user.area!.tenure_end_at.add(const Duration(days: -14));
//       String dt1 = DateFormat('d MMMM y', 'id_ID').format(dateNow);
//       String dt2 =
//           DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin14Days);

//       if (dt1 == dt2) {
//         isShowPollingCard = true;
//       }
//     }
//     setState(() {});
//   }
// // === END POLL

// // === COMMITTE
//   /// - Pendaftaran panitia dibuka dateTenureEndMin60Days~dateTenureEndMin45Days
//   /// - Widget Card Committe akan muncul dari dateTenureEndMin60Days~dateTenureEnd
//   /// - Yang dapat daftar menjadi panitia cuma Role Warga
//   /// - Pengurus RT saat ini dapat merekomendasikan

//   void showConfirmationDaftarPanitia(Committe data) {
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text(
//           'Hai Sobat Pintar,',
//           style: smartRTTextTitleCard,
//         ),
//         content: Text(
//           'Apakah anda yakin mendaftar sebagai panitia pemilihan pengurus RT?\n\nJika anda menjadi panitia maka anda tidak dapat mencalonkan diri sebagai pengurus RT!',
//           style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
//         ),
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Tidak'),
//                 child: Text('Tidak', style: smartRTTextNormal),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   Response<dynamic> resp =
//                       await NetUtil().dioClient.post('/committe/req/add');
//                   Navigator.pop(context);
//                   if (resp.statusCode.toString() == '200') {
//                     getData();
//                     setState(() {});
//                     SmartRTSnackbar.show(context,
//                         message: resp.data,
//                         backgroundColor: smartRTSuccessColor);
//                   } else {
//                     SmartRTSnackbar.show(context,
//                         message: resp.data, backgroundColor: smartRTErrorColor);
//                   }
//                 },
//                 child: Text(
//                   'IYA, DAFTAR!',
//                   style: smartRTTextNormal.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: smartRTStatusGreenColor),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   bool isShowCommitteCheck() {
//     if (user.area != null) {
//       DateTime dateTimeNow = DateTime.now();
//       DateTime dateTenureEnd = user.area!.tenure_end_at;
//       DateTime dateTenureEndMin60Days =
//           user.area!.tenure_end_at.add(const Duration(days: -60));

//       if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow, dt2: dateTenureEndMin60Days, dt3: dateTenureEnd)) {
//         return true;
//       }
//     }
//     return false;
//   }

//   void getTitleAndDetailWidgetCommitte(Committe data) {
//     titleWidgetCommitte = 'PANITIA PEMILIHAN CALON PENGURUS RT!';
//     detailWidgetCommitte = '';

//     DateTime dateTimeNow = DateTime.now();
//     DateTime dateTenureEndMin60Days =
//         user.area!.tenure_end_at.add(const Duration(days: -60));
//     DateTime dateTenureEndMin45Days =
//         user.area!.tenure_end_at.add(const Duration(days: -45));

//     if (data.id == -1 &&
//         user.user_role == Role.Warga &&
//         CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow,
//           dt2: dateTenureEndMin60Days,
//           dt3: dateTenureEndMin45Days,
//         )) {
//       detailWidgetCommitte =
//           'Daftarkan dirimu menjadi panitia pemilihan pengurus RT untuk menyeleksi hingga membantu keberlangsungan acara!\n\n*Catatan : \nAnda tidak dapat mencalonkan diri menjadi pengurus RT ketika anda menjadi panitia!\n\nPendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin60Days)} dan batas akhir pendaftaran Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin45Days)} !';
//     } else {
//       detailWidgetCommitte =
//           'Pendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin60Days)} dan batas akhir pendaftaran Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin45Days)} !';
//     }
//   }

//   void getDataCommitteBtn1(Committe data) {
//     DateTime dateTimeNow = DateTime.now();
//     DateTime dateTenureEndMin60Days =
//         user.area!.tenure_end_at.add(const Duration(days: -60));
//     DateTime dateTenureEndMin45Days =
//         user.area!.tenure_end_at.add(const Duration(days: -45));

//     if (user.user_role == Role.Warga) {
//       if (data.status >= -1) {
//         committeTxtBtn1 = 'LIHAT STATUS SAYA';
//         committeFuncBtn1 = () {
//           Navigator.pushNamed(context, LihatStatusKepanitiaanSayaPage.id);
//         };
//       } else if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//         dt1: dateTimeNow,
//         dt2: dateTenureEndMin60Days,
//         dt3: dateTenureEndMin45Days,
//       )) {
//         committeTxtBtn1 = 'DAFTAR SEKARANG';
//         committeFuncBtn1 = () {
//           String tahunSekarang = DateFormat('y').format(DateTime.now());
//           String tahunLahir = DateFormat('y').format(user.born_date!);
//           int umur = int.parse(tahunSekarang) - int.parse(tahunLahir);
//           if (user.user_role == Role.Warga && umur >= 17) {
//             showConfirmationDaftarPanitia(data);
//           }
//         };
//       }
//     } else if ((user.user_role == Role.Ketua_RT ||
//             user.user_role == Role.Wakil_RT ||
//             user.user_role == Role.Sekretaris ||
//             user.user_role == Role.Bendahara) &&
//         (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow,
//           dt2: dateTenureEndMin60Days,
//           dt3: dateTenureEndMin45Days,
//         ))) {
//       committeTxtBtn1 = 'REKOMENDASIKAN PANITIA';
//       committeFuncBtn1 = () {
//         Navigator.pushNamed(context, RekomendasikanPanitiaPage.id);
//       };
//     }
//   }

//   void getDataWidgetCommitte({required Committe data}) async {
//     isShowWidgetCommitte = isShowCommitteCheck();

//     if (isShowWidgetCommitte) {
//       getTitleAndDetailWidgetCommitte(data);
//       getDataCommitteBtn1(data);
//       setState(() {});
//     }
//   }
// // === END COMMITTE

// // === PENGURUS RT
//   /// - Pendaftaran pengurus RT dibuka dateTenureEndMin44Days~dateTenureEndMin30Days
//   /// - Widget Card Kandidat Pengurus RT akan muncul dari dateTenureEndMin44Days~dateTenureEnd
//   /// - Yang dapat daftar menjadi kandidat pengurus RT cuma yang bukan panitia
//   void showConfirmationDaftarCalonPengurusRT() {
//     final _visiController = TextEditingController();
//     final _misiController = TextEditingController();
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text(
//           'Hai Sobat Pintar,',
//           style: smartRTTextTitleCard,
//         ),
//         content: Text(
//           'Apakah anda yakin mendaftar sebagai calon Pengurus RT?\nJika anda yakin, anda wajib mengisikan visi misi anda sebagai Pengurus RT!',
//           style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: _visiController,
//               maxLines: 1,
//               autocorrect: false,
//               style: smartRTTextNormal_Primary,
//               decoration: const InputDecoration(
//                 labelText: 'Visi',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: _misiController,
//               maxLines: 5,
//               autocorrect: false,
//               style: smartRTTextNormal_Primary,
//               decoration: const InputDecoration(
//                 labelText: 'Misi',
//               ),
//             ),
//           ),
//           SB_height30,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Tidak'),
//                 child: Text('Tidak', style: smartRTTextNormal),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   daftarCalonPengurusRT(
//                       visi: _visiController.text, misi: _misiController.text);
//                 },
//                 child: Text(
//                   'IYA, DAFTAR!',
//                   style: smartRTTextNormal.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: smartRTStatusGreenColor),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void daftarCalonPengurusRT(
//       {required String visi, required String misi}) async {
//     int periode = user.area!.periode;
//     Response<dynamic> resp = await NetUtil().dioClient.post(
//         '/neighbourhood-head/add',
//         data: {"visi": visi, "misi": misi, "periode": periode});
//     if (resp.statusCode.toString() == '200') {
//       Navigator.pop(context);
//       getData();
//       setState(() {});
//       SmartRTSnackbar.show(context,
//           message: resp.data, backgroundColor: smartRTSuccessColor);
//     } else {
//       SmartRTSnackbar.show(context,
//           message: resp.data, backgroundColor: smartRTErrorColor);
//     }
//   }

//   bool isShowWidgetPengurusRTCheck() {
//     if (user.area != null) {
//       DateTime dateTimeNow = DateTime.now();
//       DateTime dateTenureEnd = user.area!.tenure_end_at;
//       DateTime dateTenureEndMin44Days =
//           user.area!.tenure_end_at.add(const Duration(days: -44));

//       if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow, dt2: dateTenureEndMin44Days, dt3: dateTenureEnd)) {
//         return true;
//       }
//     }
//     return false;
//   }

//   void getTitleAndDetailWidgetPengurusRT(
//       {required NeighbourhoodHeadCandidate data}) {
//     titleWidgetPengurusRT = 'KANDIDAT CALON PENGURUS RT';
//     detailWidgetPengurusRT = '';

//     DateTime dateTimeNow = DateTime.now();
//     DateTime dateTenureEndMin44Days =
//         user.area!.tenure_end_at.add(const Duration(days: -44));
//     DateTime dateTenureEndMin30Days =
//         user.area!.tenure_end_at.add(const Duration(days: -30));
//     DateTime dateTenureEndMin29Days =
//         user.area!.tenure_end_at.add(const Duration(days: -29));
//     DateTime dateTenureEndMin15Days =
//         user.area!.tenure_end_at.add(const Duration(days: -15));

//     if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow,
//           dt2: dateTenureEndMin44Days,
//           dt3: dateTenureEndMin30Days,
//         ) &&
//         user.is_committe == 0 &&
//         data.status == -99) {
//       detailWidgetPengurusRT =
//           'Daftarkan dirimu menjadi Kandidat calon pengurus RT!\n\nPendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin44Days)} dan batas akhir bergabung dalam Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin30Days)} !';
//     } else {
//       detailWidgetPengurusRT =
//           'Pendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin44Days)} dan batas akhir bergabung menjadi Kandidat Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin30Days)} !\n\nKampanye dapat dilaksanakan pada tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin29Days)} hingga ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin15Days)} !';
//     }
//   }

//   void getBtn1WidgetPengurusRT({required NeighbourhoodHeadCandidate data}) {
//     DateTime dateTimeNow = DateTime.now();
//     DateTime dateTenureEndMin44Days =
//         user.area!.tenure_end_at.add(const Duration(days: -44));
//     DateTime dateTenureEndMin30Days =
//         user.area!.tenure_end_at.add(const Duration(days: -30));

//     if (user.is_committe == 0) {
//       if (data.status != -99) {
//         txtBtn1WidgetPengurusRT = 'LIHAT STATUS SAYA';
//         funcBtn1WidgetPengurusRT = () {
//           Navigator.pushNamed(
//               context, LihatStatusKandidatCalonPengurusRTSayaPage.id);
//         };
//       } else if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//         dt1: dateTimeNow,
//         dt2: dateTenureEndMin44Days,
//         dt3: dateTenureEndMin30Days,
//       )) {
//         txtBtn1WidgetPengurusRT = 'DAFTAR SEKARANG';
//         funcBtn1WidgetPengurusRT = () {
//           String tahunSekarang = DateFormat('y').format(DateTime.now());
//           String tahunLahir = DateFormat('y').format(user.born_date!);
//           int umur = int.parse(tahunSekarang) - int.parse(tahunLahir);
//           if (umur >= 17) {
//             showConfirmationDaftarCalonPengurusRT();
//           }
//         };
//       }
//     } else {
//       if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//         dt1: dateTimeNow,
//         dt2: dateTenureEndMin44Days,
//         dt3: dateTenureEndMin30Days,
//       )) {
//         txtBtn1WidgetPengurusRT = 'REKOMENDASIKAN\nCALON PENGURUS RT';
//         funcBtn1WidgetPengurusRT = () {
//           Navigator.pushNamed(context, RekomendasikanKandidatPage.id);
//         };
//       }
//     }
//   }

//   void getDataWidgetPengurusRT(
//       {required NeighbourhoodHeadCandidate data}) async {
//     isShowWidgetPengurusRT = isShowWidgetPengurusRTCheck();
//     if (isShowWidgetPengurusRT) {
//       getTitleAndDetailWidgetPengurusRT(data: data);
//       getBtn1WidgetPengurusRT(data: data);
//     }
//     setState(() {});
//   }

// // === END PENGURUS RT

//   @override
//   void initState() {
//     // TODO: implement initState
//     getData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double widthScreen = MediaQuery.of(context).size.width;
//     double heightScreen = MediaQuery.of(context).size.height;

//     Committe dataMyCommitteActive =
//         context.watch<CommitteProvider>().dataMyCommitteActive;
//     getDataWidgetCommitte(data: dataMyCommitteActive);
//     NeighbourhoodHeadCandidate dataSayaSebagaiKandidatPengurusRTSekarang =
//         context
//             .watch<NeighbourhoodHeadProvider>()
//             .dataSayaSebagaiKandidatPengurusRTSekarang;
//     getDataWidgetPengurusRT(data: dataSayaSebagaiKandidatPengurusRTSekarang);

//     Voting myVoteData = context.watch<VotingProvider>().myVoteData;
//     debugPrint("myVoteData.id.toString()");
//     debugPrint(myVoteData.id.toString());
//     getDataCardPoll();

//     String _dateTenureEndMin60DaysString = '';
//     String _dateTenureEndMin45DaysString = '';
//     String _dateTenureEndMin44DaysString = '';
//     String _dateTenureEndMin30DaysString = '';
//     String _dateTenureEndMin29DaysString = '';
//     String _dateTenureEndMin15DaysString = '';
//     String _dateTenureEndMin14DaysString = '';
//     String _dateTenureEndMin13DaysString = '';
//     String _dateTenureEndString = '';

//     if (user.area != null) {
//       DateTime _dateTenureEndMin60Days =
//           user.area!.tenure_end_at.add(const Duration(days: -60));
//       DateTime _dateTenureEndMin45Days =
//           user.area!.tenure_end_at.add(const Duration(days: -45));
//       DateTime _dateTenureEndMin44Days =
//           user.area!.tenure_end_at.add(const Duration(days: -44));
//       DateTime _dateTenureEndMin30Days =
//           user.area!.tenure_end_at.add(const Duration(days: -30));
//       DateTime _dateTenureEndMin29Days =
//           user.area!.tenure_end_at.add(const Duration(days: -29));
//       DateTime _dateTenureEndMin15Days =
//           user.area!.tenure_end_at.add(const Duration(days: -15));
//       DateTime _dateTenureEndMin14Days =
//           user.area!.tenure_end_at.add(const Duration(days: -14));
//       DateTime _dateTenureEndMin13Days =
//           user.area!.tenure_end_at.add(const Duration(days: -13));
//       DateTime _dateTenureEnd = user.area!.tenure_end_at;

//       _dateTenureEndMin60DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin60Days);
//       _dateTenureEndMin45DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin45Days);
//       _dateTenureEndMin44DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin44Days);
//       _dateTenureEndMin30DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin30Days);
//       _dateTenureEndMin29DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin29Days);
//       _dateTenureEndMin15DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin15Days);
//       _dateTenureEndMin14DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin14Days);
//       _dateTenureEndMin13DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin13Days);
//       _dateTenureEndString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEnd);
//     }

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Padding(
//             padding: paddingScreen,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   'Halo,',
//                   style: smartRTTextTitleCard,
//                 ),
//                 Text(
//                   StringFormat.convertMax2Words(user.full_name),
//                   style: smartRTTextTitle,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   '${user.is_committe == 1 ? 'Panitia Pemilihan Calon Pengurus RT\n' : ''}${user.user_role.name.replaceAll("_", " ")}',
//                   style: smartRTTextLarge,
//                 ),
//                 SB_height30,
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: CardIconWithText(
//                             icon: Icons.calendar_month,
//                             iconColor: smartRTPrimaryColor,
//                             title: 'Acara',
//                             onTap: () async {
//                               acara();
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           child: CardIconWithText(
//                             icon: Icons.handshake,
//                             iconColor: smartRTPrimaryColor,
//                             title: 'Janji Temu',
//                             onTap: () async {
//                               janjiTemu();
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           child: CardIconWithText(
//                             icon: Icons.article,
//                             iconColor: smartRTPrimaryColor,
//                             title: 'ADM',
//                             onTap: () async {
//                               administrasi();
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           child: CardIconWithText(
//                             icon: Icons.group,
//                             iconColor: smartRTPrimaryColor,
//                             title: 'Arisan',
//                             onTap: () async {
//                               arisan();
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SB_height15,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: CardIconWithText(
//                             icon: Icons.analytics,
//                             iconColor: smartRTPrimaryColor,
//                             title: 'Performa Saya',
//                             onTap: () async {
//                               performaSaya();
//                             },
//                           ),
//                         ),
//                         Expanded(
//                           child: CardIconWithText(
//                             icon: Icons.health_and_safety,
//                             iconColor: smartRTPrimaryColor,
//                             title: 'Kesehatan',
//                             onTap: () async {
//                               kesehatan();
//                             },
//                           ),
//                         ),
//                         user.user_role != Role.Guest &&
//                                 user.user_role != Role.Warga
//                             ? Expanded(
//                                 child: CardIconWithText(
//                                   icon: Icons.payment,
//                                   iconColor: smartRTPrimaryColor,
//                                   title: 'Langganan Pro',
//                                   onTap: () async {
//                                     langgananPro();
//                                   },
//                                 ),
//                               )
//                             : Expanded(
//                                 child: CardIconWithText(
//                                   icon: Icons.close,
//                                   iconColor: smartRTPrimaryColor,
//                                   title: '-',
//                                   onTap: () async {},
//                                 ),
//                               ),
//                         Expanded(
//                           child: CardIconWithText(
//                             icon: Icons.close,
//                             iconColor: smartRTPrimaryColor,
//                             title: '-',
//                             onTap: () async {
//                               ApplicationProvider.showNotification(
//                                   hashCode: 1,
//                                   notificationBody: "Test VBoasdas",
//                                   notificationTitle: "ASDASD");
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 if (user.user_role == Role.Ketua_RT ||
//                     user.user_role == Role.Guest)
//                   SB_height30,
//                 if (user.user_role == Role.Ketua_RT)
//                   Row(
//                     children: [
//                       CardBigIconAndText(
//                         icon: Icons.domain_add,
//                         title: 'Konfirmasi Gabung Wilayah',
//                         onTap: () async {
//                           Navigator.pushNamed(
//                               context, KonfirmasiGabungWilayahPage.id);
//                         },
//                       ),
//                     ],
//                   ),
//                 if (user.user_role == Role.Guest)
//                   Row(
//                     children: [
//                       CardBigIconAndText(
//                         icon: Icons.domain_add,
//                         title: 'Gabung Wilayah',
//                         onTap: () async {
//                           gabungWilayah();
//                         },
//                       ),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//           const Divider(
//             thickness: 25,
//           ),
//           Column(
//             children: [
//               Container(
//                 padding: paddingCard,
//                 color: smartRTQuaternaryColor,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'SEBENTAR LAGI !',
//                                 style: smartRTTextLarge.copyWith(
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               SB_height5,
//                               Text(
//                                 'SAATNYA UNTUK PERGANTIAN PENGURUS RT',
//                                 style: smartRTTextNormal,
//                               ),
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Lottie.asset(
//                               'assets/lotties/decoration/team-jump.json',
//                               fit: BoxFit.fitWidth),
//                         ),
//                       ],
//                     ),
//                     SB_height15,
//                     if (isShowJadwal)
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             'JADWAL',
//                             style: smartRTTextLarge.copyWith(
//                                 fontWeight: FontWeight.bold, letterSpacing: 5),
//                           ),
//                           Divider(thickness: 2, color: smartRTSecondaryColor),
//                           SB_height5,
//                           ListTileData4(
//                               title: 'Pendaftaran Panitia',
//                               subTitle:
//                                   '$_dateTenureEndMin60DaysString - $_dateTenureEndMin45DaysString'),
//                           ListTileData4(
//                               title: 'Pendaftaran Calon Pengurus RT',
//                               subTitle:
//                                   '$_dateTenureEndMin44DaysString - $_dateTenureEndMin30DaysString'),
//                           ListTileData4(
//                               title: 'Seleksi dan Kampanye',
//                               subTitle:
//                                   '$_dateTenureEndMin29DaysString - $_dateTenureEndMin15DaysString'),
//                           ListTileData4(
//                               title: 'Pemilihan Pengurus RT Baru',
//                               subTitle: _dateTenureEndMin14DaysString),
//                           ListTileData4(
//                               title: 'Pengumuman Pengurus RT Baru',
//                               subTitle: _dateTenureEndMin13DaysString),
//                           ListTileData4(
//                               title: 'Pergantian Jabatan',
//                               subTitle: _dateTenureEndString),
//                         ],
//                       ),
//                     if (isShowJadwal) SB_height15,
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           if (isShowJadwal) {
//                             isShowJadwal = false;
//                           } else {
//                             isShowJadwal = true;
//                           }
//                         });
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             (isShowJadwal) ? 'TUTUP JADWAL' : 'LIHAT JADWAL',
//                             style: smartRTTextSmall.copyWith(
//                                 color: smartRTTertiaryColor),
//                           ),
//                           Icon(
//                               (isShowJadwal)
//                                   ? Icons.keyboard_arrow_up
//                                   : Icons.keyboard_arrow_down,
//                               color: smartRTTertiaryColor)
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SB_height5,
//               SB_height5,
//             ],
//           ),
//           if (isShowPollingCard)
//             const Divider(
//               thickness: 25,
//             ),
//           if (isShowPollingCard)
//             Column(
//               children: [
//                 Container(
//                   padding: paddingCard,
//                   color: smartRTQuaternaryColor,
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Lottie.asset(
//                                 'assets/lotties/decoration/vote.json',
//                                 fit: BoxFit.fitWidth),
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'WAKTUNYA TIBA !',
//                                   style: smartRTTextLarge.copyWith(
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 SB_height5,
//                                 Text(
//                                   'YUK VOTING KANDIDAT PENGURUS RT SEKARANG !',
//                                   style: smartRTTextNormal,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Divider(
//                         thickness: 1,
//                         height: 15,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushNamed(context, VotingAbsensiPage.id);
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'LIHAT ABSENSI',
//                               style: smartRTTextSmall.copyWith(
//                                   color: smartRTTertiaryColor),
//                             ),
//                             Icon(Icons.keyboard_arrow_right,
//                                 color: smartRTTertiaryColor)
//                           ],
//                         ),
//                       ),
//                       const Divider(
//                         thickness: 1,
//                         height: 15,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           if (myVoteData.id == -1) {
//                             Navigator.pushNamed(context, VotingPage1.id);
//                           } else {
//                             String dateTime =
//                                 DateFormat('d MMMM y HH:mm', 'id_ID')
//                                     .format(myVoteData.created_at);
//                             showVoteDone(dateTime);
//                           }
//                         },
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'VOTING SEKARANG',
//                               style: smartRTTextSmall.copyWith(
//                                   color: smartRTTertiaryColor),
//                             ),
//                             Icon(Icons.keyboard_arrow_right,
//                                 color: smartRTTertiaryColor)
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SB_height5,
//                 SB_height5,
//               ],
//             ),
//           if (isShowWidgetCommitte)
//             const Divider(
//               thickness: 25,
//             ),
//           if (isShowWidgetCommitte)
//             Padding(
//               padding: paddingScreen,
//               child: CardListTileWithButton(
//                 title: titleWidgetCommitte,
//                 subtitle: detailWidgetCommitte,
//                 buttonText: committeTxtBtn1,
//                 onTapButton: committeFuncBtn1,
//                 buttonText2: 'LIHAT PANITIA',
//                 onTapButton2: () {
//                   Navigator.pushNamed(context, LihatPanitiaPage.id);
//                 },
//               ),
//             ),
//           if (isShowWidgetPengurusRT)
//             const Divider(
//               height: 50,
//               thickness: 5,
//             ),
//           if (isShowWidgetPengurusRT)
//             Padding(
//               padding: paddingScreen,
//               child: CardListTileWithButton(
//                 title: titleWidgetPengurusRT,
//                 subtitle: detailWidgetPengurusRT,
//                 buttonText: txtBtn1WidgetPengurusRT,
//                 onTapButton: funcBtn1WidgetPengurusRT,
//                 buttonText2: 'LIHAT SEMUA KANDIDAT',
//                 onTapButton2: () {
//                   Navigator.pushNamed(context, LihatSemuaKandidatPage.id);
//                 },
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }


// /**
//  * 
//  * import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_rt/constants/colors.dart';
// import 'package:smart_rt/constants/size.dart';
// import 'package:smart_rt/constants/style.dart';
// import 'package:smart_rt/models/committe/committe.dart';
// import 'package:smart_rt/models/neighbourhood_head/neighbourhood_head_candidate.dart';
// import 'package:smart_rt/models/user/user.dart';
// import 'package:smart_rt/providers/auth_provider.dart';
// import 'package:smart_rt/providers/committe_provider.dart';
// import 'package:smart_rt/providers/neighbourhood_head_provider.dart';
// import 'package:smart_rt/screens/public_screens/arisan/arisan_page.dart';
// import 'package:smart_rt/screens/public_screens/administration/administration_page.dart';
// import 'package:smart_rt/screens/public_screens/committe/lihat_panitia/lihat_panitia_page.dart';
// import 'package:smart_rt/screens/public_screens/gabung_wilayah/gabung_wilayah_page.dart';
// import 'package:smart_rt/screens/public_screens/gabung_wilayah/konfirmasi_gabung_wilayah_page.dart';
// import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
// import 'package:smart_rt/screens/public_screens/kesehatan/kesehatanku_page.dart';
// import 'package:smart_rt/screens/public_screens/acara/acara_page.dart';
// import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_semua_kandidat/lihat_semua_kandidat_page.dart';
// import 'package:smart_rt/screens/public_screens/neighbourhood_head/lihat_status_kandidat_calon_pengurus_rt_saya_page.dart';
// import 'package:smart_rt/screens/public_screens/neighbourhood_head/rekomendasikan_kandidat_page.dart';
// import 'package:smart_rt/utilities/bool/checker_return_bool.dart';
// import 'package:smart_rt/utilities/net_util.dart';
// import 'package:smart_rt/utilities/string/string_format.dart';
// import 'package:smart_rt/widgets/cards/card_big_icon_text_home.dart';
// import 'package:smart_rt/widgets/cards/card_icon_with_text.dart';
// import 'package:smart_rt/widgets/cards/card_list_tile_with_button.dart';
// import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
// import 'package:smart_rt/screens/public_screens/committe/lihat_status_kepanitiaan_saya_page.dart';
// import 'package:smart_rt/screens/public_screens/committe/rekomendasikan_panitia_page.dart';
// import 'package:smart_rt/widgets/list_tile/list_tile_data_4.dart';

// class BerandaPage extends StatefulWidget {
//   const BerandaPage({super.key});

//   @override
//   State<BerandaPage> createState() => _BerandaPageState();
// }

// class _BerandaPageState extends State<BerandaPage> {
//   User user = AuthProvider.currentUser!;
//   bool isShowJadwal = false;

//   // COMMITTE
//   bool isShowWidgetCommitte = false;
//   String titleWidgetCommitte = '';
//   String detailWidgetCommitte = '';
//   String committeTxtBtn1 = '';
//   Function() committeFuncBtn1 = () {};

//   // PENGURUS RT
//   bool isShowWidgetPengurusRT = false;
//   String titleWidgetPengurusRT = '';
//   String detailWidgetPengurusRT = '';
//   String txtBtn1WidgetPengurusRT = '';
//   Function() funcBtn1WidgetPengurusRT = () {};

//   void acara() async {
//     Navigator.pushNamed(context, AcaraPage.id);
//   }

//   void janjiTemu() async {
//     Navigator.pushNamed(context, ListJanjiTemuPage.id);
//   }

//   void administrasi() async {
//     Navigator.pushNamed(context, AdministrationPage.id);
//   }

//   void arisan() async {
//     if (user.area == null) {
//       showDialog<String>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//           title: Text(
//             'Hai Sobat Pintar,',
//             style: smartRTTextTitleCard,
//           ),
//           content: Text(
//             'Anda baru dapat menggunakan fitur ini jika anda telah bergabung dengan wilayah anda!',
//             style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context, 'OK'),
//               child: Text(
//                 'OK',
//                 style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//           ],
//         ),
//       );
//     } else {
//       Navigator.pushNamed(context, ArisanPage.id);
//     }
//   }

//   void performaSaya() async {}
//   void kesehatan() async {
//     Navigator.pushNamed(context, KesehatankuPage.id);
//   }

//   void gabungWilayah() async {
//     Navigator.pushNamed(context, GabungWilayahPage.id);
//   }

//   void getData() async {
//     await context.read<CommitteProvider>().getDataMyCommitteActive();

//     if (user.area != null && user.is_committe == 0) {
//       await context
//           .read<NeighbourhoodHeadProvider>()
//           .getDataMyNeighbourhoodHeadCandidateThisPeriod(
//               periode: user.area!.periode.toString());
//     }
//   }

// // === COMMITTE
//   /// - Pendaftaran panitia dibuka dateTenureEndMin60Days~dateTenureEndMin45Days
//   /// - Widget Card Committe akan muncul dari dateTenureEndMin60Days~dateTenureEnd
//   /// - Yang dapat daftar menjadi panitia cuma Role Warga
//   /// - Pengurus RT saat ini dapat merekomendasikan

//   void showConfirmationDaftarPanitia(Committe data) {
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text(
//           'Hai Sobat Pintar,',
//           style: smartRTTextTitleCard,
//         ),
//         content: Text(
//           'Apakah anda yakin mendaftar sebagai panitia pemilihan pengurus RT?\n\nJika anda menjadi panitia maka anda tidak dapat mencalonkan diri sebagai pengurus RT!',
//           style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
//         ),
//         actions: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Tidak'),
//                 child: Text('Tidak', style: smartRTTextNormal),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   Response<dynamic> resp =
//                       await NetUtil().dioClient.post('/committe/req/add');
//                   Navigator.pop(context);
//                   if (resp.statusCode.toString() == '200') {
//                     getData();
//                     setState(() {});
//                     SmartRTSnackbar.show(context,
//                         message: resp.data,
//                         backgroundColor: smartRTSuccessColor);
//                   } else {
//                     SmartRTSnackbar.show(context,
//                         message: resp.data, backgroundColor: smartRTErrorColor);
//                   }
//                 },
//                 child: Text(
//                   'IYA, DAFTAR!',
//                   style: smartRTTextNormal.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: smartRTStatusGreenColor),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   bool isShowCommitteCheck() {
//     if (user.area != null) {
//       DateTime dateTimeNow = DateTime.now();
//       DateTime dateTenureEnd = user.area!.tenure_end_at;
//       DateTime dateTenureEndMin60Days =
//           user.area!.tenure_end_at.add(const Duration(days: -60));

//       if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow, dt2: dateTenureEndMin60Days, dt3: dateTenureEnd)) {
//         return true;
//       }
//     }
//     return false;
//   }

//   void getTitleAndDetailWidgetCommitte(Committe data) {
//     titleWidgetCommitte = 'PANITIA PEMILIHAN CALON PENGURUS RT!';
//     detailWidgetCommitte = '';

//     DateTime dateTimeNow = DateTime.now();
//     DateTime dateTenureEndMin60Days =
//         user.area!.tenure_end_at.add(const Duration(days: -60));
//     DateTime dateTenureEndMin45Days =
//         user.area!.tenure_end_at.add(const Duration(days: -45));

//     if (data.id == -1 &&
//         user.user_role == Role.Warga &&
//         CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow,
//           dt2: dateTenureEndMin60Days,
//           dt3: dateTenureEndMin45Days,
//         )) {
//       detailWidgetCommitte =
//           'Daftarkan dirimu menjadi panitia pemilihan pengurus RT untuk menyeleksi hingga membantu keberlangsungan acara!\n\n*Catatan : \nAnda tidak dapat mencalonkan diri menjadi pengurus RT ketika anda menjadi panitia!\n\nPendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin60Days)} dan batas akhir pendaftaran Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin45Days)} !';
//     } else {
//       detailWidgetCommitte =
//           'Pendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin60Days)} dan batas akhir pendaftaran Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin45Days)} !';
//     }
//   }

//   void getDataCommitteBtn1(Committe data) {
//     DateTime dateTimeNow = DateTime.now();
//     DateTime dateTenureEndMin60Days =
//         user.area!.tenure_end_at.add(const Duration(days: -60));
//     DateTime dateTenureEndMin45Days =
//         user.area!.tenure_end_at.add(const Duration(days: -45));

//     if (user.user_role == Role.Warga) {
//       if (data.status >= -1) {
//         committeTxtBtn1 = 'LIHAT STATUS SAYA';
//         committeFuncBtn1 = () {
//           Navigator.pushNamed(context, LihatStatusKepanitiaanSayaPage.id);
//         };
//       } else if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//         dt1: dateTimeNow,
//         dt2: dateTenureEndMin60Days,
//         dt3: dateTenureEndMin45Days,
//       )) {
//         committeTxtBtn1 = 'DAFTAR SEKARANG';
//         committeFuncBtn1 = () {
//           String tahunSekarang = DateFormat('y').format(DateTime.now());
//           String tahunLahir = DateFormat('y').format(user.born_date!);
//           int umur = int.parse(tahunSekarang) - int.parse(tahunLahir);
//           if (user.user_role == Role.Warga && umur >= 17) {
//             showConfirmationDaftarPanitia(data);
//           }
//         };
//       }
//     } else if ((user.user_role == Role.Ketua_RT ||
//             user.user_role == Role.Wakil_RT ||
//             user.user_role == Role.Sekretaris ||
//             user.user_role == Role.Bendahara) &&
//         (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow,
//           dt2: dateTenureEndMin60Days,
//           dt3: dateTenureEndMin45Days,
//         ))) {
//       committeTxtBtn1 = 'REKOMENDASIKAN PANITIA';
//       committeFuncBtn1 = () {
//         Navigator.pushNamed(context, RekomendasikanPanitiaPage.id);
//       };
//     }
//   }

//   void getDataWidgetCommitte({required Committe data}) async {
//     isShowWidgetCommitte = isShowCommitteCheck();

//     if (isShowWidgetCommitte) {
//       getTitleAndDetailWidgetCommitte(data);
//       getDataCommitteBtn1(data);
//       setState(() {});
//     }
//   }
// // === END COMMITTE

// // === PENGURUS RT
//   /// - Pendaftaran pengurus RT dibuka dateTenureEndMin44Days~dateTenureEndMin30Days
//   /// - Widget Card Kandidat Pengurus RT akan muncul dari dateTenureEndMin44Days~dateTenureEnd
//   /// - Yang dapat daftar menjadi kandidat pengurus RT cuma yang bukan panitia
//   void showConfirmationDaftarCalonPengurusRT() {
//     final _visiController = TextEditingController();
//     final _misiController = TextEditingController();
//     showDialog<String>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         title: Text(
//           'Hai Sobat Pintar,',
//           style: smartRTTextTitleCard,
//         ),
//         content: Text(
//           'Apakah anda yakin mendaftar sebagai calon Pengurus RT?\nJika anda yakin, anda wajib mengisikan visi misi anda sebagai Pengurus RT!',
//           style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: _visiController,
//               maxLines: 1,
//               autocorrect: false,
//               style: smartRTTextNormal_Primary,
//               decoration: const InputDecoration(
//                 labelText: 'Visi',
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextFormField(
//               controller: _misiController,
//               maxLines: 5,
//               autocorrect: false,
//               style: smartRTTextNormal_Primary,
//               decoration: const InputDecoration(
//                 labelText: 'Misi',
//               ),
//             ),
//           ),
//           SB_height30,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'Tidak'),
//                 child: Text('Tidak', style: smartRTTextNormal),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   daftarCalonPengurusRT(
//                       visi: _visiController.text, misi: _misiController.text);
//                 },
//                 child: Text(
//                   'IYA, DAFTAR!',
//                   style: smartRTTextNormal.copyWith(
//                       fontWeight: FontWeight.bold,
//                       color: smartRTStatusGreenColor),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void daftarCalonPengurusRT(
//       {required String visi, required String misi}) async {
//     int periode = user.area!.periode;
//     Response<dynamic> resp = await NetUtil().dioClient.post(
//         '/neighbourhood-head/add',
//         data: {"visi": visi, "misi": misi, "periode": periode});
//     if (resp.statusCode.toString() == '200') {
//       Navigator.pop(context);
//       getData();
//       setState(() {});
//       SmartRTSnackbar.show(context,
//           message: resp.data, backgroundColor: smartRTSuccessColor);
//     } else {
//       SmartRTSnackbar.show(context,
//           message: resp.data, backgroundColor: smartRTErrorColor);
//     }
//   }

//   bool isShowWidgetPengurusRTCheck() {
//     if (user.area != null) {
//       DateTime dateTimeNow = DateTime.now();
//       DateTime dateTenureEnd = user.area!.tenure_end_at;
//       DateTime dateTenureEndMin44Days =
//           user.area!.tenure_end_at.add(const Duration(days: -44));

//       if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow, dt2: dateTenureEndMin44Days, dt3: dateTenureEnd)) {
//         return true;
//       }
//     }
//     return false;
//   }

//   void getTitleAndDetailWidgetPengurusRT(
//       {required NeighbourhoodHeadCandidate data}) {
//     titleWidgetPengurusRT = 'KANDIDAT CALON PENGURUS RT';
//     detailWidgetPengurusRT = '';

//     DateTime dateTimeNow = DateTime.now();
//     DateTime dateTenureEndMin44Days =
//         user.area!.tenure_end_at.add(const Duration(days: -44));
//     DateTime dateTenureEndMin30Days =
//         user.area!.tenure_end_at.add(const Duration(days: -30));
//     DateTime dateTenureEndMin29Days =
//         user.area!.tenure_end_at.add(const Duration(days: -29));
//     DateTime dateTenureEndMin15Days =
//         user.area!.tenure_end_at.add(const Duration(days: -15));

//     if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//           dt1: dateTimeNow,
//           dt2: dateTenureEndMin44Days,
//           dt3: dateTenureEndMin30Days,
//         ) &&
//         user.is_committe == 0 &&
//         data.status == -99) {
//       detailWidgetPengurusRT =
//           'Daftarkan dirimu menjadi Kandidat calon pengurus RT!\n\nPendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin44Days)} dan batas akhir bergabung dalam Panitia Pemilihan Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin30Days)} !';
//     } else {
//       detailWidgetPengurusRT =
//           'Pendaftaran dibuka dari tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin44Days)} dan batas akhir bergabung menjadi Kandidat Calon Pengurus RT tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin30Days)} !\n\nKampanye dapat dilaksanakan pada tanggal ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin29Days)} hingga ${DateFormat('d MMMM y', 'id_ID').format(dateTenureEndMin15Days)} !';
//     }
//   }

//   void getBtn1WidgetPengurusRT({required NeighbourhoodHeadCandidate data}) {
//     DateTime dateTimeNow = DateTime.now();
//     DateTime dateTenureEndMin44Days =
//         user.area!.tenure_end_at.add(const Duration(days: -44));
//     DateTime dateTenureEndMin30Days =
//         user.area!.tenure_end_at.add(const Duration(days: -30));

//     if (user.is_committe == 0) {
//       if (data.status != -99) {
//         txtBtn1WidgetPengurusRT = 'LIHAT STATUS SAYA';
//         funcBtn1WidgetPengurusRT = () {
//           Navigator.pushNamed(
//               context, LihatStatusKandidatCalonPengurusRTSayaPage.id);
//         };
//       } else if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//         dt1: dateTimeNow,
//         dt2: dateTenureEndMin44Days,
//         dt3: dateTenureEndMin30Days,
//       )) {
//         txtBtn1WidgetPengurusRT = 'DAFTAR SEKARANG';
//         funcBtn1WidgetPengurusRT = () {
//           String tahunSekarang = DateFormat('y').format(DateTime.now());
//           String tahunLahir = DateFormat('y').format(user.born_date!);
//           int umur = int.parse(tahunSekarang) - int.parse(tahunLahir);
//           if (umur >= 17) {
//             showConfirmationDaftarCalonPengurusRT();
//           }
//         };
//       }
//     } else {
//       if (CheckerReturnBool.isDate1BetweenDate2AndDate3(
//         dt1: dateTimeNow,
//         dt2: dateTenureEndMin44Days,
//         dt3: dateTenureEndMin30Days,
//       )) {
//         txtBtn1WidgetPengurusRT = 'REKOMENDASIKAN\nCALON PENGURUS RT';
//         funcBtn1WidgetPengurusRT = () {
//           Navigator.pushNamed(context, RekomendasikanKandidatPage.id);
//         };
//       }
//     }
//   }

//   void getDataWidgetPengurusRT(
//       {required NeighbourhoodHeadCandidate data}) async {
//     isShowWidgetPengurusRT = isShowWidgetPengurusRTCheck();
//     if (isShowWidgetPengurusRT) {
//       getTitleAndDetailWidgetPengurusRT(data: data);
//       getBtn1WidgetPengurusRT(data: data);
//     }
//     setState(() {});
//   }

// // === END PENGURUS RT

//   @override
//   void initState() {
//     // TODO: implement initState
//     getData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double widthScreen = MediaQuery.of(context).size.width;
//     double heightScreen = MediaQuery.of(context).size.height;

//     Committe dataMyCommitteActive =
//         context.watch<CommitteProvider>().dataMyCommitteActive;
//     getDataWidgetCommitte(data: dataMyCommitteActive);
//     NeighbourhoodHeadCandidate dataSayaSebagaiKandidatPengurusRTSekarang =
//         context
//             .watch<NeighbourhoodHeadProvider>()
//             .dataSayaSebagaiKandidatPengurusRTSekarang;
//     getDataWidgetPengurusRT(data: dataSayaSebagaiKandidatPengurusRTSekarang);

//     String _dateTenureEndMin60DaysString = '';
//     String _dateTenureEndMin45DaysString = '';
//     String _dateTenureEndMin44DaysString = '';
//     String _dateTenureEndMin30DaysString = '';
//     String _dateTenureEndMin29DaysString = '';
//     String _dateTenureEndMin15DaysString = '';
//     String _dateTenureEndMin14DaysString = '';
//     String _dateTenureEndMin13DaysString = '';
//     String _dateTenureEndString = '';

//     if (user.area != null) {
//       DateTime _dateTenureEndMin60Days =
//           user.area!.tenure_end_at.add(const Duration(days: -60));
//       DateTime _dateTenureEndMin45Days =
//           user.area!.tenure_end_at.add(const Duration(days: -45));
//       DateTime _dateTenureEndMin44Days =
//           user.area!.tenure_end_at.add(const Duration(days: -44));
//       DateTime _dateTenureEndMin30Days =
//           user.area!.tenure_end_at.add(const Duration(days: -30));
//       DateTime _dateTenureEndMin29Days =
//           user.area!.tenure_end_at.add(const Duration(days: -29));
//       DateTime _dateTenureEndMin15Days =
//           user.area!.tenure_end_at.add(const Duration(days: -15));
//       DateTime _dateTenureEndMin14Days =
//           user.area!.tenure_end_at.add(const Duration(days: -14));
//       DateTime _dateTenureEndMin13Days =
//           user.area!.tenure_end_at.add(const Duration(days: -13));
//       DateTime _dateTenureEnd = user.area!.tenure_end_at;

//       _dateTenureEndMin60DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin60Days);
//       _dateTenureEndMin45DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin45Days);
//       _dateTenureEndMin44DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin44Days);
//       _dateTenureEndMin30DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin30Days);
//       _dateTenureEndMin29DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin29Days);
//       _dateTenureEndMin15DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin15Days);
//       _dateTenureEndMin14DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin14Days);
//       _dateTenureEndMin13DaysString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEndMin13Days);
//       _dateTenureEndString =
//           DateFormat('d MMMM y', 'id_ID').format(_dateTenureEnd);
//     }

//     return SingleChildScrollView(
//       child: Padding(
//         padding: paddingScreen,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               'Halo,',
//               style: smartRTTextTitleCard,
//             ),
//             Text(
//               StringFormat.convertMax2Words(user.full_name),
//               style: smartRTTextTitle,
//               overflow: TextOverflow.ellipsis,
//             ),
//             Text(
//               '${user.is_committe == 1 ? 'Panitia Pemilihan Calon Pengurus RT\n' : ''}${user.user_role.name.replaceAll("_", " ")}',
//               style: smartRTTextLarge,
//             ),
//             SB_height30,
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: CardIconWithText(
//                         icon: Icons.calendar_month,
//                         iconColor: smartRTPrimaryColor,
//                         title: 'Acara',
//                         onTap: () async {
//                           acara();
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: CardIconWithText(
//                         icon: Icons.handshake,
//                         iconColor: smartRTPrimaryColor,
//                         title: 'Janji Temu',
//                         onTap: () async {
//                           janjiTemu();
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: CardIconWithText(
//                         icon: Icons.article,
//                         iconColor: smartRTPrimaryColor,
//                         title: 'ADM',
//                         onTap: () async {
//                           administrasi();
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: CardIconWithText(
//                         icon: Icons.group,
//                         iconColor: smartRTPrimaryColor,
//                         title: 'Arisan',
//                         onTap: () async {
//                           arisan();
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SB_height15,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: CardIconWithText(
//                         icon: Icons.analytics,
//                         iconColor: smartRTPrimaryColor,
//                         title: 'Performa Saya',
//                         onTap: () async {
//                           performaSaya();
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: CardIconWithText(
//                         icon: Icons.health_and_safety,
//                         iconColor: smartRTPrimaryColor,
//                         title: 'Kesehatan',
//                         onTap: () async {
//                           kesehatan();
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: CardIconWithText(
//                         icon: Icons.close,
//                         iconColor: smartRTPrimaryColor,
//                         title: '-',
//                         onTap: () async {},
//                       ),
//                     ),
//                     Expanded(
//                       child: CardIconWithText(
//                         icon: Icons.close,
//                         iconColor: smartRTPrimaryColor,
//                         title: '-',
//                         onTap: () async {},
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             if (user.user_role == Role.Ketua_RT || user.user_role == Role.Guest)
//               SB_height30,
//             if (user.user_role == Role.Ketua_RT)
//               Row(
//                 children: [
//                   CardBigIconAndText(
//                     icon: Icons.domain_add,
//                     title: 'Konfirmasi Gabung Wilayah',
//                     onTap: () async {
//                       Navigator.pushNamed(
//                           context, KonfirmasiGabungWilayahPage.id);
//                     },
//                   ),
//                 ],
//               ),
//             if (user.user_role == Role.Guest)
//               Row(
//                 children: [
//                   CardBigIconAndText(
//                     icon: Icons.domain_add,
//                     title: 'Gabung Wilayah',
//                     onTap: () async {
//                       gabungWilayah();
//                     },
//                   ),
//                 ],
//               ),
//             const Divider(
//               height: 50,
//               thickness: 5,
//             ),
//             Container(
//               padding: paddingCard,
//               decoration: BoxDecoration(
//                   color: smartRTQuaternaryColor,
//                   borderRadius: const BorderRadius.all(Radius.circular(10))),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'SEBENTAR LAGI !',
//                               style: smartRTTextLarge.copyWith(
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SB_height5,
//                             Text(
//                               'SAATNYA UNTUK PERGANTIAN PENGURUS RT',
//                               style: smartRTTextNormal,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Expanded(
//                         child: Lottie.asset(
//                             'assets/lotties/decoration/team-jump.json',
//                             fit: BoxFit.fitWidth),
//                       ),
//                     ],
//                   ),
//                   SB_height15,
//                   if (isShowJadwal)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'JADWAL',
//                           style: smartRTTextLarge.copyWith(
//                               fontWeight: FontWeight.bold, letterSpacing: 5),
//                         ),
//                         Divider(thickness: 2, color: smartRTSecondaryColor),
//                         SB_height5,
//                         ListTileData4(
//                             title: 'Pendaftaran Panitia',
//                             subTitle:
//                                 '$_dateTenureEndMin60DaysString - $_dateTenureEndMin45DaysString'),
//                         ListTileData4(
//                             title: 'Pendaftaran Calon Pengurus RT',
//                             subTitle:
//                                 '$_dateTenureEndMin44DaysString - $_dateTenureEndMin30DaysString'),
//                         ListTileData4(
//                             title: 'Seleksi dan Kampanye',
//                             subTitle:
//                                 '$_dateTenureEndMin29DaysString - $_dateTenureEndMin15DaysString'),
//                         ListTileData4(
//                             title: 'Pemilihan Pengurus RT Baru',
//                             subTitle: _dateTenureEndMin14DaysString),
//                         ListTileData4(
//                             title: 'Pengumuman Pengurus RT Baru',
//                             subTitle: _dateTenureEndMin13DaysString),
//                         ListTileData4(
//                             title: 'Pergantian Jabatan',
//                             subTitle: _dateTenureEndString),
//                       ],
//                     ),
//                   if (isShowJadwal) SB_height15,
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         if (isShowJadwal) {
//                           isShowJadwal = false;
//                         } else {
//                           isShowJadwal = true;
//                         }
//                       });
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           (isShowJadwal) ? 'TUTUP JADWAL' : 'LIHAT JADWAL',
//                           style: smartRTTextSmall.copyWith(
//                               color: smartRTTertiaryColor),
//                         ),
//                         Icon(
//                             (isShowJadwal)
//                                 ? Icons.keyboard_arrow_up
//                                 : Icons.keyboard_arrow_down,
//                             color: smartRTTertiaryColor)
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             if (isShowWidgetCommitte)
//               const Divider(
//                 height: 50,
//                 thickness: 5,
//               ),
//             if (isShowWidgetCommitte)
//               CardListTileWithButton(
//                 title: titleWidgetCommitte,
//                 subtitle: detailWidgetCommitte,
//                 buttonText: committeTxtBtn1,
//                 onTapButton: committeFuncBtn1,
//                 buttonText2: 'LIHAT PANITIA',
//                 onTapButton2: () {
//                   Navigator.pushNamed(context, LihatPanitiaPage.id);
//                 },
//               ),
//             if (isShowWidgetPengurusRT)
//               const Divider(
//                 height: 50,
//                 thickness: 5,
//               ),
//             if (isShowWidgetPengurusRT)
//               CardListTileWithButton(
//                 title: titleWidgetPengurusRT,
//                 subtitle: detailWidgetPengurusRT,
//                 buttonText: txtBtn1WidgetPengurusRT,
//                 onTapButton: funcBtn1WidgetPengurusRT,
//                 buttonText2: 'LIHAT SEMUA KANDIDAT',
//                 onTapButton2: () {
//                   Navigator.pushNamed(context, LihatSemuaKandidatPage.id);
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//  */