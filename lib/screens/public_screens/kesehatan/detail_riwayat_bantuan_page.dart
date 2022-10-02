import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


class DetailRiwayatBantuanPage extends StatefulWidget {
  static const String id = 'DetailRiwayatBantuanPage';
  const DetailRiwayatBantuanPage({Key? key}) : super(key: key);

  @override
  State<DetailRiwayatBantuanPage> createState() => _DetailRiwayatBantuanPageState();
}

class _DetailRiwayatBantuanPageState extends State<DetailRiwayatBantuanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Bantuan'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status', style: smartRTTextNormalBold_Primary,),
                    Text('Menunggu Konfirmasi', style: smartRTTextNormalBold_Primary,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tingkat Kepentingan', style: smartRTTextNormalBold_Primary,),
                    Text('Butuh Cepat', style: smartRTTextNormalBold_Primary,),
                  ],
                ),
                SB_height30,
                Text('Detail Permintaan', style: smartRTTextNormalBold_Primary,),
                Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', style: smartRTTextNormal_Primary,),
                SB_height30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tanggal Terbuat', style: smartRTTextNormalBold_Primary,),
                    Text('01-10-2022', style: smartRTTextNormal_Primary,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dibuat Oleh', style: smartRTTextNormalBold_Primary,),
                    Text('Laa', style: smartRTTextNormal_Primary,),
                  ],
                ),
                SB_height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tanggal Konfirmasi', style: smartRTTextNormalBold_Primary,),
                    Text('-', style: smartRTTextNormal_Primary,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dikonfirmasi Oleh', style: smartRTTextNormalBold_Primary,),
                    Text('-', style: smartRTTextNormal_Primary,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Catatan', style: smartRTTextNormalBold_Primary,),
                    Text('-', style: smartRTTextNormal_Primary,),
                  ],
                ),
                SB_height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tanggal Selesai', style: smartRTTextNormalBold_Primary,),
                    Text('-', style: smartRTTextNormal_Primary,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Diselesaikan Oleh', style: smartRTTextNormalBold_Primary,),
                    Text('-', style: smartRTTextNormal_Primary,),
                  ],
                ),
                
                
                SB_height15,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Penilaian', style: smartRTTextNormalBold_Primary,),
                    Text('-', style: smartRTTextNormal_Primary,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Ulasan', style: smartRTTextNormalBold_Primary,),
                    Text('-', style: smartRTTextNormal_Primary,),
                  ],
                ),
                
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  /**.... */
                },
                child: Text(
                  'BATALKAN',
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
