import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class PeraturanDanTataCaraArisanPage extends StatefulWidget {
  static const String id = 'PeraturanDanTataCaraArisanPage';
  const PeraturanDanTataCaraArisanPage({Key? key}) : super(key: key);

  @override
  State<PeraturanDanTataCaraArisanPage> createState() =>
      _PeraturanDanTataCaraArisanPageState();
}

class _PeraturanDanTataCaraArisanPageState
    extends State<PeraturanDanTataCaraArisanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peraturan dan Tata Cara Arisan'),
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
                        child: Text(
                          'Anggota arisan dapat melihat jadwal pertemuan yang telah dijadwalkan dan hadir sesuai jadwal tersebut (Pastikan kehadiran anda telah dicentang oleh pengurus arisan pada aplikasi ini).',
                          style: smartRTTextNormal_Primary,
                          textAlign: TextAlign.justify,
                        ),
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
                        child: Text(
                          'Bayarlah tagihan setiap pertemuan arisan sesuai dengan nominal yang telah ditentukan. Anda dapat membayar dengan melalui aplikasi atau langsung melalui bendahara (pastikan setelah anda membayar, status pembayaran anda menjadi lunas)',
                          style: smartRTTextNormal_Primary,
                          textAlign: TextAlign.justify,
                        ),
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
                        child: Text(
                          'Setelah proses absensi dan pembayaran selesai, maka akan memasuki tahap pengambilan nama pemenang pada pertemuan ini. Daftar nama yang akan berada dalam pengundian adalah nama anggota yang belum pernah menjadi pemenang dalam periode ini, anggota yang tidak memiliki tunggakan dalam pembayaran tagihan arisan, dan anggota yang hadir pada pertemuan saat ini. Nama pemenang dapat dilihat oleh para anggota di hasil pertemuan saat ini.',
                          style: smartRTTextNormal_Primary,
                          textAlign: TextAlign.justify,
                        ),
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
                        child: Text(
                          'Anggota yang terpilih menjadi pemenang akan menerima uang sebanyak jumlah tagihan perpertemuan yang dikalikan dengan jumlah anggota pada periode ini. Uang akan diberikan oleh Ketua RT atau Bendahara secara langsung. (Anggota yang telah menjadi pemenang tetap wajib menjalankan tanggung jawabnya dengan hadir serta melunasi tagihan di pertemuan-pertemuan selanjutnya. Jika tidak maka dapat di blacklist dari arisan periode selanjutnya.)',
                          style: smartRTTextNormal_Primary,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
