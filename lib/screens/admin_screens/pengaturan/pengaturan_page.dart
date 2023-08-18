import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/setting_provider.dart';
import 'package:smart_rt/utilities/string/currency_format.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';
import 'package:smart_rt/widgets/list_tile/list_tile_data_5.dart';
import 'package:smart_rt/models/app_setting/app_setting.dart';

class PengaturanPage extends StatefulWidget {
  static const String id = 'PengaturanPage';
  const PengaturanPage({Key? key}) : super(key: key);

  @override
  State<PengaturanPage> createState() => _Pengaturantate();
}

class _Pengaturantate extends State<PengaturanPage> {
  void biayaLanggananDialog() async {
    final _biayaLanggananController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Hai Admin,',
          style: smartRTTextTitleCard,
        ),
        content: Text(
          '*Biaya langganan baru akan diberlakukan pada transaksi baru!',
          style: smartRTTextNormal.copyWith(
              fontStyle: FontStyle.normal, fontWeight: FontWeight.normal),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: _biayaLanggananController,
              keyboardType: TextInputType.number,
              autocorrect: false,
              style: smartRTTextNormal,
              decoration: const InputDecoration(
                labelText: 'Biaya Langganan Baru (IDR)',
              ),
            ),
          ),
          SB_height15,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Batal'),
                child: Text(
                  'Batal',
                  style:
                      smartRTTextNormal.copyWith(color: smartRTStatusRedColor),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (_biayaLanggananController.text == '' ||
                      int.parse(_biayaLanggananController.text) < 5000) {
                    SmartRTSnackbar.show(context,
                        message:
                            'Biaya langganan tidak boleh kosong dan harus lebih besar sama dengan IDR 5.000 !',
                        backgroundColor: smartRTErrorColor);
                  } else {
                    bool isSukses = await context
                        .read<SettingProvider>()
                        .updateSubscribeAmount(
                            subcribeAmount:
                                int.parse(_biayaLanggananController.text));

                    if (isSukses) {
                      Navigator.pop(context);
                      await context
                          .read<SettingProvider>()
                          .getDataSubscribeAmount();
                      setState(() {});
                      SmartRTSnackbar.show(context,
                          message: 'Berhasil merubah biaya langganan!',
                          backgroundColor: smartRTSuccessColor);
                    } else {
                      Navigator.pop(context);
                      setState(() {});
                      SmartRTSnackbar.show(context,
                          message:
                              'Terjadi Kesalahan! Cobalah beberapa saat lagi!',
                          backgroundColor: smartRTErrorColor);
                    }
                  }
                },
                child: Text(
                  'UBAH',
                  style:
                      smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void getData() async {
    await context.read<SettingProvider>().getDataSubscribeAmount();
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int subscribeAmount = context.watch<SettingProvider>().subscribeAmount;
    String biayaLangganan = CurrencyFormat.convertToIdr(subscribeAmount, 2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: ListTileData5(
          txtLeft: 'Biaya Langganan',
          txtRight: biayaLangganan,
          onTap: () {
            biayaLanggananDialog();
          },
        ),
      ),
    );
  }
}
