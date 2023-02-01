import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class DaftarArisanPage extends StatefulWidget {
  static const String id = 'DaftarArisanPage';
  const DaftarArisanPage({Key? key}) : super(key: key);

  @override
  State<DaftarArisanPage> createState() => _DaftarArisanPageState();
}

class _DaftarArisanPageState extends State<DaftarArisanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buka Arisan di Wilayahku'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: paddingScreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kelebihan membuka arisan di aplikasi ini
                  Column(
                    children: [
                      Text(
                        'KELEBIHAN MEMBUKA ARISAN DI APLIKASI INI',
                        style: smartRTTextLargeBold_Primary,
                        textAlign: TextAlign.center,
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
                              'Semua anggota arisan akan menerima notifikasi pengumuman pertemuan selanjutnya ketika sudah di publikasikan oleh Ketua RT melalui aplikasi ini.',
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
                              'Anggota arisan dapat melakukan pembayaran tagihan per pertemuan dengan 2 cara yaitu ONLINE, dengan langsung membayarkan melalui aplikasi dimana dana akan dikirimkan ke E-DOMPET WILAYAH dan dapat di tarik oleh Bendahara dan/atau Ketua RT, dan secara OFFLINE, dimana anggota akan langsung membayarkan tagihan ke Bendahara atau Ketua RT, dan setelah itu Bendahara atau Ketua RT dapat memperbarui status pembayaran anggota tersebut di aplikasi ini.',
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
                              'Semua transaksi dan hasil pertemuan yang dilakukan melalui aplikasi ini akan tercatat dengan rapi dan aman.',
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
                              'Pengacakan anggota terpilih menjadi pemenang dalam suatu pertemuan menjadi mudah, aman dan meminimalkan kecurangan.',
                              style: smartRTTextNormal_Primary,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SB_height30,
                  // Tata cara dan ketentuan
                  Column(
                    children: [
                      Text(
                        'TATA CARA DAN KETENTUAN',
                        style: smartRTTextLargeBold_Primary,
                        textAlign: TextAlign.center,
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
                              'Daftarkan wilayah anda untuk membuka arisan dengan menekan tombol "DAFTAR SEKARANG" di halaman bawah ini.',
                              style: smartRTTextNormal_Primary,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      SB_height15,
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Expanded(
                      //       child: Text('2.', style: smartRTTextNormal_Primary),
                      //     ),
                      //     Expanded(
                      //       flex: 10,
                      //       child: Column(
                      //         children: [
                      //           Text(
                      //             'Setelah mendaftar, anda dapat membuat Arisan Periode Pertama wilayah Anda. Pada Periode Pertama, akan terdapat 2 tipe yang dapat dipilih, yaitu MULAI BARU dan MULAI DITENGAH.',
                      //             style: smartRTTextNormal_Primary,
                      //             textAlign: TextAlign.justify,
                      //           ),
                      //           SB_height15,
                      //           Text(
                      //             'Tipe MULAI BARU adalah tipe untuk wilayah yang ingin membuat dan melakukan arisan dari pertemuan awal hingga akhir.',
                      //             style: smartRTTextNormal_Primary,
                      //             textAlign: TextAlign.justify,
                      //           ),
                      //           SB_height15,
                      //           Text(
                      //             'Tipe MULAI DITENGAH adalah tipe untuk wilayah yang periode arisannya sedang berjalan diluar aplikasi dan ingin melanjutkan dengan menggunakan bantuan aplikasi ini.',
                      //             style: smartRTTextNormal_Primary,
                      //             textAlign: TextAlign.justify,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SB_height15,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text('2.', style: smartRTTextNormal_Primary),
                          ),
                          Expanded(
                            flex: 10,
                            child: Column(
                              children: [
                                Text(
                                  'Setelah mendaftar, anda dapat membuat Periode Arisan Pertama wilayah anda. Periode arisan hanya dapat dibuat jika telah memenuhi syarat. Berikut merupakan syarat yang harus dipenuhi.',
                                  style: smartRTTextNormal_Primary,
                                  textAlign: TextAlign.justify,
                                ),
                                SB_height15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '- ',
                                        style: smartRTTextNormal_Primary,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Text(
                                        'Wilayah tersebut tidak memiliki periode arisan yang masih berjalan atau aktif',
                                        style: smartRTTextNormal_Primary,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                SB_height15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '- ',
                                        style: smartRTTextNormal_Primary,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Text(
                                        'Minimal anggota arisan 6 akun dan maksimal 48 akun.',
                                        style: smartRTTextNormal_Primary,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ],
                                ),
                                SB_height15,
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '- ',
                                        style: smartRTTextNormal_Primary,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 10,
                                      child: Text(
                                        'Menginputkan tagihan arisan per pertemuan, panjang periode, serta tanggal dimulai.',
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
                              'Setelah periode arisan terbuat, anda masih dapat mengelola anggota, tempat dan tanggal pertemuan selanjutnya, tagihan per pertemuan, dan panjang periode arisan jika periode arisan tersebut belum mempublikasikan pertemuan pertama ke semua anggota periode arisan tersebut.',
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
                              'Ketua RT dapat mempublikasikan pertemuan selanjutnya yang telah diatur sebelum H-7 (kurang tujuh hari) pelaksanaan pertemuan pertama. Ketika H-7 pertemuan pertama belum di publikasikan, maka sistem secara otomatis akan mempublikasikan. Tempat dan tanggal pertemuan pertama akan menjadi default dari periode tersebut.',
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
                            child: Text('5.', style: smartRTTextNormal_Primary),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(
                              'Pertemuan akan dilakukan setiap sebulan sekali hingga jatuh tempo jangka periode yang ditentukan. Dalam 1x pertemuan, minimal akan ada 1 pemenang dan maksimal 2 pemenang.',
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
                            child: Text('6.', style: smartRTTextNormal_Primary),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(
                              'Para anggota dapat melakukan pembayaran tagihan hingga sebelum pengundian pemenang.',
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
                            child: Text('7.', style: smartRTTextNormal_Primary),
                          ),
                          Expanded(
                            flex: 10,
                            child: Text(
                              'Pengundian pemenang hanya dapat dilakukan oleh Ketua RT dan hasilnya dapat dilihat oleh seluruh anggota melalui aplikasi ini. Pemenang akan menerima hadiah sebesar [ tagihan arisan x jumlah anggota ] secara offline (dana tagihan yang di bayar melalui aplikasi dapat di ambil oleh Ketua RT atau Bendahara). Anggota yang telah menjadi pemenang sudah tidak dapat menjadi pemenang lagi dalam pengundian di pertemuan selanjutnya periode saat ini.',
                              style: smartRTTextNormal_Primary,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  /**
                           * Ketika di tekan maka akan manggil back end untuk insert ke lottery_clubs dan kembali ke halaman arisan_page
                           */
                },
                child: Text(
                  'DAFTAR SEKARANG',
                  style: smartRTTextLargeBold_Secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
