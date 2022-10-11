import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'Berjalan',
                        style: smartRTTextNormalBold_Primary.copyWith(
                            color: smartRTSuccessColor),
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Periode Arisan Ke-',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '1',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lama per Periode',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '1 tahun',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah Tagihan per Pertemuan',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'IDR 100.000,00',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nominal Uang yang Diberikan',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'IDR 1.000.000,00',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Kas Seluruh Periode',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'IDR 100.000.000,00',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  SB_height50,
                  Text(
                    'JADWAL SELANJUTNYA',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal Pertemuan Selanjutnya',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '1 Februari 2022',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Waktu Pertemuan Selanjutnya',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '10:00 AM',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tempat Pertemuan Selanjutnya',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        '',
                        style: smartRTTextNormal_Primary,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '',
                        style: smartRTTextNormalBold_Primary,
                      ),
                      Text(
                        'Rumah Pak RT\n Jl. Kalijudan Taruna V no 4',
                        style: smartRTTextNormal_Primary,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  SB_height50,
                  Text(
                    'PERATURAN DAN TATA CARA ARISAN',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  SB_height15,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('1.', style: smartRTTextNormal_Primary),
                      ),
                       Expanded(
                        flex: 10,
                        child: Text('Anggota arisan dapat melihat jadwal pertemuan yang telah terjadwalkan dan hadir sesuai jadwal tersebut (Pastikan kehadiran anda telah dicentang oleh pengurus arisan pada aplikasi ini).', style: smartRTTextNormal_Primary, textAlign: TextAlign.justify,),
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('2.', style: smartRTTextNormal_Primary),
                      ),
                       Expanded(
                        flex: 10,
                        child: Text('Bayarlah tagihan setiap pertemuan arisan sesuai dengan nominal yang telah ditentukan. Anda dapat membayar dengan melalui aplikasi atau langsung melalui bendahara (pastikan setelah anda membayar, status pembayaran anda menjadi lunas)', style: smartRTTextNormal_Primary, textAlign: TextAlign.justify,),
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('3.', style: smartRTTextNormal_Primary),
                      ),
                       Expanded(
                        flex: 10,
                        child: Text('Setelah proses absensi dan pembayaran selesai, maka akan memasuki tahap pengambilan nama pemenang pada pertemuan ini. Daftar nama yang akan berada dalam pengundian adalah nama anggota yang belum pernah menjadi pemenang dalam periode ini, anggota yang tidak memiliki tunggakan dalam pembayaran tagihan arisan, dan anggota yang hadir pada pertemuan saat ini. Nama pemenang dapat dilihat oleh para anggota di hasil pertemuan saat ini.', style: smartRTTextNormal_Primary, textAlign: TextAlign.justify,),
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text('4.', style: smartRTTextNormal_Primary),
                      ),
                       Expanded(
                        flex: 10,
                        child: Text('Anggota yang terpilih menjadi pemenang akan menerima sejumlah uang pada E-Dompet Saya sesuai dengan nominal yang telah ditentukan pada periode ini. (Anggota yang telah menjadi pemenang tetap wajib menjalankan tanggung jawabnya dengan hadir serta melunasi tagihan di pertemuan-pertemuan selanjutnya. Jika tidak maka dapat di blacklist dari arisan periode selanjutnya.)', style: smartRTTextNormal_Primary, textAlign: TextAlign.justify,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(height: 10, thickness: 2),
            ListTile(
              title: Text(
                'Lihat Anggota Periode Ini',
                style: smartRTTextLargeBold_Primary,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: smartRTPrimaryColor,
              ),
            ),
            Divider(height: 10, thickness: 2),
            ListTile(
              title: Text(
                'Lihat Semua Transaksi Arisan Periode Ini',
                style: smartRTTextLargeBold_Primary,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: smartRTPrimaryColor,
              ),
            ),
            Divider(height: 10, thickness: 2),
            ListTile(
              title: Text(
                'Lihat Riwayat Semua Periode Arisan',
                style: smartRTTextLargeBold_Primary,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: smartRTPrimaryColor,
              ),
            ),
            Divider(height: 10, thickness: 2),
          ],
        ),
      ),
    );
  }
}
