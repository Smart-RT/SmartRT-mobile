import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_pertemuan_arisan/create_pertemuan_selanjutnya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_arisan/create_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/peraturan_dan_tata_cara/peraturan_dan_tata_cara_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_detail_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_periode_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';
import 'package:smart_rt/widgets/parts/header_arisan.dart';
import 'package:intl/intl.dart';

class ArisanPage extends StatefulWidget {
  static const String id = 'ArisanPage';
  const ArisanPage({Key? key}) : super(key: key);

  @override
  State<ArisanPage> createState() => _ArisanPageState();
}

class _ArisanPageState extends State<ArisanPage> {
  User user = AuthProvider.currentUser!;
  bool isPeriodeBerjalan = false;
  int status = 0;
  String tanggalPertemuan = '';
  String tanggalPalingLambat = '';
  String waktuPertemuan = '';
  String tempatPertemuan = '';
  LotteryClubPeriodDetail? dataPertemuan;
  int? idPeriodeTerakhir;
  Map<int, dynamic> listPage = {
    0: {
      "preTitle": "",
      "preTitleStyleColor": smartRTPrimaryColor,
      "title": "",
      "titleStyleColor": smartRTPrimaryColor,
      "subTitle": "",
      "subTitleStyleColor": smartRTPrimaryColor,
      "listMenu": []
    },
  };

