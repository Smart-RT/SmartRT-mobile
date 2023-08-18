import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';

class CardListSubscribe extends StatelessWidget {
  const CardListSubscribe({
    Key? key,
    required this.kecamatan,
    required this.kelurahan,
    required this.rtNum,
    required this.rwNum,
    required this.status,
    this.onTap,
  }) : super(key: key);

  final String kecamatan;
  final String kelurahan;
  final String rtNum;
  final String rwNum;
  final String status;
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
            ListTileData1(txtLeft: 'Status Bulan Ini', txtRight: status),
          ],
        ),
      ),
    );
  }
}
