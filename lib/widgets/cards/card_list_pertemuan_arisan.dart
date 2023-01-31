import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardListPertemuanArisan extends StatelessWidget {
  const CardListPertemuanArisan({
    Key? key,
    required this.pertemuanKe,
    required this.jumlahAnggotaHadir,
    required this.tempatPelaksanaan,
    required this.tanggalPelaksanaan,
    required this.onTapDestination,
  }) : super(key: key);

  final String pertemuanKe;
  final String jumlahAnggotaHadir;
  final String tempatPelaksanaan;
  final String tanggalPelaksanaan;
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
                'Pertemuan Ke ${pertemuanKe}',
                style: smartRTTextTitleCard.copyWith(
                    fontWeight: FontWeight.bold, color: smartRTSecondaryColor),
              ),
              SB_height15,
              Text(
                'Tanggal : ${tanggalPelaksanaan}',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
              Text(
                'Tempat : ${tempatPelaksanaan}',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
              Text(
                'Jumlah Anggota Hadir : ${jumlahAnggotaHadir} orang',
                style: smartRTTextLarge.copyWith(color: smartRTSecondaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
