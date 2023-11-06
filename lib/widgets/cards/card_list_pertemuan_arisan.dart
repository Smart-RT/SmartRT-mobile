import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(roundSize),
        ),
        child: Padding(
          padding: paddingCard,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Pertemuan Ke ${pertemuanKe}',
                style: smartRTTextTitleCard.copyWith(
                    fontWeight: FontWeight.bold, color: smartRTQuaternaryColor),
              ),
              Divider(
                height: 15,
                thickness: 1,
                color: smartRTQuaternaryColor,
              ),
              ListTileData1(
                txtLeft: 'Status',
                txtStyleLeft:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtRight: status,
                txtStyleRight: smartRTTextNormal.copyWith(color: statusColor),
                txtStyleColon:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
              ),
              ListTileData1(
                txtLeft: 'Tanggal',
                txtStyleLeft:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtRight: tanggalPelaksanaan,
                txtStyleRight:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtStyleColon:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
              ),
              ListTileData1(
                txtLeft: 'Waktu',
                txtStyleLeft:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtRight: waktuPelaksanaan,
                txtStyleRight:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtStyleColon:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
              ),
              ListTileData1(
                txtLeft: 'Tempat',
                txtStyleLeft:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtRight: tempatPelaksanaan,
                txtStyleRight:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
                txtStyleColon:
                    smartRTTextNormal.copyWith(color: smartRTQuaternaryColor),
              ),
              status != 'Unpublished'
                  ? ListTileData1(
                      txtLeft: 'Anggota Hadir',
                      txtStyleLeft: smartRTTextNormal.copyWith(
                          color: smartRTQuaternaryColor),
                      txtRight: jumlahAnggotaHadir,
                      txtStyleRight: smartRTTextNormal.copyWith(
                          color: smartRTQuaternaryColor),
                      txtStyleColon: smartRTTextNormal.copyWith(
                          color: smartRTQuaternaryColor),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
