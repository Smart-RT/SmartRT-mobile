import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/buat_iuran_page.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_list_iuran_page.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/riwayat_transaksi_ku.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/riwayat_transaksi_wilayah.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/tagihan_saya_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({
    Key? key,
  }) : super(key: key);

  @override
  State<KeuanganPage> createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {
  User user = AuthProvider.currentUser!;
  void getData() async {
    await context.read<AreaBillProvider>().getTotalTagihanKu();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int totalTagihanKu = context.watch<AreaBillProvider>().totalTagihanSaya;
    return Column(
      children: [
        Container(
          color: smartRTPrimaryColor,
          width: double.infinity,
          child: Padding(
            padding: paddingScreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'TAGIHAN BELUM DIBAYAR',
                  style:
                      smartRTTextTitleCard.copyWith(color: smartRTErrorColor),
                  textAlign: TextAlign.center,
                ),
                Text(
                  CurrencyFormat.convertToIdr(totalTagihanKu, 2),
                  style: smartRTTextTitle.copyWith(color: smartRTErrorColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              ListTileArisan(
                title: 'Tagihan Saya',
                onTap: () async {
                  await Navigator.pushNamed(context, TagihanSayaPage.id);
                  getData();
                },
              ),
              Divider(
                thickness: 1,
              ),
              if (user.user_role == Role.Ketua_RT ||
                  user.user_role == Role.Bendahara)
                ListTileArisan(
                  title: 'Buat Iuran',
                  onTap: () async {
                    await Navigator.pushNamed(context, BuatIuranPage.id);
                    getData();
                  },
                ),
              if (user.user_role == Role.Ketua_RT ||
                  user.user_role == Role.Bendahara)
                Divider(
                  thickness: 1,
                ),
              ListTileArisan(
                title: 'Lihat Semua Iuran',
                onTap: () async {
                  await Navigator.pushNamed(context, LihatListIuranPage.id);
                  getData();
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTileArisan(
                title: 'Riwayat Transaksiku',
                onTap: () async {
                  await Navigator.pushNamed(context, RiwayatTransaksiKu.id);
                  getData();
                },
              ),
              Divider(
                thickness: 1,
              ),
              if (user.user_role == Role.Ketua_RT ||
                  user.user_role == Role.Bendahara)
                ListTileArisan(
                  title: 'Riwayat Transaksi Wilayah',
                  onTap: () async {
                    await Navigator.pushNamed(
                        context, RiwayatTransaksiWilayah.id);
                    getData();
                  },
                ),
              if (user.user_role == Role.Ketua_RT ||
                  user.user_role == Role.Bendahara)
                Divider(
                  thickness: 1,
                ),
            ],
          ),
        )
      ],
    );
  }
}
