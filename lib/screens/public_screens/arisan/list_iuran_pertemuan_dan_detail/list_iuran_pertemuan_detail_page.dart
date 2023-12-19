import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/list_iuran_pertemuan_dan_detail/list_iuran_pertemuan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_arisan/pembayaran_iuran_arisan_page_1.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_arisan/pembayaran_iuran_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan/riwayat_arisan_pertemuan_detail_page.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';

import '../riwayat_arisan/riwayat_arisan_pertemuan_page.dart';

class ListIuranPertemuanDetailArgument {
  LotteryClubPeriodDetailBill dataPembayaran;
  LotteryClubPeriodDetail dataPertemuan;
  String pertemuanKe;
  String typeFrom;
  ListIuranPertemuanDetailArgument({
    required this.dataPembayaran,
    required this.dataPertemuan,
    required this.pertemuanKe,
    required this.typeFrom,
  });
}

class ListIuranPertemuanDetailPage extends StatefulWidget {
  static const String id = 'ListIuranPertemuanDetailPage';
  ListIuranPertemuanDetailArgument args;
  ListIuranPertemuanDetailPage({Key? key, required this.args})
      : super(key: key);

  @override
  State<ListIuranPertemuanDetailPage> createState() =>
      _ListIuranPertemuanDetailPageState();
}

