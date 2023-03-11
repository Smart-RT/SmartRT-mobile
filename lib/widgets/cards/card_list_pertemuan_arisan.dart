import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardListPertemuanArisan extends StatelessWidget {
  const CardListPertemuanArisan({
    Key? key,
    required this.status,
    this.statusColor,
    required this.pertemuanKe,
    required this.jumlahAnggotaHadir,
    required this.tempatPelaksanaan,
    required this.tanggalPelaksanaan,
    required this.waktuPelaksanaan,
    this.onTapDestination,
    this.onTap,
  }) : super(key: key);

  final String status;
  final Color? statusColor;
  final String pertemuanKe;
  final String jumlahAnggotaHadir;
  final String tempatPelaksanaan;
  final String waktuPelaksanaan;
  final String tanggalPelaksanaan;
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
                'Pertemuan Ke ${pertemuanKe}',
                style: smartRTTextTitleCard.copyWith(
                    fontWeight: FontWeight.bold, color: smartRTSecondaryColor),
              ),
              Row(
                children: [
                  Text(
                    'Status : ',
                    style:
                        smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
                  ),
                  Text(
                    status,
                    style: smartRTTextLarge.copyWith(
                        color: statusColor ?? smartRTSecondaryColor),
                  ),
                ],
              ),
              SB_height15,
              Text(
                'Tanggal : ${tanggalPelaksanaan}',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
              Text(
                'Waktu : ${waktuPelaksanaan}',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
              Text(
                'Tempat : ${tempatPelaksanaan}',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
              status != 'Unpublished'
                  ? Text(
                      'Jumlah Anggota Hadir : ${jumlahAnggotaHadir} orang',
                      style: smartRTTextLarge.copyWith(
                          color: smartRTSecondaryColor),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
