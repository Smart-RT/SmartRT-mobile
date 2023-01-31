import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardRiwayatArisanWilayah extends StatelessWidget {
  const CardRiwayatArisanWilayah({
    Key? key,
    required this.periodeKe,
    required this.status,
    required this.totalPertemuan,
    required this.totalAnggota,
    required this.iuran,
    required this.onTapDestination,
  }) : super(key: key);

  final String periodeKe;
  final String status;
  final String totalPertemuan;
  final String totalAnggota;
  final String iuran;
  final String onTapDestination;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, onTapDestination);
      },
      child: Card(
        color: smartRTPrimaryColor,
        child: Padding(
          padding: paddingCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Periode Ke ${periodeKe}',
                style: smartRTTextTitleCard.copyWith(
                    fontWeight: FontWeight.bold, color: smartRTSecondaryColor),
              ),
              Row(
                children: [
                  Text(
                    'Status : ',
                    style: smartRTTextNormal.copyWith(
                        color: smartRTSecondaryColor),
                  ),
                  Text(
                    status,
                    style:
                        smartRTTextNormal.copyWith(color: smartRTSuccessColor2),
                  ),
                ],
              ),
              SB_height15,
              Text(
                'Iuran : ${iuran}',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
              Text(
                'Total Anggota : ${totalAnggota} orang',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
              Text(
                'Total Pertemuan : ${totalPertemuan}',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
