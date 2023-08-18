import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area.dart';
import 'package:smart_rt/providers/population_provider.dart';
import 'package:smart_rt/screens/admin_screens/daftar_wilayah_surabaya/lihat_warga_page.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';

class DaftarWilayahSurabayaDetailPageArguments {
  int index;
  DaftarWilayahSurabayaDetailPageArguments({required this.index});
}

class DaftarWilayahSurabayaDetailPage extends StatefulWidget {
  static const String id = 'DaftarWilayahSurabayaDetailPage';
  DaftarWilayahSurabayaDetailPageArguments args;
  DaftarWilayahSurabayaDetailPage({Key? key, required this.args})
      : super(key: key);

  @override
  State<DaftarWilayahSurabayaDetailPage> createState() =>
      DaftarWilayahSurabayaDetailPageState();
}

class DaftarWilayahSurabayaDetailPageState
    extends State<DaftarWilayahSurabayaDetailPage> {
  @override
  Widget build(BuildContext context) {
    int index = widget.args.index;
    Area data = context.watch<PopulationProvider>().listArea[index];
    String txtArea =
        '${StringFormat.formatRTRW(rtNum: data.rt_num.toString(), rwNum: data.rw_num.toString(), isNumOnly: false)}\n${StringFormat.kelurahanFormat(kelurahan: data.data_kelurahan!.name)}, ${StringFormat.kecamatanFormat(kecamatan: data.data_kecamatan!.name)}';
    String ketuaRTNama = data.ketua_id!.full_name;
    String ketuaRTPhone = data.ketua_id!.phone;
    String ketuaRTAddress = data.ketua_id!.address!;
    String ketuaRTAge =
        StringFormat.ageNow(bornDate: data.ketua_id!.born_date!);

    String wakilKetuaRTNama =
        data.wakil_ketua_id != null ? data.wakil_ketua_id!.full_name : '-';
    String wakilKetuaRTPhone =
        data.wakil_ketua_id != null ? data.wakil_ketua_id!.phone : '-';
    String wakilKetuaRTAddress =
        data.wakil_ketua_id != null ? data.wakil_ketua_id!.address! : '-';
    String wakilKetuaRTAge = data.wakil_ketua_id != null
        ? StringFormat.ageNow(bornDate: data.wakil_ketua_id!.born_date!)
        : '-';

    String sekretarisRTNama =
        data.sekretaris_id != null ? data.sekretaris_id!.full_name : '-';
    String sekretarisRTPhone =
        data.sekretaris_id != null ? data.sekretaris_id!.phone : '-';
    String sekretarisRTAddress =
        data.sekretaris_id != null ? data.sekretaris_id!.address! : '-';
    String sekretarisRTAge = data.sekretaris_id != null
        ? StringFormat.ageNow(bornDate: data.sekretaris_id!.born_date!)
        : '-';

    String bendaharaRTNama =
        data.bendahara_id != null ? data.bendahara_id!.full_name : '-';
    String bendaharaRTPhone =
        data.bendahara_id != null ? data.bendahara_id!.phone : '-';
    String bendaharaRTAddress =
        data.bendahara_id != null ? data.bendahara_id!.address! : '-';
    String bendaharaRTAge = data.bendahara_id != null
        ? StringFormat.ageNow(bornDate: data.bendahara_id!.born_date!)
        : '-';

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'DETAIL WILAYAH',
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
                'PENGURUS RT',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SB_height15,
              ListTileData1(txtLeft: 'Ketua RT', txtRight: ketuaRTNama),
              ListTileData1(txtLeft: '', txtRight: ketuaRTAge),
              ListTileData1(txtLeft: '', txtRight: ketuaRTAddress),
              ListTileData1(txtLeft: '', txtRight: ketuaRTPhone),
              SB_height15,
              ListTileData1(
                  txtLeft: 'Wakil Ketua RT', txtRight: wakilKetuaRTNama),
              ListTileData1(txtLeft: '', txtRight: wakilKetuaRTAge),
              ListTileData1(txtLeft: '', txtRight: wakilKetuaRTAddress),
              ListTileData1(txtLeft: '', txtRight: wakilKetuaRTPhone),
              SB_height15,
              ListTileData1(
                  txtLeft: 'Sekretaris RT', txtRight: sekretarisRTNama),
              if (sekretarisRTNama != '-')
                ListTileData1(txtLeft: '', txtRight: sekretarisRTAge),
              if (sekretarisRTNama != '-')
                ListTileData1(txtLeft: '', txtRight: sekretarisRTAddress),
              if (sekretarisRTNama != '-')
                ListTileData1(txtLeft: '', txtRight: sekretarisRTPhone),
              SB_height15,
              ListTileData1(txtLeft: 'Bendahara RT', txtRight: bendaharaRTNama),
              if (bendaharaRTNama != '-')
                ListTileData1(txtLeft: '', txtRight: bendaharaRTAge),
              if (bendaharaRTNama != '-')
                ListTileData1(txtLeft: '', txtRight: bendaharaRTAddress),
              if (bendaharaRTNama != '-')
                ListTileData1(txtLeft: '', txtRight: bendaharaRTPhone),
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
                    Navigator.pushNamed(context, LihatWargaPage.id,
                        arguments: LihatWargaPageArguments(
                            areaID: data.id, title: txtArea));
                  },
                  child: Text(
                    'LIHAT POPULASI',
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
