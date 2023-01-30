import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/widgets/cards/card_periode_arisan.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class DetailRiwayatArisanSayaPage extends StatefulWidget {
  static const String id = 'DetailRiwayatArisanSayaPage';
  const DetailRiwayatArisanSayaPage({Key? key}) : super(key: key);

  @override
  State<DetailRiwayatArisanSayaPage> createState() =>
      _DetailRiwayatArisanSayaPageState();
}

class _DetailRiwayatArisanSayaPageState
    extends State<DetailRiwayatArisanSayaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Arisan Saya'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'DETAIL PERIODE KE-X',
                style: smartRTTextTitleCard.copyWith(
                  color: smartRTPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SB_height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tanggal Pertemuan Pertama',
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
                    'Tanggal Pertemuan Terakhir',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    '21 Januari 2022',
                    style: smartRTTextLarge,
                  ),
                ],
              ),
              SB_height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jumlah Pertemuan',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    '12x (1 tahun)',
                    style: smartRTTextLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Anggota',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    '20 Orang',
                    style: smartRTTextLarge,
                  ),
                ],
              ),
              SB_height15,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Iuran Pertemuan',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    'Rp 10.000,00',
                    style: smartRTTextLarge,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nominal Pemenang',
                    style: smartRTTextLarge,
                  ),
                  Text(
                    'Rp 200.000,00',
                    style: smartRTTextLarge,
                  ),
                ],
              ),
              SB_height30,
              Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: Text(
                      'RIWAYAT PERTEMUAN',
                      style: smartRTTextLarge.copyWith(
                        color: smartRTPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Iuran',
                        style: smartRTTextLarge.copyWith(
                          color: smartRTPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        'Absensi',
                        style: smartRTTextLarge.copyWith(
                          color: smartRTPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ),
              Divider(height: 20, thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pertemuan Ke-1',
                          style: smartRTTextNormal.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        Text('21 Januari 2021 Pk 12.00 WIB',
                            style: smartRTTextNormal),
                        Text('Lokasi di Rumah Pak RT',
                            style: smartRTTextNormal),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.check,
                            color: Color.fromARGB(255, 0, 255, 13),
                          ),
                          Text('01-01-21', style: smartRTTextSmall,),
                          Text('Offline', style: smartRTTextSmall,),
                        ],
                      ),),
                  const Expanded(
                      flex: 3,
                      child: Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 0, 255, 13),
                      )),
                ],
              ),
              Divider(height: 20, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pertemuan Ke-2',
                          style: smartRTTextNormal.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        Text('21 Januari 2021 Pk 12.00 WIB',
                            style: smartRTTextNormal),
                        Text('Lokasi di Rumah Pak RT',
                            style: smartRTTextNormal),
                      ],
                    ),
                  ),
                  const Expanded(
                      flex: 3,
                      child: Icon(
                        Icons.close,
                        color: Color.fromARGB(255, 255, 0, 0),
                      )),
                  const Expanded(
                      flex: 3,
                      child: Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 0, 255, 13),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
