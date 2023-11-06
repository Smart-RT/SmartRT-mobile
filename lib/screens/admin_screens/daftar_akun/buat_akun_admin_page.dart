import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class BuatAkunAdminPage extends StatefulWidget {
  static const String id = 'BuatAkunAdminPage';
  const BuatAkunAdminPage({Key? key}) : super(key: key);

  @override
  State<BuatAkunAdminPage> createState() => _BuatAkunAdminPageState();
}

class _BuatAkunAdminPageState extends State<BuatAkunAdminPage> {
  String _areaSelectedItem = '';
  final List<String> _areaItems = [
    'XXX',
    'YYY',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Akun'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextFormField(
                  autocorrect: false,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'Nama Akun',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul Keperluan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SB_height50,
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
                    'Janjian dengan wilayah...',
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
                  items: _areaItems
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
                      return 'Jenis Kelamin tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _areaSelectedItem = value.toString();
                    });
                  },
                  onSaved: (value) {
                    _areaSelectedItem = value.toString();
                  },
                ),
                SB_height50,
                TextFormField(
                  autocorrect: false,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'Judul Keperluan',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul Keperluan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SB_height15,
                TextFormField(
                  maxLines: 10,
                  autocorrect: false,
                  style: smartRTTextNormal_Primary,
                  decoration: const InputDecoration(
                    labelText: 'Detail Keperluan',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Detail Keperluan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SB_height15,
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(
                      'TAMBAHKAN LAMPIRAN',
                      style: smartRTTextLargeBold_Primary,
                    ),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: smartRTPrimaryColor, width: 2)),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  /**.... */
                },
                child: Text(
                  'BUAT JANJI',
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
