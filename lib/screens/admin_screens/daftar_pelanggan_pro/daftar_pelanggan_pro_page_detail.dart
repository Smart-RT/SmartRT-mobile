import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/models/subscribe/pro_subscribe_bill.dart';
import 'package:smart_rt/providers/population_provider.dart';
import 'package:smart_rt/providers/subscribe_provider.dart';
import 'package:smart_rt/screens/admin_screens/daftar_wilayah_surabaya/lihat_warga_page.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';
import 'package:smart_rt/screens/admin_screens/daftar_pelanggan_pro/daftar_pelanggan_pro_bill_page.dart';

class DaftarPelangganProPageDetailArguments {
  int index;
  DaftarPelangganProPageDetailArguments({required this.index});
}

class DaftarPelangganProPageDetail extends StatefulWidget {
  static const String id = 'DaftarPelangganProPageDetail';
  DaftarPelangganProPageDetailArguments args;
  DaftarPelangganProPageDetail({Key? key, required this.args})
      : super(key: key);

  @override
  State<DaftarPelangganProPageDetail> createState() =>
      DaftarPelangganProPageDetailState();
}

class DaftarPelangganProPageDetailState
    extends State<DaftarPelangganProPageDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = widget.args.index;
    Area data = context.watch<SubscribeProvider>().listAreaLangganan[index];

    String txtArea =
        '${StringFormat.formatRTRW(rtNum: data.rt_num.toString(), rwNum: data.rw_num.toString(), isNumOnly: false)}\n${StringFormat.kelurahanFormat(kelurahan: data.data_kelurahan!.name)}, ${StringFormat.kecamatanFormat(kecamatan: data.data_kecamatan!.name)}';
    String ketuaRTNama = data.ketua_id!.full_name;
    String ketuaRTPhone = data.ketua_id!.phone;
    String ketuaRTAddress = data.ketua_id!.address!;
    String ketuaRTAge =
        StringFormat.ageNow(bornDate: data.ketua_id!.born_date!);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'DETAIL PEMBAYARAN',
                style: smartRTTextTitle,
                textAlign: TextAlign.center,
              ),
              Text(
                txtArea,
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              ListTileData1(
                  txtLeft: 'Total Populasi',
                  txtRight: '${data.total_population} pengguna aplikasi'),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              Text(
                'DATA KETUA RT',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SB_height15,
              ListTileData1(txtLeft: 'Ketua RT', txtRight: ketuaRTNama),
              ListTileData1(txtLeft: '', txtRight: ketuaRTAge),
              ListTileData1(txtLeft: '', txtRight: ketuaRTAddress),
              ListTileData1(txtLeft: '', txtRight: ketuaRTPhone),
              const Divider(
                height: 50,
                thickness: 2,
              ),
              Text(
                'DATA TAGIHAN',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SB_height15,
              ListTileData1(
                  txtLeft: 'Status Bulan Ini',
                  txtRight: data.dataSubscribe!.status == 0
                      ? 'Menunggu Pembayaran'
                      : data.dataSubscribe!.status == 1
                          ? 'Telah Membayar'
                          : 'Berhenti Berlangganan'),
              ListTileData1(
                  txtLeft: 'Pembayaran Terakhir',
                  txtRight: data.dataSubscribe!.latest_payment_at != null
                      ? StringFormat.formatDate(
                          dateTime: data.dataSubscribe!.latest_payment_at!)
                      : '-'),
              if (data.dataSubscribe!.latest_payment_at != null)
                ListTileData1(
                    txtLeft: 'Pembayaran Selanjutnya',
                    txtRight: StringFormat.formatDate(
                        dateTime: data.dataSubscribe!.latest_payment_at!
                            .add(Duration(days: 30)),
                        isWithTime: false)),
              ListTileData1(
                  txtLeft: 'Batas Akhir Pembayaran',
                  txtRight: data.dataSubscribe!.latest_payment_at != null
                      ? StringFormat.formatDate(
                          dateTime: data.dataSubscribe!.latest_payment_at!
                              .add(Duration(days: 37)),
                          isWithTime: false)
                      : StringFormat.formatDate(
                          dateTime: data.dataSubscribe!.created_at
                              .add(Duration(days: 7)),
                          isWithTime: false)),
              const Divider(
                height: 50,
                thickness: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: smartRTPrimaryColor,
                  ),
                  onPressed: () async {
                    Navigator.pushNamed(context, DaftarPelangganProBillPage.id,
                        arguments: DaftarPelangganProBillPageArguments(
                            idArea: data.id));
                  },
                  child: Text(
                    'LIHAT RIWAYAT TAGIHAN',
                    style: smartRTTextLarge.copyWith(
                        fontWeight: FontWeight.bold,
                        color: smartRTSecondaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
