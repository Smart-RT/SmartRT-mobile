import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/models/area/area_bill/area_bill.dart';
import 'package:smart_rt/models/area/area_bill/area_bill_transaction.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/utilities/string/string_format.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_user_2.dart';
import 'package:smart_rt/screens/public_screens/keuangan/iuran/lihat_semua_pembayar_page_detail.dart';

class LihatSemuaPembayarPageArguments {
  AreaBill dataAreaBill;
  int? areaBillRepeatDetailID;
  LihatSemuaPembayarPageArguments({
    required this.dataAreaBill,
    this.areaBillRepeatDetailID,
  });
}

class LihatSemuaPembayarPage extends StatefulWidget {
  static const String id = 'LihatSemuaPembayarPage';
  LihatSemuaPembayarPageArguments args;
  LihatSemuaPembayarPage({Key? key, required this.args}) : super(key: key);

  @override
  State<LihatSemuaPembayarPage> createState() => _LihatSemuaPembayarPageState();
}

class _LihatSemuaPembayarPageState extends State<LihatSemuaPembayarPage> {
  User user = AuthProvider.currentUser!;

  void getData() async {
    AreaBill dataAreaBill = widget.args.dataAreaBill;
    await context.read<AreaBillProvider>().getAreaBillTransactionByAreaBillID(
        areaBillID: dataAreaBill.id,
        areaBillRepeatDetailID: widget.args.areaBillRepeatDetailID);
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<AreaBillTransaction> listPembayar =
        context.watch<AreaBillProvider>().listPembayar;
    AreaBill dataAreaBill = widget.args.dataAreaBill;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Column(
        children: [
          Container(
            color: smartRTSecondaryColor,
            width: double.infinity,
            padding: paddingScreen,
            child: Column(
              children: [
                Text(
                  'IURAN'.toUpperCase(),
                  style: smartRTTextTitle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  '"${dataAreaBill.name}"'.toUpperCase(),
                  style: smartRTTextTitleCard,
                  textAlign: TextAlign.center,
                ),
                SB_height30,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: smartRTSuccessColor,
                          size: 25,
                        ),
                        SB_width15,
                        Text(
                          'Sudah Bayar',
                          style: smartRTTextNormal,
                        )
                      ],
                    ),
                    SB_width15,
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: smartRTErrorColor,
                          size: 25,
                        ),
                        SB_width15,
                        Text(
                          'Belum Bayar',
                          style: smartRTTextNormal,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, int) {
                return Divider(
                  color: smartRTPrimaryColor,
                  height: 5,
                  thickness: 5,
                );
              },
              itemCount: listPembayar.length,
              itemBuilder: (context, index) {
                return ListTileUser2(
                  photoPathURL:
                      '${backendURL}/public/uploads/users/${listPembayar[index].dataUser!.id}/profile_picture/',
                  photo: listPembayar[index].dataUser!.photo_profile_img,
                  initialName: StringFormat.initialName(
                      listPembayar[index].dataUser!.full_name),
                  fullName: listPembayar[index].dataUser!.full_name,
                  address: listPembayar[index].dataUser!.address.toString(),
                  tileColor: listPembayar[index].status == 0
                      ? smartRTErrorColor
                      : smartRTSuccessColor,
                  paymentDate: listPembayar[index].updated_at == null
                      ? ''
                      : DateFormat('d MMMM y', 'id_ID')
                          .format(listPembayar[index].updated_at!),
                  via: listPembayar[index].status == 0
                      ? ''
                      : listPembayar[index].payment_type == 'bank_transfer'
                          ? 'Transfer Bank (${listPembayar[index].acquiring_bank!.toUpperCase()})'
                          : 'Tunai',
                  onTap: () {
                    Navigator.pushNamed(
                        context, LihatSemuaPembayarPageDetail.id,
                        arguments: LihatSemuaPembayarPageDetailArguments(
                            index: index,
                            dataAreaBill: dataAreaBill,
                            areaBillRepeatDetailID:
                                widget.args.areaBillRepeatDetailID));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
