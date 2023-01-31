import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class DetailPertemuanSebelumnyaPage extends StatefulWidget {
  static const String id = 'DetailPertemuanSebelumnyaPage';
  const DetailPertemuanSebelumnyaPage({Key? key}) : super(key: key);

  @override
  State<DetailPertemuanSebelumnyaPage> createState() =>
      _DetailPertemuanSebelumnyaPageState();
}

class _DetailPertemuanSebelumnyaPageState
    extends State<DetailPertemuanSebelumnyaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: paddingScreen,
              child: Column(
                children: [
                  Text(
                    'DETAIL PERTEMUAN KE X',
                    style: smartRTTextTitleCard.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'PERIODE KE X',
                    style: smartRTTextLarge,
                    textAlign: TextAlign.center,
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tanggal Pertemuan',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        '1 Januari 2021',
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tempat Pertemuan',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        'Rumah Pak RT',
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Iuran Arisan',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        'Rp 30.000,00',
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Status Iuran',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        'Belum bayar',
                        style: smartRTTextLarge.copyWith(
                            color: smartRTErrorColor2),
                      ),
                    ],
                  ),
                  SB_height15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pemenang 1',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        '-',
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pemenang 2',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        '-',
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
                title: 'Bayar Iuran Sekarang',
                onTapDestination: PembayaranIuranArisan.id),
            Divider(
              height: 25,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
