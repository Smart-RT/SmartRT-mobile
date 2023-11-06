import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class BuatIuranPage extends StatefulWidget {
  static const String id = 'BuatIuranPage';
  const BuatIuranPage({Key? key}) : super(key: key);

  @override
  State<BuatIuranPage> createState() => _BuatIuranPageState();
}

class _BuatIuranPageState extends State<BuatIuranPage> {
  final _namaIuranController = TextEditingController();
  final _nominalIuranController = TextEditingController();
  List<String> _isRepeated = [];
  String _isRepeatedSelectedValue = '';

  void clearAll() {
    _isRepeated.clear();
    _isRepeatedSelectedValue = '';
    _namaIuranController.text = '';
    _nominalIuranController.text = '';
  }

  void getData() {
    _isRepeated.add('Iya');
    _isRepeated.add('Tidak');
    _isRepeatedSelectedValue = _isRepeated[0];
  }

  @override
  void initState() {
    // TODO: implement initState
    clearAll();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Iuran'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: paddingScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _namaIuranController,
                    autocorrect: false,
                    style: smartRTTextLarge,
                    decoration: const InputDecoration(
                      labelText: 'Nama Iuran',
                    ),
                  ),
                  SB_height15,
                  TextFormField(
                    controller: _nominalIuranController,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    style: smartRTTextLarge,
                    decoration: const InputDecoration(
                      labelText: 'Nominal Iuran',
                    ),
                  ),
                  SB_height15,
                  Text(
                    'Iuran Bulanan?',
                    style:
                        smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  SB_height5,
                  DropdownButtonFormField2(
                    value: _isRepeatedSelectedValue,
                    style:
                        smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    isExpanded: true,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: smartRTPrimaryColor,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    items: _isRepeated
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: smartRTTextLarge,
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _isRepeatedSelectedValue = value.toString();
                      });
                      debugPrint('_isRepeatedSelectedValue');
                      debugPrint(_isRepeatedSelectedValue);
                    },
                    onSaved: (value) {
                      _isRepeatedSelectedValue = value.toString();
                    },
                  ),
                  SB_height30,
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_namaIuranController.text == '' ||
                        _isRepeatedSelectedValue == '' ||
                        _nominalIuranController.text == '') {
                      SmartRTSnackbar.show(context,
                          message: 'Pastikan semua field terisi!',
                          backgroundColor: smartRTErrorColor);
                    } else {
                      int x = 0;
                      if (_isRepeatedSelectedValue == 'Tidak') {
                        x = 0;
                      } else {
                        x = 1;
                      }
                      bool isSuccess = await context
                          .read<AreaBillProvider>()
                          .addAreaBill(
                              name: _namaIuranController.text,
                              billAmount:
                                  int.parse(_nominalIuranController.text),
                              isRepeated: x);
                      if (isSuccess) {
                        Navigator.pop(context);
                        SmartRTSnackbar.show(context,
                            message: 'Berhasil menambahkan iuran!',
                            backgroundColor: smartRTSuccessColor);
                      } else {
                        SmartRTSnackbar.show(context,
                            message: 'Gagal! Cobalah beberapa saat lagi!',
                            backgroundColor: smartRTErrorColor);
                      }
                    }
                  },
                  child: Text(
                    'BUAT SEKARANG !',
                    style: smartRTTextLargeBold_Secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
