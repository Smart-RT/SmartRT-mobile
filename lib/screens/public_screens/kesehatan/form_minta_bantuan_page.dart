import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/guest_screens/daftar_ketua/daftar_ketua_form_page_2.dart';

class FormMintaBantuanPage extends StatefulWidget {
  static const String id = 'FormMintaBantuanPage';
  const FormMintaBantuanPage({Key? key}) : super(key: key);

  @override
  State<FormMintaBantuanPage> createState() => _FormMintaBantuanPageState();
}

class _FormMintaBantuanPageState extends State<FormMintaBantuanPage> {
  String _TingkatKebutuhanSelectedItem = '';
  final List<String> _TingkatKebutuhanItems = [
    'Genting / Butuh Secepatnya',
    'Santai / Tidak Butuh Cepat',
  ];
   String _JenisKebutuhanSelectedItem = '';
  final List<String> _JenisKebutuhanItems = [
    'Obat-obatan',
    'Kebutuhan Pangan',
    'Lainnya'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minta Bantuan'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField2(
                  style: smartRTTextNormal_Primary,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'Tingkat Kebutuhan',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: smartRTPrimaryColor,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 25, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: _TingkatKebutuhanItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: smartRTTextNormal_Primary,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Tingkat Kebutuhan tidak boleh kosong';
                    }
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
                DropdownButtonFormField2(
                  style: smartRTTextNormal_Primary,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  hint: Text(
                    'Jenis Kebutuhan',
                    style: smartRTTextLargeBold_Primary,
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: smartRTPrimaryColor,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 25, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: _JenisKebutuhanItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: smartRTTextNormal_Primary,
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Jenis Kebutuhan tidak boleh kosong';
                    }
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
                  },
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  /** */
                },
                child: Text(
                  'SUBMIT',
                  style: smartRTTextLargeBold_Secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
