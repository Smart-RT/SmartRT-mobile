import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardRiwayatArisanWilayah extends StatelessWidget {
  const CardRiwayatArisanWilayah(
      {Key? key,
      required this.periodeKe,
      required this.status,
      required this.statusTextColor,
      required this.totalPertemuan,
      required this.totalAnggota,
      required this.iuran,
      this.onTapDestination,
      this.onTap})
      : super(key: key);

  final String periodeKe;
  final String status;
  final Color statusTextColor;
  final String totalPertemuan;
  final String totalAnggota;
  final String iuran;
  final String? onTapDestination;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.pushNamed(context, onTapDestination!);
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
                    style: smartRTTextNormal.copyWith(color: statusTextColor),
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
