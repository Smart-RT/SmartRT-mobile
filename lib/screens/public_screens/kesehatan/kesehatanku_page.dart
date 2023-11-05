import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/health_provider.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_choose_user_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_minta_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/laporan_warga_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_bantuan_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/riwayat_kesehatan_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_primary.dart';
import 'package:smart_rt/widgets/cards/card_list_tile_with_button.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

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
  String ctrLaporanButuhKonfirmasi = '0';

  void getData() async {
    statusKesehatanku = user.is_health == 0 ? 'KURANG SEHAT' : 'SEHAT';
    statusColor = user.is_health == 0 ? smartRTErrorColor : smartRTSuccessColor;
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/health/userReported/needConfirmation/count');
    ctrLaporanButuhKonfirmasi = (resp.data).toString();

    setState(() {});
  }

  void updateSayaSehat() async {
    bool isSukses = await context.read<HealthProvider>().sayaSehat(
          context: context,
        );

    if (!isSukses) {
      // ignore: use_build_context_synchronously
      SmartRTSnackbar.show(context,
          message: 'Gagal! Cobalah beberapa saat lagi!',
          backgroundColor: smartRTErrorColor);
    } else {
      // ignore: use_build_context_synchronously
      SmartRTSnackbar.show(context,
          message: 'Berhasil!', backgroundColor: smartRTSuccessColor);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      Navigator.popAndPushNamed(context, KesehatankuPage.id);
    }
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
      appBar: AppBar(),
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
                      RiwayatKesehatanArguments arguments =
                          RiwayatKesehatanArguments(
                              type: 'Riwayat Kesehatanku');
                      Navigator.pushNamed(context, RiwayatKesehatanPage.id,
                          arguments: arguments);
                    },
                  ),
                  SB_height15,
                  CardListTilePrimary(
                    title: 'Riwayat Bantuan',
                    onTap: () {
                      RiwayatBantuanArguments arguments =
                          RiwayatBantuanArguments(type: 'Tidak');
                      Navigator.pushNamed(context, RiwayatBantuanPage.id,
                          arguments: arguments);
                    },
                  ),
                  (user.user_role == Role.Ketua_RT ||
                          user.user_role == Role.Wakil_RT ||
                          user.user_role == Role.Sekretaris)
                      ? Column(
                          children: [
                            SB_height30,
                            Divider(
                              color: smartRTPrimaryColor,
                              thickness: 1,
                            ),
                            SB_height30,
                            CardListTilePrimary(
                              title: 'Riwayat Kesehatan Wilayah',
                              onTap: () async {
                                RiwayatKesehatanArguments arguments =
                                    RiwayatKesehatanArguments(
                                        type: 'Riwayat Kesehatan Wilayah');
                                Navigator.pushNamed(
                                    context, RiwayatKesehatanPage.id,
                                    arguments: arguments);
                              },
                            ),
                            SB_height15,
                            CardListTilePrimary(
                              title: 'Riwayat Permintaan Bantuan Wilayah',
                              onTap: () async {
                                RiwayatBantuanArguments arguments =
                                    RiwayatBantuanArguments(type: 'Semua');
                                Navigator.pushNamed(
                                    context, RiwayatBantuanPage.id,
                                    arguments: arguments);
                              },
                            ),
                            SB_height15,
                            CardListTilePrimary(
                              title:
                                  'Laporan dari Warga\n[${ctrLaporanButuhKonfirmasi} Laporan Butuh Konfirmasi]',
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, LaporanWargaPage.id);
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
              SB_height30,
              Divider(
                color: smartRTPrimaryColor,
                thickness: 1,
              ),
              SB_height30,
              user.is_health == 0
                  ? Column(
                      children: [
                        CardListTileWithButton(
                          title: 'Anda sudah Sehat?',
                          subtitle:
                              'Jika anda sudah merasa sehat, anda dapat memulihkan status anda menjadi "Sehat" dengan menekan tombol "SAYA SUDAH SEHAT".',
                          buttonText: 'SAYA SUDAH SEHAT',
                          onTapButton: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                  'Hai Sobat Pintar,',
                                  style: smartRTTextTitleCard,
                                ),
                                content: Text(
                                  'Apakah anda yakin sudah sehat?\nSetelah status anda kembali menjadi Sehat, anda sudah tidak dapat meminta bantuan.',
                                  style: smartRTTextNormal.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Tidak'),
                                        child: Text(
                                          'Tidak',
                                          style: smartRTTextNormal.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: smartRTErrorColor2),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          updateSayaSehat();
                                        },
                                        child: Text(
                                          'SAYA YAKIN',
                                          style: smartRTTextNormal.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SB_height30,
                        Divider(
                          color: smartRTPrimaryColor,
                          thickness: 1,
                        ),
                        SB_height30,
                        CardListTileWithButton(
                          title: 'Butuh Bantuan?',
                          subtitle:
                              'Anda dapat meminta bantuan untuk memenuhi keperluan anda ketika kondisi kesehatan anda kurang baik. Hal tersebut bertujuan agar kepulihan kesehatan anda dapat lebih maksimal serta meminimkan penularan jika mempunyai penyakit menular.',
                          buttonText: 'MINTA BANTUAN',
                          onTapButton: () {
                            Navigator.pushNamed(
                                context, FormMintaBantuanPage.id);
                          },
                        ),
                      ],
                    )
                  : CardListTileWithButton(
                      title: 'Anda Kurang Sehat?',
                      subtitle:
                          'Laporkan kesehatan anda segera agar dapat mengakses fitur sesuai dengan kondisi kesehatan anda sekarang.',
                      buttonText: 'LAPOR KESEHATANKU',
                      onTapButton: () {
                        FormLaporKesehatanPageArguments args =
                            FormLaporKesehatanPageArguments(
                                type: 'Diri Sendiri',
                                dataUserTerlaporkan: user);
                        Navigator.pushNamed(context, FormLaporKesehatanPage.id,
                            arguments: args);
                      },
                    ),
              SB_height30,
              Divider(
                color: smartRTPrimaryColor,
                thickness: 1,
              ),
              SB_height30,
              (user.user_role == Role.Ketua_RT ||
                      user.user_role == Role.Wakil_RT ||
                      user.user_role == Role.Sekretaris)
                  ? CardListTileWithButton(
                      title: 'Warga tidak sehat?',
                      subtitle:
                          'Buat laporan kesehatan warga anda segera agar warga anda dapat penanganan dari pengurus RT secara tepat dan cepat.',
                      buttonText: 'BUAT LAPOORAN',
                      onTapButton: () async {
                        Navigator.pushNamed(
                            context, FormLaporKesehatanChooseUserPage.id);
                      })
                  : CardListTileWithButton(
                      title: 'Tetangga tampak kurang sehat?',
                      subtitle:
                          'Laporkan kesehatan tetangga anda segera agar dapat penanganan dari pengurus RT secara tepat dan cepat.',
                      buttonText: 'LAPORKAN TETANGGA',
                      onTapButton: () async {
                        Navigator.pushNamed(
                            context, FormLaporKesehatanChooseUserPage.id);
                      }),
              SB_height30,
              Divider(
                color: smartRTPrimaryColor,
                thickness: 1,
              ),
              SB_height30,
            ],
          ),
        ),
      ),
    );
  }
}
