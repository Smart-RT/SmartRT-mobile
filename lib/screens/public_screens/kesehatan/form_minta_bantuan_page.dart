import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/dialogs/smart_rt_snackbar.dart';

class FormMintaBantuanPage extends StatefulWidget {
  static const String id = 'FormMintaBantuanPage';
  const FormMintaBantuanPage({Key? key}) : super(key: key);

  @override
  State<FormMintaBantuanPage> createState() => _FormMintaBantuanPageState();
}

class _FormMintaBantuanPageState extends State<FormMintaBantuanPage> {
  final _catatanKebutuhanController = TextEditingController();
  String _TingkatKebutuhanSelectedItem = '';
  final List<DropdownMenuItem> _TingkatKebutuhanItems = const [
    DropdownMenuItem(value: '1', child: Text('Tidak Butuh Cepat')),
    DropdownMenuItem(value: '2', child: Text('Butuh Cepat')),
  ];
  String _JenisKebutuhanSelectedItem = '';
  final List<DropdownMenuItem> _JenisKebutuhanItems = const [
    DropdownMenuItem(value: '1', child: Text('Obat-obatan')),
    DropdownMenuItem(value: '2', child: Text('Kebutuhan Pangan')),
    DropdownMenuItem(value: '3', child: Text('Lainnya')),
  ];

  void mintaBantuan() async {
    if (_catatanKebutuhanController.text != '') {
      Response<dynamic> resp =
          await NetUtil().dioClient.post('/health/healthTaskHelp', data: {
        "urgent_level": _TingkatKebutuhanSelectedItem,
        "notes": _catatanKebutuhanController.text,
        "help_type": _JenisKebutuhanSelectedItem,
      });
      if (resp.statusCode.toString() == '200') {
        SmartRTSnackbar.show(context,
            message: resp.data, backgroundColor: smartRTSuccessColor);
        Navigator.pop(context);
      } else {
        SmartRTSnackbar.show(context,
            message: resp.data, backgroundColor: smartRTErrorColor);
      }
    } else {
      SmartRTSnackbar.show(context,
          message: 'Pastikan tidak ada yang kosong !',
          backgroundColor: smartRTErrorColor);
    }
  }

  void getData() async {
    _TingkatKebutuhanSelectedItem = _TingkatKebutuhanItems[0].value.toString();
    _JenisKebutuhanSelectedItem = _JenisKebutuhanItems[0].value.toString();
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
        title: Text('Minta Bantuan'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tingkat Kebutuhan',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SB_height5,
              DropdownButtonFormField2(
                value: _TingkatKebutuhanItems[0].value,
                dropdownMaxHeight: 200,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: _TingkatKebutuhanItems.map((item) =>
                    DropdownMenuItem<String>(
                        value: item.value, child: item.child)).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Tingkat Kebutuhan tidak boleh kosong';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _TingkatKebutuhanSelectedItem = value.toString();
                  });
                },
                onSaved: (value) {
                  _TingkatKebutuhanSelectedItem = value.toString();
                },
              ),
              SB_height30,
              Text(
                'Jenis Kebutuhan',
                style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SB_height5,
              DropdownButtonFormField2(
                value: _JenisKebutuhanItems[0].value,
                dropdownMaxHeight: 200,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                style: smartRTTextNormal.copyWith(fontWeight: FontWeight.bold),
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
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                items: _JenisKebutuhanItems.map((item) =>
                    DropdownMenuItem<String>(
                        value: item.value, child: item.child)).toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Jenis Kebutuhan tidak boleh kosong';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _JenisKebutuhanSelectedItem = value.toString();
                  });
                },
                onSaved: (value) {
                  _JenisKebutuhanSelectedItem = value.toString();
                },
              ),
              SB_height15,
              TextFormField(
                controller: _catatanKebutuhanController,
                autocorrect: false,
                style: smartRTTextNormal_Primary,
                decoration: const InputDecoration(
                  labelText: 'Catatan Kebutuhan',
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Catatan Kebutuhan tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ))),
          onPressed: () {
            mintaBantuan();
          },
          child: Text(
            'MINTA BANTUAN',
            style: smartRTTextLargeBold_Secondary,
          ),
        ),
      ),
    );
  }
}
