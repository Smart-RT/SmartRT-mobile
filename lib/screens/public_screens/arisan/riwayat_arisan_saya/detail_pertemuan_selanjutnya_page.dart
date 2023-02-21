import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/lottery_club_period_detail.dart';
import 'package:smart_rt/models/lottery_club_period_detail_bill.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/public_screens/arisan/absen_anggota_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page.dart';
import 'package:smart_rt/screens/public_screens/arisan/pembayaran_iuran_arisan_page_2.dart';
import 'package:smart_rt/screens/public_screens/arisan/riwayat_arisan_wilayah/lihat_iuran_arisan_pertemuan_page.dart';
import 'package:smart_rt/utilities/currency_format.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_arisan.dart';

class DetailPertemuanSelanjutnyaPage extends StatefulWidget {
  static const String id = 'DetailPertemuanSelanjutnyaPage';
  const DetailPertemuanSelanjutnyaPage({Key? key}) : super(key: key);

  @override
  State<DetailPertemuanSelanjutnyaPage> createState() =>
      _DetailPertemuanSelanjutnyaPageState();
}

class _DetailPertemuanSelanjutnyaPageState
    extends State<DetailPertemuanSelanjutnyaPage> {
  User user = AuthProvider.currentUser!;
  LotteryClubPeriodDetail? dataPertemuan;
  String tanggalPertemuan = '';
  String waktuPertemuan = '';
  String tempatPertemuan = '';
  String iuranArisan = '';
  String statusPembayaran = '';
  String pertemuanKe = '';
  String periodeKe = '';

  void bayarIuranAction() async {
    Response<dynamic> resp = await NetUtil()
        .dioClient
        .get('/lotteryClubs/getDataTagihan/${dataPertemuan!.id}');
    LotteryClubPeriodDetailBill dataPembayaran =
        LotteryClubPeriodDetailBill.fromData(resp.data);

    if (dataPembayaran.payment_type == null ||
        dataPembayaran.payment_type == '') {
      PembayaranIuranArisanArguments args = PembayaranIuranArisanArguments(
        periodeKe: periodeKe,
        pertemuanKe: pertemuanKe,
        pertemuanID: dataPertemuan!.id.toString(),
      );
      Navigator.pushNamed(context, PembayaranIuranArisan.id, arguments: args);
    } else if (dataPembayaran.midtrans_transaction_status == 'pending') {
      PembayaranIuranArisanPage2Arguments args =
          PembayaranIuranArisanPage2Arguments(
              periodeKe: periodeKe,
              pertemuanKe: pertemuanKe,
              dataPembayaran: dataPembayaran);
      Navigator.popAndPushNamed(context, PembayaranIuranArisanPage2.id,
          arguments: args);
    }
  }

  void getData() async {
    Response<dynamic> resp = await NetUtil().dioClient.get(
        '/lotteryClubs/getLastPeriodeID/${user.area!.lottery_club_id!.id.toString()}');

    if (resp.data != 'Belum ada Periode Arisan') {
      int idPeriodeTerakhir = resp.data;
      resp = await NetUtil().dioClient.get(
          '/lotteryClubs/getPeriodDetail/Published/${idPeriodeTerakhir.toString()}');
      dataPertemuan = LotteryClubPeriodDetail.fromData(resp.data);
      tanggalPertemuan =
          DateFormat('d MMMM y').format(dataPertemuan!.meet_date);
      waktuPertemuan = DateFormat('H:m').format(dataPertemuan!.meet_date);
      tempatPertemuan = dataPertemuan!.meet_at.toString();
      pertemuanKe = dataPertemuan!.lottery_club_period_id!.meet_ctr.toString();
      periodeKe = dataPertemuan!.lottery_club_period_id!.period.toString();
      iuranArisan = CurrencyFormat.convertToIdr(
          dataPertemuan!.lottery_club_period_id!.bill_amount, 2);

      resp = await NetUtil()
          .dioClient
          .get('/lotteryClubs/getDataTagihan/${dataPertemuan!.id.toString()}');
      LotteryClubPeriodDetailBill dataPembayaran =
          LotteryClubPeriodDetailBill.fromData(resp.data);
      statusPembayaran = dataPembayaran.status.toString();
      debugPrint('hahahaha ${resp.data.toString()}');
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
                    'DETAIL PERTEMUAN KE ${pertemuanKe}',
                    style: smartRTTextTitleCard.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'PERIODE KE ${periodeKe}',
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
                        tanggalPertemuan,
                        style: smartRTTextLarge,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Waktu Pertemuan',
                        style: smartRTTextLarge,
                      ),
                      Text(
                        '${waktuPertemuan} WIB',
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
                      SB_width15,
                      Expanded(
                        child: Text(
                          tempatPertemuan,
                          style: smartRTTextLarge,
                          textAlign: TextAlign.right,
                        ),
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
                        iuranArisan,
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
                      (statusPembayaran == '0')
                          ? Text(
                              'Belum Bayar',
                              style: smartRTTextLarge.copyWith(
                                  color: smartRTErrorColor2),
                            )
                          : Text(
                              'Lunas',
                              style: smartRTTextLarge.copyWith(
                                  color: smartRTSuccessColor2),
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
              onTap: () async {
                bayarIuranAction();
              },
            ),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
              title: 'Lihat Absensi Anggota',
              onTap: () {
                AbsenAnggotaPageArguments args = AbsenAnggotaPageArguments(
                    idPertemuan: dataPertemuan!.id.toString());
                Navigator.pushNamed(context, AbsenAnggotaPage.id,
                    arguments: args);
              },
            ),
            Divider(
              height: 25,
              thickness: 2,
            ),
            ListTileArisan(
                title: 'Lihat Tagihan Anggota',
                onTapDestination: LihatIuranArisanPertemuanPage.id),
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
