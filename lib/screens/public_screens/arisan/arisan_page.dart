import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/screens/public_screens/arisan/create_periode_arisan/create_periode_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/daftar_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/detail_dan_informasi_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pengaturan_arisan/pengaturan_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/peraturan_dan_tata_cara_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_saya/riwayat_arisan_saya_page.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';
import 'package:smart_rt/widgets/parts/header_arisan.dart';

class ArisanPage extends StatefulWidget {
  static const String id = 'ArisanPage';
  const ArisanPage({Key? key}) : super(key: key);

  @override
  State<ArisanPage> createState() => _ArisanPageState();
}

class _ArisanPageState extends State<ArisanPage> {
  // int roleUser = 3;
  // bool isArisanCreated = true;
  // bool isArisanMember = false;
  // bool isPeriodeArisanActive = true;
  // int countPertemuanPeriodeArisanActive = 1;

  int status = 4;
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
          "nextPageDestination": RiwayatArisanSayaPage.id,
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
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif namun sudah berjalan, bukan member, role 3
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
          "nextPageDestination": "",
        },
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id,
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, sudah di publish, member, role 3
    6: {
      "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
      "preTitleStyleColor": smartRTSuccessColor,
      "title": "1 JANUARI 2024",
      "titleStyleColor": smartRTSuccessColor,
      "subTitle": "PK. 19:00 WIB di Rumah Pak RT",
      "subTitleStyleColor": smartRTSecondaryColor,
      "listMenu": [
        {
          "menuTitle": "Informasi dan Tagihan Periode Saat Ini",
          "nextPageDestination": ""
        },
        {"menuTitle": "Riwayat Periode Sebelumnya", "nextPageDestination": ""},
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, belum di publish, member, role 3
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
          "menuTitle": "Informasi dan Tagihan Periode Saat Ini",
          "nextPageDestination": ""
        },
        {"menuTitle": "Riwayat Periode Sebelumnya", "nextPageDestination": ""},
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, sudah di publish, member, role 4-6
    8: {
      "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
      "preTitleStyleColor": smartRTSuccessColor,
      "title": "1 JANUARI 2024",
      "titleStyleColor": smartRTSuccessColor,
      "subTitle": "PK. 19:00 WIB di Rumah Pak RT",
      "subTitleStyleColor": smartRTSecondaryColor,
      "listMenu": [
        {
          "menuTitle": "Informasi dan Tagihan Periode Saat Ini",
          "nextPageDestination": ""
        },
        {"menuTitle": "Riwayat Arisan Wilayah", "nextPageDestination": ""},
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
          "menuTitle": "Informasi dan Tagihan Periode Saat Ini",
          "nextPageDestination": ""
        },
        {"menuTitle": "Riwayat Arisan Wilayah", "nextPageDestination": ""},
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
          "menuTitle": "Buat Pertemuan Arisan Selanjutnya Sekarang!",
          "nextPageDestination": ""
        },
        {
          "menuTitle": "Informasi dan Tagihan Periode Saat Ini",
          "nextPageDestination": ""
        },
        {"menuTitle": "Riwayat Arisan Wilayah", "nextPageDestination": ""},
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
        {"menuTitle": "Pengaturan Arisan", "nextPageDestination": ""},
      ]
    },
    // lottery_clubs sudah terbuat, lottery_clubs_periods aktif, sudah di publish, member, role 7
    11: {
      "preTitle": "TANGGAL PERTEMUAN SELANJUTNYA",
      "preTitleStyleColor": smartRTErrorColor,
      "title": "BELUM ADA",
      "titleStyleColor": smartRTErrorColor,
      "subTitle":
          "Jadwal pertemuan selanjutnya akan di publikasikan paling lambat tanggal DD MONTH YYYY",
      "subTitleStyleColor": smartRTSecondaryColor,
      "listMenu": [
        {
          "menuTitle": "Informasi dan Tagihan Periode Saat Ini",
          "nextPageDestination": ""
        },
        {"menuTitle": "Riwayat Arisan Wilayah", "nextPageDestination": ""},
        {
          "menuTitle": "Peraturan dan Tata Cara Arisan",
          "nextPageDestination": PeraturanDanTataCaraArisanPage.id
        },
        {"menuTitle": "Pengaturan Arisan", "nextPageDestination": ""},
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
