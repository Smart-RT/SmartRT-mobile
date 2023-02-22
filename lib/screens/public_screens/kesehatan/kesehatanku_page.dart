import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_choose_user_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page_1.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_minta_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatanku_page.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_primary.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_button.dart';

class KesehatankuPage extends StatefulWidget {
  static const String id = 'KesehatankuPage';
  const KesehatankuPage({Key? key}) : super(key: key);

  @override
  State<KesehatankuPage> createState() => _KesehatankuPageState();
}

class _KesehatankuPageState extends State<KesehatankuPage> {
  User user = AuthProvider.currentUser!;
  String statusKesehatanku = '';
  Color statusColor = smartRTSuccessColor;

  void getData() async {
    statusKesehatanku = user.is_health == 0 ? 'KURANG SEHAT' : 'SEHAT';
    statusColor = user.is_health == 0 ? smartRTErrorColor : smartRTSuccessColor;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kesehatanku'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: paddingCard,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: smartRTPrimaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: smartRTShadowColor,
                            spreadRadius: 5,
                            blurRadius: 25),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Kesehatanku Sekarang',
                          style: smartRTTextLargeBold_Secondary,
                        ),
                        Text(
                          statusKesehatanku,
                          style: smartRTTextTitle.copyWith(color: statusColor),
                        ),
                      ],
                    ),
                  ),
                  SB_height15,
                  CardListTilePrimary(
                    title: 'Riwayat Kesehatanku',
                    onTap: () {
                      Navigator.pushNamed(context, RiwayatKesehatankuPage.id);
                    },
                  ),
                  SB_height15,
                  CardListTilePrimary(
                    title: 'Riwayat Bantuan',
                    onTap: () {
                      Navigator.pushNamed(context, RiwayatBantuanPage.id);
                    },
                  ),
                ],
              ),
              SB_height30,
              const Divider(
                thickness: 5,
              ),
              SB_height30,
              CardListTileWithButton(
                title: 'Anda Kurang Sehat?',
                subtitle:
                    'Laporkan kesehatan anda segera agar dapat mengakses fitur sesuai dengan kondisi kesehatan anda sekarang.',
                buttonText: 'LAPOR KESEHATANKU',
                onTapButton: () {
                  FormLaporKesehatanPageArguments args =
                      FormLaporKesehatanPageArguments(
                          type: 'Diri Sendiri', dataUserTerlaporkan: user);
                  Navigator.pushNamed(context, FormLaporKesehatanPage.id,
                      arguments: args);
                },
              ),
              SB_height30,
              const Divider(
                thickness: 5,
              ),
              SB_height30,
              CardListTileWithButton(
                  title: 'Tetangga tampak kurang sehat?',
                  subtitle:
                      'Laporkan kesehatan tetangga anda segera agar dapat penanganan dari pengurus RT secara tepat dan cepat.',
                  buttonText: 'LAPORKAN TETANGGA',
                  onTapButton: () async {
                    Navigator.pushNamed(
                        context, FormLaporKesehatanChooseUserPage.id);
                  }),
              SB_height30,
              const Divider(
                thickness: 5,
              ),
              SB_height30,
              Column(
                children: [
                  Text(
                    'Butuh Bantuan?',
                    style: smartRTTextTitle_Primary,
                  ),
                  SB_height15,
                  Text(
                    'Anda dapat meminta bantuan untuk memenuhi keperluan anda ketika kondisi kesehatan anda kurang baik. Hal tersebut bertujuan agar kepulihan kesehatan anda dapat lebih maksimal serta meminimkan penularan jika mempunyai penyakit menular.',
                    style: smartRTTextNormal_Primary,
                    textAlign: TextAlign.justify,
                  ),
                  SB_height30,
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, FormMintaBantuanPage.id);
                      },
                      child: Text(
                        'MINTA BANTUAN',
                        style: smartRTTextLargeBold_Secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
