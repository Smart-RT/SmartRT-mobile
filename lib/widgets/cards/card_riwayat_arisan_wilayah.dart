import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundSize),
        ),
        child: Padding(
          padding: paddingCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Periode Ke $periodeKe',
                style: smartRTTextTitleCard.copyWith(
                    fontWeight: FontWeight.bold, color: smartRTQuaternaryColor),
              ),
              Divider(
                height: 10,
                thickness: 1,
                color: smartRTQuaternaryColor,
              ),
              ListTileData1(
                txtLeft: 'Status',
                txtStyleLeft:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtRight: status,
                txtStyleRight:
                    smartRTTextNormal.copyWith(color: statusTextColor),
                txtStyleColon:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
              ),
              ListTileData1(
                txtLeft: 'Iuran',
                txtStyleLeft:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtRight: iuran,
                txtStyleRight:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtStyleColon:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
              ),
              ListTileData1(
                txtLeft: 'Total Anggota',
                txtStyleLeft:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtRight: totalAnggota,
                txtStyleRight:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtStyleColon:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
              ),
              ListTileData1(
                txtLeft: 'Total Pertemuan',
                txtStyleLeft:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtRight: totalPertemuan,
                txtStyleRight:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtStyleColon:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
