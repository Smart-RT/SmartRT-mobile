import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class CardPeriodeArisan extends StatelessWidget {
  const CardPeriodeArisan(
      {Key? key,
      required this.periodeKe,
      required this.status,
      required this.startedAt,
      required this.iuranPertemuan,
      required this.jumlahPertemuan,
      required this.totalAnggota,
      required this.statusColor,
      required this.onTapDestination})
      : super(key: key);

  final String periodeKe;
  final String status;
  final Color statusColor;
  final String startedAt;
  final String iuranPertemuan;
  final String jumlahPertemuan;
  final String totalAnggota;
  final String onTapDestination;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: smartRTShadowColor,
      elevation: 5,
      color: smartRTQuaternaryColor,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Periode Ke-' + periodeKe,
              style: smartRTTextLarge.copyWith(
                color: smartRTPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Status : ' + status,
              style: smartRTTextSmall.copyWith(color: statusColor),
              textAlign: TextAlign.center,
            ),
            SB_height15,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Dimulai tanggal',
                      style: smartRTTextSmall,
                    ),
                    Text(
                      startedAt,
                      style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Iuran Pertemuan',
                      style: smartRTTextSmall,
                    ),
                    Text(
                      iuranPertemuan,
                      style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SB_height15,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Jumlah Pertemuan',
                      style: smartRTTextSmall,
                    ),
                    Text(
                      jumlahPertemuan,
                      style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Total Anggota',
                      style: smartRTTextSmall,
                    ),
                    Text(
                      totalAnggota,
                      style: smartRTTextNormal.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SB_height15,
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {Navigator.pushNamed(context, onTapDestination);},
                child: Text(
                  'LIHAT SELENGKAPNYA',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold,
                      color: smartRTSecondaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