  void getListPage() {
    listPage = {
      0: {
        "preTitle": "",
        "preTitleStyleColor": smartRTPrimaryColor,
        "title": "",
        "titleStyleColor": smartRTPrimaryColor,
        "subTitle": "",
        "subTitleStyleColor": smartRTPrimaryColor,
        "listMenu": []
      },
      // ROLE 3-6, ! LOTTERY_CLUBS
      1: {
        "preTitle": "Wilayah Anda Belum Membuka Arisan",
        "preTitleStyleColor": smartRTErrorColor,
        "title": "",
        "titleStyleColor": smartRTPrimaryColor,
        "subTitle":
            "Hubungi Ketua RT Anda untuk membuka fitur arisan dan nikmati fasilitas yang telah disediakan !",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": []
      },
      // ROLE 7  , ! LOTTERY_CLUBS
      2: {
        "preTitle": "Wilayah Anda Belum Membuka Arisan",
        "preTitleStyleColor": smartRTErrorColor,
        "title": "",
        "titleStyleColor": smartRTPrimaryColor,
        "subTitle":
            "Buka fitur arisan dengan memilih 'Daftarkan Sekarang' dan nikmati fasilitas yang telah disediakan!",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Daftarkan Sekarang",
            "onTap": () {
              Navigator.pushNamed(context, CreateArisanPage.id);
            },
          },
        ],
      },
      // ROLE 3-6, LOTTERY_CLUBS  , ! LOTTERY_CLUB_PERIODS
      3: {
        "preTitle":
            "Wilayah Anda sedang Tidak Memiliki Periode Arisan Aktif untuk Diikuti",
        "preTitleStyleColor": smartRTErrorColor,
        "title": "",
        "titleStyleColor": smartRTPrimaryColor,
        "subTitle": "Mohon menunggu periode selanjutnya!",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Riwayat Arisan Saya",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'saya');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            },
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            }
          }
        ]
      },
      // ROLE 7  , LOTTERY_CLUBS  , ! LOTTERY_CLUB_PERIODS
      4: {
        "preTitle":
            "Wilayah Anda sedang Tidak Memiliki Periode Arisan yang Aktif ",
        "preTitleStyleColor": smartRTErrorColor,
        "title": "",
        "titleStyleColor": smartRTPrimaryColor,
        "subTitle": "Jangan lupa buat periode arisan sekarang !",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Buat Periode Arisan Sekarang!",
            "onTap": () {
              Navigator.pushNamed(context, CreatePeriodeArisanPage1.id);
            }
          },
          {
            "menuTitle": "Riwayat Arisan Wilayah",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'wilayah');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            },
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            }
          },
          // {
          //   "menuTitle": "Pengaturan Arisan",
          //   "onTap": PengaturanArisanPage.id,
          // }
        ]
      },
      // ROLE 3  , LOTTERY_CLUBS  , LOTTERY_CLUB_PERIODS   , ! MEMBER
      5: {
        "preTitle": "Periode Arisan telah Berjalan",
        "preTitleStyleColor": smartRTErrorColor,
        "title": "",
        "titleStyleColor": smartRTPrimaryColor,
        "subTitle":
            "Maaf, anda tidak dapat bergabung pada periode ini dikarenakan telah berjalan. Harap menunggu Periode Selanjutnya!",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Riwayat Arisan Saya",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'saya');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            },
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            },
          },
        ]
      },
      // ROLE 3  , LOTTERY_CLUBS  , LOTTERY_CLUB_PERIODS   , MEMBER   , PUBLISHED
      6: {
        "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
        "preTitleStyleColor": smartRTSuccessColor,
        "title": tanggalPertemuan,
        "titleStyleColor": smartRTSuccessColor,
        "subTitle": "PK. $waktuPertemuan WIB di $tempatPertemuan",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Detail Pertemuan Selanjutnya",
            "onTap": () {
              RiwayatArisanPertemuanDetailArguments arguments =
                  RiwayatArisanPertemuanDetailArguments(
                dataPeriodeArisan: dataPertemuan!.lottery_club_period_id!,
                typeFrom: 'Detail Pertemuan',
                dataPertemuan: dataPertemuan!,
                periodeKe: dataPertemuan!.period_ke.toString(),
                pertemuanKe: dataPertemuan!.pertemuan_ke.toString(),
              );
              Navigator.pushNamed(context, RiwayatArisanPertemuanDetailPage.id,
                  arguments: arguments);
            }
          },
          {
            "menuTitle": "Riwayat Arisan Saya",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'saya');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            }
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            }
          },
        ]
      },
      // ROLE 3  , LOTTERY_CLUBS  , LOTTERY_CLUB_PERIODS   , MEMBER   , UNPUBLISHED
      7: {
        "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
        "preTitleStyleColor": smartRTErrorColor,
        "title": "BELUM ADA",
        "titleStyleColor": smartRTErrorColor,
        "subTitle":
            "Jadwal pertemuan selanjutnya akan di publikasikan paling lambat tanggal DD MONTH YYYY",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Riwayat Arisan Saya",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'saya');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            }
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            }
          },
        ]
      },
      // ROLE 4-6, LOTTERY_CLUBS  , LOTTERY_CLUB_PERIODS   , MEMBER   , PUBLISHED
      8: {
        "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
        "preTitleStyleColor": smartRTSuccessColor,
        "title": tanggalPertemuan,
        "titleStyleColor": smartRTSuccessColor,
        "subTitle": "PK. $waktuPertemuan WIB di $tempatPertemuan",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Detail Pertemuan Selanjutnya",
            "onTap": () {
              RiwayatArisanPertemuanDetailArguments arguments =
                  RiwayatArisanPertemuanDetailArguments(
                dataPeriodeArisan: dataPertemuan!.lottery_club_period_id!,
                typeFrom: 'Detail Pertemuan',
                dataPertemuan: dataPertemuan!,
                periodeKe: dataPertemuan!.period_ke.toString(),
                pertemuanKe: dataPertemuan!.pertemuan_ke.toString(),
              );
              Navigator.pushNamed(context, RiwayatArisanPertemuanDetailPage.id,
                  arguments: arguments);
            }
          },
          {
            "menuTitle": "Riwayat Arisan Wilayah",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'wilayah');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            }
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            }
          },
        ]
      },
      // ROLE 4-6, LOTTERY_CLUBS  , LOTTERY_CLUB_PERIODS   , MEMBER   , UNPUBLISHED
      9: {
        "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
        "preTitleStyleColor": smartRTErrorColor,
        "title": "BELUM ADA",
        "titleStyleColor": smartRTErrorColor,
        "subTitle":
            "Jadwal pertemuan selanjutnya akan di publikasikan paling lambat tanggal DD MONTH YYYY",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Riwayat Arisan Wilayah",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'wilayah');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            }
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            }
          },
        ]
      },
      // ROLE 7  , LOTTERY_CLUBS  , LOTTERY_CLUB_PERIODS   , MEMBER   , UNPUBLISHED
      10: {
        "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
        "preTitleStyleColor": smartRTErrorColor,
        "title": "BELUM ADA",
        "titleStyleColor": smartRTErrorColor,
        "subTitle":
            "Jadwal pertemuan selanjutnya akan di publikasikan paling lambat tanggal \n$tanggalPalingLambat",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Buat Pertemuan Selanjutnya",
            "onTap": () {
              Navigator.pushNamed(context, CreatePertemuanSelanjutnyaPage.id);
            }
          },
          {
            "menuTitle": "Riwayat Arisan Wilayah",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'wilayah');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            }
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            }
          },
          // {
          //   "menuTitle": "Pengaturan Arisan",
          //   "onTap": PengaturanArisanPage.id
          // },
        ]
      },
      // ROLE 4-6, LOTTERY_CLUBS  , LOTTERY_CLUB_PERIODS   , MEMBER   , PUBLISHED
      11: {
        "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
        "preTitleStyleColor": smartRTSuccessColor,
        "title": tanggalPertemuan,
        "titleStyleColor": smartRTSuccessColor,
        "subTitle": "PK. $waktuPertemuan WIB di $tempatPertemuan",
        "subTitleStyleColor": smartRTSecondaryColor,
        "listMenu": [
          {
            "menuTitle": "Detail Pertemuan",
            "onTap": () {
              RiwayatArisanPertemuanDetailArguments arguments =
                  RiwayatArisanPertemuanDetailArguments(
                dataPeriodeArisan: dataPertemuan!.lottery_club_period_id!,
                typeFrom: 'Detail Pertemuan',
                dataPertemuan: dataPertemuan!,
                periodeKe: dataPertemuan!.period_ke.toString(),
                pertemuanKe: dataPertemuan!.pertemuan_ke.toString(),
              );
              Navigator.pushNamed(context, RiwayatArisanPertemuanDetailPage.id,
                  arguments: arguments);
            }
          },
          {
            "menuTitle": "Riwayat Arisan Wilayah",
            "onTap": () {
              RiwayatArisanPeriodeArguments args =
                  RiwayatArisanPeriodeArguments(type: 'wilayah');
              Navigator.pushNamed(context, RiwayatArisanPeriodePage.id,
                  arguments: args);
            }
          },
          {
            "menuTitle": "Peraturan dan Tata Cara Arisan",
            "onTap": () {
              Navigator.pushNamed(context, PeraturanDanTataCaraArisanPage.id);
            }
          },
        ]
      },
    };
  }

  void getData() async {
    if (user.area!.lottery_club_id != null) {
      // Mendapatkan ID Periode Terakhir
      Response<dynamic> resp = await NetUtil().dioClient.get(
          '/lotteryClubs/getLastPeriodeID/${user.area!.lottery_club_id!.id.toString()}');

      debugPrint('GET DATA');
      debugPrint('====================================');
      debugPrint('Resp Data (Last Periode ID): ${resp.data.toString()}');

      if (resp.data != 'Belum ada Periode Arisan') {
        debugPrint('====================================');
        debugPrint('-> Masuk IF ! Belum Ada Periode Arisan');

        idPeriodeTerakhir = resp.data;

        // Mengecek apakah Periode tersebut sudah mempunyai pertemuan yang berjalan (dipublish)
        resp = await NetUtil().dioClient.get(
            '/lotteryClubs/checkPertemuanPeriodeBerjalan/${idPeriodeTerakhir.toString()}');
        isPeriodeBerjalan = resp.data == 'true';
        debugPrint('====================================');
        debugPrint(
            'Resp Data Check Pertemuan Berjalan : ${isPeriodeBerjalan.toString()}');

        getStatusNow();
        debugPrint('STATUS $status');
        debugPrint('PERIODE TRAKHIR ${idPeriodeTerakhir.toString()}');
        if (status == 11 || status == 8 || status == 6) {
          //Mendapatkan data Pertemuan
          resp = await NetUtil().dioClient.get(
              '/lotteryClubs/getPeriodDetail/status/Published/id-periode/${idPeriodeTerakhir.toString()}');

          dataPertemuan = LotteryClubPeriodDetail.fromData(resp.data);
          tanggalPertemuan =
              DateFormat('d MMMM y', 'id_ID').format(dataPertemuan!.meet_date);
          waktuPertemuan =
              DateFormat('H:m', 'id_ID').format(dataPertemuan!.meet_date);
          tempatPertemuan = dataPertemuan!.meet_at.toString();
        } else if (status == 10) {
          Response<dynamic> respPertemuan = await NetUtil().dioClient.get(
              '/lotteryClubs/getPeriodDetail/status/Unpublished/id-periode/$idPeriodeTerakhir');
          LotteryClubPeriodDetail dataPertemuan =
              LotteryClubPeriodDetail.fromData(respPertemuan.data);
          tanggalPalingLambat = DateFormat('d MMMM y', 'id_ID').format(
              dataPertemuan.meet_date.subtract(const Duration(days: 3)));
        }
      }
    }
    getStatusNow();
    getListPage();
    setState(() {});
  }

  void getStatusNow() async {
    debugPrint('====================================1');
    debugPrint('====================================2');
    debugPrint('====================================3');
    debugPrint('lottery_club_id : ${user.area!.lottery_club_id != null}');
    debugPrint('lottery_club_id : ${user.area!.lottery_club_id}');
    debugPrint('user_role : ${user.user_role.index}');
    debugPrint('active : ${user.area!.is_lottery_club_period_active}');
    debugPrint('member : ${user.is_lottery_club_member}');
    debugPrint('berjalan : $isPeriodeBerjalan');
    if (user.area!.lottery_club_id == null &&
        user.user_role.index >= 2 &&
        user.user_role.index <= 5) {
      status = 1;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id == null &&
        user.user_role.index == 6) {
      status = 2;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        user.user_role.index >= 2 &&
        user.user_role.index <= 5 &&
        user.area!.is_lottery_club_period_active == 0) {
      status = 3;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        user.user_role.index == 6 &&
        user.area!.is_lottery_club_period_active == 0) {
      status = 4;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        isPeriodeBerjalan &&
        !user.is_lottery_club_member &&
        user.user_role.index == 2) {
      status = 5;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index == 2) {
      status = 6;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        !isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index == 2) {
      status = 7;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index >= 3 &&
        user.user_role.index <= 5) {
      status = 8;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        !isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index >= 3 &&
        user.user_role.index <= 5) {
      status = 9;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        !isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index == 6) {
      status = 10;
      debugPrint('MASUK STATUS : $status');
    } else if (user.area!.lottery_club_id != null &&
        isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index == 6) {
      status = 11;
      debugPrint('MASUK STATUS : $status');
    }
    debugPrint('====================================3');
    debugPrint('====================================2');
    debugPrint('====================================1');
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Arisan'),
        ),
        body: Column(
          children: [
            HeaderArisan(
                preTitle: listPage[status]["preTitle"],
                title: listPage[status]["title"],
                subTitle: listPage[status]["subTitle"],
                preTitleColor: listPage[status]["preTitleStyleColor"],
                titleColor: listPage[status]["titleStyleColor"],
                subTitleColor: listPage[status]["subTitleStyleColor"]),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, int) {
                    return Divider(
                      color: smartRTPrimaryColor,
                      height: 5,
                    );
                  },
                  itemCount: listPage[status]["listMenu"].length,
                  itemBuilder: (context, count) {
                    return ListTileArisan(
                      title: listPage[status]["listMenu"][count]["menuTitle"],
                      onTap: listPage[status]["listMenu"][count]["onTap"],
                    );
                  }),
            ),
          ],
        ));
  }
}
