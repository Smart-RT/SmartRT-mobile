import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/list_anggota_arisan_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class DetailDanInformasiArisanPage extends StatefulWidget {
  static const String id = 'DetailDanInformasiArisanPage';
  const DetailDanInformasiArisanPage({Key? key}) : super(key: key);

  @override
  State<DetailDanInformasiArisanPage> createState() =>
      _DetailDanInformasiArisanPageState();
}

class _DetailDanInformasiArisanPageState
    extends State<DetailDanInformasiArisanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail dan Informasi Arisan'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: paddingScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'PERIODE ARISAN KE-1',
                        style: smartRTTextTitleCard_Primary,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SB_height30,
                  // status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'Berlangsung',
                        style: smartRTTextNormalBold_Primary.copyWith(
                            color: smartRTSuccessColor),
                      ),
                    ],
                  ),
                  SB_height15,

                  // jumlah pertemuan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah pertemuan',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '12x',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  // lama periode
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lama Periode',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '1 tahun',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  // tanggal mulai
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal Mulai',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '1 Januari 2023',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  // tanggal berakhir
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Estimasi Tanggal Selesai',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '1 Januari 2024',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  SB_height15,
                  // jumlah anggota
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah Anggota Periode Sekarang',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '12 Orang',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  // jumlah tagihan per pertemuan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah Tagihan per Pertemuan',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'IDR 10.000,00',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  // nominal uang hadiah
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hadiah Pemenang Undian',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'IDR 120.000,00',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  SB_height30,
                  Divider(height: 10, thickness: 2),
                  SB_height30,
                  Text(
                    'PERTEMUAN SELANJUTNYA',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  Text(
                    'Pertemuan Ke-1',
                    style: smartRTTextNormalBold_Primary,
                  ),
                  SB_height15,
                  // tanggal dan waktu pertemuan selanjutnya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal / Waktu',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '1 Januari 2023 / 19.00 WIB',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  // lokasi pertemuan selanjutnya
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lokasi',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'Rumah Pak RT (No 1)',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  SB_height15,
                  // status pemenang
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sudah pernah menang undian?',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'Belum',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  // status tagihan anda
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status Tagihan Anda',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'Belum Bayar',
                        style: smartRTTextNormal_Error2,
                      ),
                    ],
                  ),
                  SB_height15,
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: Text(
                        'Bayar Sekarang',
                        style: smartRTTextLargeBold_Secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 10, thickness: 2),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, ListAnggotaArisanPage.id);
              },
              child: ListTile(
                title: Text(
                  'Lihat Anggota',
                  style: smartRTTextLargeBold_Primary,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: smartRTPrimaryColor,
                ),
              ),
            ),
            Divider(height: 10, thickness: 2),
            ListTile(
              title: Text(
                'Lihat Tagihan dan Absen Kehadiran Saya',
                style: smartRTTextLargeBold_Primary,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: smartRTPrimaryColor,
              ),
            ),
            Divider(height: 10, thickness: 2),
            // ListTile(
            //   title: Text(
            //     'Lihat Riwayat Pertemuan Periode Ini',
            //     style: smartRTTextLargeBold_Primary,
            //   ),
            //   trailing: Icon(
            //     Icons.arrow_forward_ios,
            //     color: smartRTPrimaryColor,
            //   ),
            // ),
            // Divider(height: 10, thickness: 2),
          ],
        ),
      ),
    );
  }
}
