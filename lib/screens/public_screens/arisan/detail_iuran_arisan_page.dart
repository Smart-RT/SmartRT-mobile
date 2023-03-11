import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/absen_anggota_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_iuran_arisan_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_absensi_pertemuan_arisan_page.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';

class DetailIuranArisanArguments {
  LotteryClubPeriodDetailBill dataPembayaran;
  String pertemuanKe;
  DetailIuranArisanArguments(
      {required this.dataPembayaran, required this.pertemuanKe});
}

class DetailIuranArisanPage extends StatefulWidget {
  static const String id = 'DetailIuranArisanPage';
  DetailIuranArisanArguments args;
  DetailIuranArisanPage({Key? key, required this.args}) : super(key: key);

  @override
  State<DetailIuranArisanPage> createState() => _DetailIuranArisanPageState();
}

class _DetailIuranArisanPageState extends State<DetailIuranArisanPage> {
  LotteryClubPeriodDetailBill? dataPembayaran;
  User user = AuthProvider.currentUser!;
  String pertemuanKe = '';
  String statusPembayaran = '';
  Color statusPembayaranColor = smartRTSuccessColor;
  String totalTagihan = 'IDR 0';
  String pembayaranVia = '';
  String tanggalPembayaran = '';
  String dikonfirmasiOleh = '';
  String namaAnggota = '';
  String alamatAnggota = '';
  int idUser = -1;

  void konfirmasiBayarCash() async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin $namaAnggota sudah membayar sejumlah $totalTagihan dengan via CASH?\n\nPastikan anda telah menerima uang tersebut!',
          style: smartRTTextNormal.copyWith(fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Tidak'),
                child: Text(
                  'Tidak',
                  style: smartRTTextNormal.copyWith(
                      fontWeight: FontWeight.bold, color: smartRTErrorColor2),
                ),
              ),
              TextButton(
                onPressed: () {
                  bayarCash();
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
  }

  void bayarCash() async {
    Response<dynamic> resp =
        await NetUtil().dioClient.patch('/lotteryClubs/payment/cash', data: {
      "id_bill": dataPembayaran!.id,
    });
    if (resp.statusCode.toString() == '200') {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pop(context);

      LihatIuranArisanPageArguments args = LihatIuranArisanPageArguments(
          idPertemuan: dataPembayaran!.lottery_club_period_detail_id.toString(),
          pertemuanKe: pertemuanKe);
      Navigator.pushNamed(context, LihatIuranArisanPertemuanPage.id,
          arguments: args);
      resp = await NetUtil()
          .dioClient
          .get('/lotteryClubs/payment/idPayment/${dataPembayaran!.id}');

      LotteryClubPeriodDetailBill tempData =
          LotteryClubPeriodDetailBill.fromData(resp.data);
      DetailIuranArisanArguments arguments = DetailIuranArisanArguments(
          dataPembayaran: tempData, pertemuanKe: pertemuanKe);
      Navigator.pushNamed(context, DetailIuranArisanPage.id,
          arguments: arguments);

      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  void getData() async {
    dataPembayaran = widget.args.dataPembayaran;
    pertemuanKe = widget.args.pertemuanKe;

    statusPembayaran = dataPembayaran!.status == 0 ? 'Belum Bayar' : 'Lunas';
    statusPembayaranColor =
        dataPembayaran!.status == 0 ? smartRTErrorColor2 : smartRTSuccessColor2;

    totalTagihan = CurrencyFormat.convertToIdr(dataPembayaran!.bill_amount, 2);
    namaAnggota = dataPembayaran!.data_user!.full_name;
    alamatAnggota = dataPembayaran!.data_user!.address!;

    if (dataPembayaran!.status == 1) {
      pembayaranVia = dataPembayaran!.payment_type!;
    } else {
      idUser = dataPembayaran!.user_id!;
    }

    if (dataPembayaran!.updated_at != null) {
      tanggalPembayaran =
          DateFormat('d MMMM y HH:mm').format(dataPembayaran!.updated_at!);
      dikonfirmasiOleh = dataPembayaran!.data_user_konfirmasi!.full_name;
    }

    setState(() {});
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
        title: Text(''),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'DETAIL PEMBAYARAN',
                  style: smartRTTextTitleCard.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'ARISAN',
                  style: smartRTTextTitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Divider(
                  thickness: 2,
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Iuran Pertemuan Ke',
                      style: smartRTTextLarge,
                    ),
                    Text(
                      pertemuanKe,
                      style: smartRTTextLarge,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Nama Anggota',
                        style: smartRTTextLarge,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        namaAnggota,
                        style: smartRTTextLarge,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '',
                        style: smartRTTextLarge,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        alamatAnggota,
                        style: smartRTTextLarge,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  thickness: 2,
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status Pembayaran',
                      style: smartRTTextLarge,
                    ),
                    Text(
                      statusPembayaran,
                      style: smartRTTextLarge.copyWith(
                          color: statusPembayaranColor),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Tagihan',
                      style: smartRTTextLarge,
                    ),
                    Text(
                      totalTagihan,
                      style: smartRTTextLarge,
                    ),
                  ],
                ),
                pembayaranVia != ''
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pembayaran VIA',
                                style: smartRTTextLarge,
                              ),
                              Text(
                                pembayaranVia,
                                style: smartRTTextLarge.copyWith(
                                    color: statusPembayaranColor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Tanggal Pembayaran',
                                style: smartRTTextLarge,
                              ),
                              Text(
                                tanggalPembayaran,
                                style: smartRTTextLarge.copyWith(
                                    color: statusPembayaranColor),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Dikonfirmasi Oleh',
                                style: smartRTTextLarge,
                              ),
                              Text(
                                dikonfirmasiOleh,
                                style: smartRTTextLarge.copyWith(
                                    color: statusPembayaranColor),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(),
                const Divider(
                  thickness: 2,
                  height: 50,
                ),
              ],
            ),
            statusPembayaran == 'Belum Bayar'
                ? Column(
                    children: [
                      idUser == user.id
                          ? Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {},
                                    child: Text(
                                      'BAYAR SEKARANG',
                                      style: smartRTTextLargeBold_Secondary,
                                    ),
                                  ),
                                ),
                                SB_height15,
                              ],
                            )
                          : const SizedBox(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            konfirmasiBayarCash();
                          },
                          child: Text(
                            'KONFIRMASI BAYAR CASH',
                            style: smartRTTextLargeBold_Secondary,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