class _ListIuranPertemuanDetailPageState
    extends State<ListIuranPertemuanDetailPage> {
  LotteryClubPeriodDetailBill? dataPembayaran;
  User user = AuthProvider.currentUser!;
  String pertemuanKe = '';
  String statusPembayaran = '';
  Color statusPembayaranColor = smartRTStatusGreenColor;
  String totalTagihan = 'IDR 0';
  String pembayaranVia = '';
  String tanggalPembayaran = '';
  String dikonfirmasiOleh = 'System';
  String namaAnggota = '';
  String alamatAnggota = '';
  int idUser = -1;
  LotteryClubPeriodDetail? dataPertemuan;
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
      if (widget.args.typeFrom.toLowerCase() == 'riwayat') {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);

        RiwayatArisanPertemuanArguments arguments =
            RiwayatArisanPertemuanArguments(
          idPeriode: dataPertemuan!.lottery_club_period_id!.id.toString(),
          periodeKe: dataPertemuan!.lottery_club_period_id!.period.toString(),
          dataPeriodeArisan: dataPertemuan!.lottery_club_period_id!,
        );
        Navigator.pushNamed(context, RiwayatArisanPertemuanPage.id,
            arguments: arguments);
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }

      Response<dynamic> respPertemuanBaru = await NetUtil()
          .dioClient
          .get('/lotteryClubs/get/meet/id-pertemuan/${dataPertemuan!.id}');
      LotteryClubPeriodDetail dataPertemuanBaru =
          LotteryClubPeriodDetail.fromData(respPertemuanBaru.data);

      RiwayatArisanPertemuanDetailArguments arguments2 =
          RiwayatArisanPertemuanDetailArguments(
        dataPertemuan: dataPertemuanBaru,
        periodeKe: dataPertemuanBaru.period_ke.toString(),
        pertemuanKe: dataPertemuanBaru.pertemuan_ke.toString(),
        typeFrom: widget.args.typeFrom,
        dataPeriodeArisan: dataPertemuanBaru.lottery_club_period_id!,
      );
      Navigator.pushNamed(context, RiwayatArisanPertemuanDetailPage.id,
          arguments: arguments2);

      ListIuranPertemuanArgument arguments3 = ListIuranPertemuanArgument(
          dataPertemuan: dataPertemuanBaru,
          typeFrom: widget.args.typeFrom,
          idPertemuan: dataPertemuanBaru.id.toString(),
          pertemuanKe: dataPertemuanBaru.pertemuan_ke.toString());
      Navigator.pushNamed(context, ListIuranPertemuanPage.id,
          arguments: arguments3);

      Response<dynamic> respPembayaranBaru = await NetUtil()
          .dioClient
          .get('/lotteryClubs/payment/idPayment/${dataPembayaran!.id}');
      LotteryClubPeriodDetailBill dataPembayaranBaru =
          LotteryClubPeriodDetailBill.fromData(respPembayaranBaru.data);

      ListIuranPertemuanDetailArgument arguments4 =
          ListIuranPertemuanDetailArgument(
              dataPertemuan: dataPertemuanBaru,
              typeFrom: widget.args.typeFrom,
              dataPembayaran: dataPembayaranBaru,
              pertemuanKe: pertemuanKe);
      Navigator.pushNamed(context, ListIuranPertemuanDetailPage.id,
          arguments: arguments4);

      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTSuccessColor);
    } else {
      SmartRTSnackbar.show(context,
          message: resp.data, backgroundColor: smartRTErrorColor);
    }
  }

  void bayarSekarangAction() async {
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getDataTagihan/${dataPertemuan!.id}');
    LotteryClubPeriodDetailBill dataPembayaran =
        LotteryClubPeriodDetailBill.fromData(resp.data);

    if (dataPembayaran.payment_type == null ||
        dataPembayaran.payment_type == '' ||
        dataPembayaran.midtrans_transaction_status == 'failure') {
      PembayaranIuranArisanPage1Arguments args =
          PembayaranIuranArisanPage1Arguments(
              typeFrom: widget.args.typeFrom,
              periodeKe: dataPertemuan!.period_ke.toString(),
              pertemuanKe: pertemuanKe,
              dataPertemuan: dataPertemuan!);
      Navigator.pushNamed(context, PembayaranIuranArisanPage1.id,
          arguments: args);
    } else if (dataPembayaran.midtrans_transaction_status == 'pending') {
      PembayaranIuranArisanPage2Arguments args =
          PembayaranIuranArisanPage2Arguments(
        periodeKe: dataPertemuan!.period_ke.toString(),
        typeFrom: widget.args.typeFrom,
        pertemuanKe: pertemuanKe,
        dataPembayaran: dataPembayaran,
        dataPertemuan: dataPertemuan!,
      );
      Navigator.pushNamed(context, PembayaranIuranArisanPage2.id,
          arguments: args);
    }
  }

  void getData() async {
    dataPembayaran = widget.args.dataPembayaran;
    pertemuanKe = widget.args.pertemuanKe;
    dataPertemuan = widget.args.dataPertemuan;

    statusPembayaran = dataPembayaran!.status == 0 ? 'Belum Bayar' : 'Lunas';
    statusPembayaranColor = dataPembayaran!.status == 0
        ? smartRTStatusRedColor
        : smartRTStatusGreenColor;

    totalTagihan = CurrencyFormat.convertToIdr(dataPembayaran!.bill_amount, 2);
    namaAnggota = dataPembayaran!.data_user!.full_name;
    alamatAnggota = dataPembayaran!.data_user!.address!;

    if (dataPembayaran!.status == 1) {
      pembayaranVia = dataPembayaran!.payment_type == 'bank_transfer'
          ? 'Transfer Bank (${dataPembayaran!.acquiring_bank!.toUpperCase()})'
          : 'Tunai';
    } else {
      idUser = dataPembayaran!.user_id!;
    }

    debugPrint(dataPembayaran!.updated_by.toString());
    if (dataPembayaran!.updated_at != null) {
      tanggalPembayaran = DateFormat('d MMMM y HH:mm', 'id_ID')
          .format(dataPembayaran!.updated_at!);
      if (dataPembayaran!.updated_by != null) {
        dikonfirmasiOleh = dataPembayaran!.data_user_konfirmasi!.full_name;
      }
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
        title: const Text(''),
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
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 1,
                  height: 50,
                ),
                ListTileData1(txtLeft: 'Pertemuan Ke-', txtRight: pertemuanKe),
                ListTileData1(txtLeft: 'Nama Anggota', txtRight: namaAnggota),
                ListTileData1(txtLeft: 'Alamat', txtRight: alamatAnggota),
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 1,
                  height: 50,
                ),
                ListTileData1(
                  txtLeft: 'Status',
                  txtRight: statusPembayaran,
                  txtStyleRight:
                      smartRTTextLarge.copyWith(color: statusPembayaranColor),
                ),
                ListTileData1(txtLeft: 'Total Tagihan', txtRight: totalTagihan),
                pembayaranVia != ''
                    ? Column(
                        children: [
                          ListTileData1(
                              txtLeft: 'Pembayaran VIA',
                              txtRight: pembayaranVia),
                          ListTileData1(
                              txtLeft: 'Tanggal Pembayaran',
                              txtRight: tanggalPembayaran),
                          ListTileData1(
                              txtLeft: 'Dikonfirmasi Oleh',
                              txtRight: dikonfirmasiOleh),
                        ],
                      )
                    : const SizedBox(),
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 1,
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
                                    onPressed: () async {
                                      bayarSekarangAction();
                                    },
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
                      (user.user_role == Role.Bendahara ||
                              user.user_role == Role.Ketua_RT)
                          ? SizedBox(
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
                            )
                          : const SizedBox(),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
