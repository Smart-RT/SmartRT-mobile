import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_pertemuan_arisan/create_pertemuan_selanjutnya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/daftar_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pengaturan_arisan/pengaturan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/peraturan_dan_tata_cara_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/detail_pertemuan_sebelumnya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/detail_pertemuan_selanjutnya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/riwayat_arisan_saya_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/riwayat_arisan_wilayah_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';
import 'package:smart_rt/widgets/parts/header_arisan.dart';

class ArisanPage extends StatefulWidget {
  static const String id = 'ArisanPage';
  const ArisanPage({Key? key}) : super(key: key);

  @override
  State<ArisanPage> createState() => _ArisanPageState();
}

class _ArisanPageState extends State<ArisanPage> {
  User user = AuthProvider.currentUser!;
  bool isPeriodeBerjalan = false;
  int status = 1;

  void getData() async {
    if (user.area!.lottery_club_id != null) {
      debugPrint('MASUK 1');
      debugPrint('id : ${user.area!.lottery_club_id!.id.toString()}');

      Response<dynamic> resp = await NetUtil().dioClient.get(
          '/lotteryClubs/getLastPeriodeID/${user.area!.lottery_club_id!.id.toString()}');

      debugPrint('MASUK 2');
      if (resp.data != 'Belum ada Periode Arisan') {
        int idPeriodeTerakhir = resp.data;
        debugPrint('ID Periode Terakhir : ${idPeriodeTerakhir}');
        resp = await NetUtil().dioClient.get(
            '/lotteryClubs/checkPertemuanPeriodeBerjalan/${idPeriodeTerakhir.toString()}');
        isPeriodeBerjalan = resp.data == 'true';
      }
    }
    getStatusNow();
  }

