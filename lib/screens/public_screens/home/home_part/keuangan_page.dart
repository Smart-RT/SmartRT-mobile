import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/buat_iuran_page.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_list_iuran_page.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/riwayat_transaksi.dart';
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

  @override
  Widget build(BuildContext context) {
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
                  'IDR 0,00',
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
                onTap: () {},
              ),
              Divider(
                thickness: 1,
              ),
              ListTileArisan(
                title: 'Buat Iuran',
                onTap: () {
                  Navigator.pushNamed(context, BuatIuranPage.id);
                },
              ),
              Divider(
                thickness: 1,
              ),
              ListTileArisan(
                title: 'Lihat Semua Iuran',
                onTap: () {
                  Navigator.pushNamed(context, LihatListIuranPage.id);
                },
              ),
              Divider(
                thickness: 1,
              ),
              (user.user_role == Role.Ketua_RT ||
                      user.user_role == Role.Bendahara)
                  ? ListTileArisan(
                      title: 'Riwayat Transaksi Wilayah',
                      onTap: () {
                        Navigator.pushNamed(context, RiwayatTransaksi.id);
                      },
                    )
                  : SizedBox(),
              (user.user_role == Role.Ketua_RT ||
                      user.user_role == Role.Bendahara)
                  ? Divider(
                      thickness: 1,
                    )
                  : SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}
