import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';

class CardListArea extends StatelessWidget {
  const CardListArea({
    Key? key,
    required this.kecamatan,
    required this.kelurahan,
    required this.rtNum,
    required this.rwNum,
    required this.totalPopulasi,
    required this.ketuaRTNama,
    required this.ketuaRTAlamat,
    required this.ketuaRTTelp,
    this.onTap,
  }) : super(key: key);

  final String kecamatan;
  final String kelurahan;
  final String rtNum;
  final String rwNum;
  final String totalPopulasi;
  final String ketuaRTNama;
  final String ketuaRTAlamat;
  final String ketuaRTTelp;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Padding(
        padding: paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                StringFormat.formatRTRW(
                    rtNum: rtNum, rwNum: rwNum, isNumOnly: false),
                style: smartRTTextLargeBold_Primary),
            Text(
              '$kelurahan, $kecamatan',
              style: smartRTTextLargeBold_Primary,
            ),
            SB_height15,
            ListTileData1(
                txtLeft: 'Total Pengguna', txtRight: '$totalPopulasi Orang'),
            ListTileData1(
                txtLeft: 'Ketua RT', txtRight: '$ketuaRTNama ($ketuaRTTelp)'),
            ListTileData1(txtLeft: 'Alamat', txtRight: ketuaRTAlamat),
          ],
        ),
      ),
    );
  }
}