  void getStatusNow() {
    debugPrint('lottery_club_id : ${user.area!.lottery_club_id != null}');
    debugPrint('lottery_club_id : ${user.area!.lottery_club_id}');
    debugPrint('user_role : ${user.user_role.index}');
    debugPrint('active : ${user.area!.is_lottery_club_period_active}');
    debugPrint('member : ${user.is_lottery_club_member}');
    debugPrint('berjalan : ${isPeriodeBerjalan}');
    if (user.area!.lottery_club_id == null &&
        user.user_role.index >= 2 &&
        user.user_role.index <= 5) {
      status = 1;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id == null &&
        user.user_role.index == 6) {
      status = 2;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        user.user_role.index >= 2 &&
        user.user_role.index <= 5 &&
        user.area!.is_lottery_club_period_active == 0) {
      status = 3;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        user.user_role.index == 6 &&
        user.area!.is_lottery_club_period_active == 0) {
      status = 4;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        isPeriodeBerjalan &&
        !user.is_lottery_club_member &&
        user.user_role.index == 2) {
      status = 5;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index == 2) {
      status = 6;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        !isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index == 2) {
      status = 7;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index >= 3 &&
        user.user_role.index <= 5) {
      status = 8;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        !isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index >= 3 &&
        user.user_role.index <= 5) {
      status = 9;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        !isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index == 6) {
      status = 10;
      debugPrint('MASUK ${status}');
    } else if (user.area!.lottery_club_id != null &&
        isPeriodeBerjalan &&
        user.is_lottery_club_member &&
        user.user_role.index == 6) {
      status = 11;
      debugPrint('MASUK ${status}');
    }
    debugPrint('LOHAHAHAHA ${status}');
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      getData();
    });
    super.initState();
  }

  Map<int, dynamic> listPage = {
    // Role 3-6, lottery_clubs belum terbuat
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
    // Role 7, lottery_clubs belum terbuat
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
          "nextPageDestination": DaftarArisanPage.id
        }
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods tidak ada yang aktif, role 3-6
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
          "nextPageDestination": RiwayatArisanSayaPage.id
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        }
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods tidak ada yang aktif, role 7
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
          "nextPageDestination": CreatePeriodeArisanPage1.id
        },
        {
          "menuTitle": "Riwayat Arisan Wilayah",
          "nextPageDestination": RiwayatArisanWilayahPage.id,
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
        {
          "menuTitle": "Pengaturan Arisan",
          "nextPageDestination": PengaturanArisanPage.id,
        }
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, sudah berjalan, bukan member, role 3
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
          "nextPageDestination": RiwayatArisanSayaPage.id,
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id,
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, sudah berjalan, member, role 3
    6: {
      "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
      "preTitleStyleColor": smartRTSuccessColor,
      "title": "1 JANUARI 2024",
      "titleStyleColor": smartRTSuccessColor,
      "subTitle": "PK. 19:00 WIB di Rumah Pak RT",
      "subTitleStyleColor": smartRTSecondaryColor,
      "listMenu": [
        {
          "menuTitle": "Detail Pertemuan Selanjutnya",
          "nextPageDestination": DetailPertemuanSelanjutnyaPage.id
        },
        {
          "menuTitle": "Riwayat Arisan Saya",
          "nextPageDestination": RiwayatArisanSayaPage.id
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, belum berjalan, member, role 3
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
          "menuTitle": "Detail Pertemuan Sebelumnya",
          "nextPageDestination": DetailPertemuanSebelumnyaPage.id
        },
        {
          "menuTitle": "Riwayat Periode Sebelumnya",
          "nextPageDestination": RiwayatArisanSayaPage.id
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, sudah berjalan, member, role 4-6
    8: {
      "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
      "preTitleStyleColor": smartRTSuccessColor,
      "title": "1 JANUARI 2024",
      "titleStyleColor": smartRTSuccessColor,
      "subTitle": "PK. 19:00 WIB di Rumah Pak RT",
      "subTitleStyleColor": smartRTSecondaryColor,
      "listMenu": [
        {
          "menuTitle": "Detail Pertemuan Selanjutnya",
          "nextPageDestination": DetailPertemuanSelanjutnyaPage.id
        },
        {
          "menuTitle": "Riwayat Arisan Wilayah",
          "nextPageDestination": RiwayatArisanWilayahPage.id
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, belum di publish, member, role 4-6
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
          "menuTitle": "Detail Pertemuan Sebelumnya",
          "nextPageDestination": DetailPertemuanSebelumnyaPage.id
        },
        {
          "menuTitle": "Riwayat Arisan Wilayah",
          "nextPageDestination": RiwayatArisanWilayahPage.id
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, belum di publish, member, role 7
    10: {
      "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
      "preTitleStyleColor": smartRTErrorColor,
      "title": "BELUM ADA",
      "titleStyleColor": smartRTErrorColor,
      "subTitle":
          "Jadwal pertemuan selanjutnya akan di publikasikan paling lambat tanggal DD MONTH YYYY",
      "subTitleStyleColor": smartRTSecondaryColor,
      "listMenu": [
        {
          "menuTitle": "Buat Pertemuan Selanjutnya",
          "nextPageDestination": CreatePertemuanSelanjutnyaPage.id
        },
        {
          "menuTitle": "Detail Pertemuan Sebelumnya",
          "nextPageDestination": DetailPertemuanSebelumnyaPage.id
        },
        {
          "menuTitle": "Riwayat Arisan Wilayah",
          "nextPageDestination": RiwayatArisanWilayahPage.id
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
        {
          "menuTitle": "Pengaturan Arisan",
          "nextPageDestination": PengaturanArisanPage.id
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, sudah di publish, member, role 7
    11: {
      "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
      "preTitleStyleColor": smartRTSuccessColor,
      "title": "1 JANUARI 2024",
      "titleStyleColor": smartRTSuccessColor,
      "subTitle": "PK. 19:00 WIB di Rumah Pak RT",
      "subTitleStyleColor": smartRTSecondaryColor,
      "listMenu": [
        {
          "menuTitle": "Detail Pertemuan",
          "nextPageDestination": DetailPertemuanSelanjutnyaPage.id
        },
        {
          "menuTitle": "Riwayat Arisan Wilayah",
          "nextPageDestination": RiwayatArisanWilayahPage.id
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
        {
          "menuTitle": "Pengaturan Arisan",
          "nextPageDestination": PengaturanArisanPage.id
        },
      ]
    },
  };

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
                        onTapDestination: listPage[status]["listMenu"][count]
                            ["nextPageDestination"]);
                  }),
            ),
          ],
        ));
  }
}
