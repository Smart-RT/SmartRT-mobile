import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_transaction.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_1.dart';

import 'package:smart_rt/screens/public_screens/keuangan/iuran/pembayaran_tf/pembayaran_tf_page_1.dart';

class TagihanSayaPageDetailArguments {
  int index;
  AreaBill dataAreaBill;
  int? areaBillRepeatDetailID;
  TagihanSayaPageDetailArguments({
    required this.index,
    required this.dataAreaBill,
    this.areaBillRepeatDetailID,
  });
}

class TagihanSayaPageDetail extends StatefulWidget {
  static const String id = 'TagihanSayaPageDetail';
  TagihanSayaPageDetailArguments args;
  TagihanSayaPageDetail({Key? key, required this.args}) : super(key: key);

  @override
  State<TagihanSayaPageDetail> createState() => _TagihanSayaPageDetailState();
}

class _TagihanSayaPageDetailState extends State<TagihanSayaPageDetail> {
  User user = AuthProvider.currentUser!;

  void konfirmasiBayarCash({required AreaBillTransaction dataTagihan}) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Sobat Pintar,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          'Apakah anda yakin ${dataTagihan.dataUser!.full_name} sudah membayar sejumlah ${CurrencyFormat.convertToIdr(dataTagihan.bill_amount, 2)} dengan via TUNAI?\n\nPastikan anda telah menerima uang tersebut!',
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
                onPressed: () async {
                  AreaBill dataAreaBill = widget.args.dataAreaBill;

                  bool isSuccess = await context
                      .read<AreaBillProvider>()
                      .bayarCash(
                          areaBillRepeatDetailID:
                              widget.args.areaBillRepeatDetailID,
                          areaBillID: dataTagihan.area_bill_id,
                          areaBillTransactionID: dataTagihan.id,
                          areaID: dataAreaBill.area_id);
                  if (isSuccess) {
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    SmartRTSnackbar.show(context,
                        message: 'Berhasil mengkonfirmasi pembayaran tunai !',
                        backgroundColor: smartRTSuccessColor);
                    await context.read<AreaBillProvider>().getTotalTagihanKu();
                  } else {
                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    SmartRTSnackbar.show(context,
                        message: 'Gagal! Cobalah beberapa saat lagi!',
                        backgroundColor: smartRTErrorColor);
                  }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.args.areaBillRepeatDetailID.toString());
    int index = widget.args.index;
    AreaBill dataAreaBill = widget.args.dataAreaBill;
    AreaBillTransaction dataTagihan =
        context.watch<AreaBillProvider>().listTagihanKu[index];
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
                  'DETAIL PEMBAYAR',
                  style: smartRTTextTitleCard.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  '"${dataAreaBill.name}"',
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
                ListTileData1(
                    txtLeft: 'Nama', txtRight: dataTagihan.dataUser!.full_name),
                ListTileData1(
                    txtLeft: 'Alamat',
                    txtRight: dataTagihan.dataUser!.address ?? ''),
                ListTileData1(
                    txtLeft: 'Telp', txtRight: dataTagihan.dataUser!.phone),
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 1,
                  height: 50,
                ),
                ListTileData1(
                  txtLeft: 'Status',
                  txtRight:
                      dataTagihan.status == 0 ? 'Menunggu Pembayaran' : 'Lunas',
                  txtStyleRight: smartRTTextLarge.copyWith(
                      color: dataTagihan.status == 0
                          ? smartRTStatusYellowColor
                          : smartRTStatusGreenColor),
                ),
                ListTileData1(
                    txtLeft: 'Total Tagihan',
                    txtRight: CurrencyFormat.convertToIdr(
                        dataTagihan.bill_amount, 2)),
                if (dataTagihan.status == 1)
                  ListTileData1(
                      txtLeft: 'Via',
                      txtRight: dataTagihan.payment_type == 'bank_transfer'
                          ? 'Bank Transfer'
                          : 'Tunai'),
                if (dataTagihan.status == 1 &&
                    (dataTagihan.payment_type ?? '').toLowerCase() == 'cash')
                  ListTileData1(
                      txtLeft: 'Dikonfirmasi Oleh',
                      txtRight: dataTagihan.updated_by!.full_name),
                if (dataTagihan.status == 1)
                  ListTileData1(
                    txtLeft: 'Tanggal Pembayaran',
                    txtRight: StringFormat.formatDate(
                        dateTime: dataTagihan.updated_at!, isWithTime: false),
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                Divider(
                  color: smartRTPrimaryColor,
                  thickness: 1,
                  height: 50,
                ),
                if (dataTagihan.status == 0 && user.id == dataTagihan.user_id)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pushNamed(context, PembayaranTfPage1.id,
                            arguments: PembayaranTfPage1Arguments(
                                index: index, dataAreaBill: dataAreaBill));
                      },
                      child: Text(
                        'BAYAR TAGIHAN SEKARANG',
                        style: smartRTTextLargeBold_Secondary,
                      ),
                    ),
                  ),
                SB_height15,
                if (dataTagihan.status == 0 &&
                    (user.user_role == Role.Ketua_RT ||
                        user.user_role == Role.Wakil_RT ||
                        user.user_role == Role.Bendahara))
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        konfirmasiBayarCash(dataTagihan: dataTagihan);
                      },
                      child: Text(
                        'KONFIRMASI BAYAR TUNAI',
                        style: smartRTTextLargeBold_Secondary,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
