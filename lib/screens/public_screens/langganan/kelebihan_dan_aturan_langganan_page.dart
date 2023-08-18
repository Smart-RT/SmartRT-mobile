import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class KelebihanDanAturanLangganan extends StatefulWidget {
  static const String id = 'KelebihanDanAturanLangganan';
  const KelebihanDanAturanLangganan({Key? key}) : super(key: key);

  @override
  State<KelebihanDanAturanLangganan> createState() =>
      _KelebihanDanAturanLanggananState();
}

class _KelebihanDanAturanLanggananState
    extends State<KelebihanDanAturanLangganan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelebihan dan Aturan'),
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
                    'KELEBIHAN DAN ATURAN BERGABUNG SMART RT PRO',
                    style: smartRTTextTitleCard,
                    textAlign: TextAlign.center,
                  ),
                  const Divider(
                    height: 50,
                    thickness: 10,
                  ),
                  Text(
                    'KELEBIHAN',
                    style: smartRTTextTitleCard,
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
                          'Seluruh anggota wilayah dapat mengakses fitur meminta bantuan ketika kesehatan sedang tidak baik dan Pengurus RT dapat memberikan bantuan yang dibutuhkan dengan cepat.',
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
                          'Pengurus RT dapat membuka tugas pada suatu acara dan seluruh anggota wilayah dapat mengambil tugas tersebut sesuai dengan syarat pada tugas tersebut.',
                          style: smartRTTextNormal_Primary,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 50,
                    thickness: 10,
                  ),
                  Text(
                    'ATURAN',
                    style: smartRTTextTitleCard,
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
                          'Wilayah yang telah mendaftar dan bergabung di SMART RT PRO harus melakukan pembayaran setiap bulannya.',
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
                          'Pembayaran hanya dapat dilakukan melalui aplikasi ini dan akan diberikan kompensasi waktu sebanyak 15 hari dari waktu jatuh tempo pembayaran.',
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
                          'Jika setelah 15 hari dari waktu jatuh tempo masih belum membayar, maka akan diangap berhenti berlangganan dan fitur yang dapat diakses kembali menjadi SMART RT FREE.',
                          style: smartRTTextNormal_Primary,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 50,
                    thickness: 10,
                  ),
                  Text(
                    'Apakah anda setuju dengan kelebihan serta aturan yang berlaku dan ingin mendaftarkan wilayah anda menjadi SMART RT PRO?',
                    style: smartRTTextNormal_Primary,
                    textAlign: TextAlign.justify,
                  ),
                  SB_height15,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ))),
                      onPressed: () async {
                        Response<dynamic> resp = await NetUtil()
                            .dioClient
                            .post('/subscribe-pro/add');
                        if (resp.statusCode.toString() == '200') {
                          SmartRTSnackbar.show(context,
                              message: resp.data,
                              backgroundColor: smartRTSuccessColor);
                        } else {
                          SmartRTSnackbar.show(context,
                              message: resp.data,
                              backgroundColor: smartRTErrorColor);
                        }
                      },
                      child: Text(
                        'IYA, DAFTAR SEKARANG !',
                        style: smartRTTextLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: smartRTQuaternaryColor),
                      ),
                    ),
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
