import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';

class BuatJanjiTemuPage extends StatefulWidget {
  static const String id = 'BuatJanjiTemuPage';
  const BuatJanjiTemuPage({Key? key}) : super(key: key);

  @override
  State<BuatJanjiTemuPage> createState() => _BuatJanjiTemuPageState();
}

class _BuatJanjiTemuPageState extends State<BuatJanjiTemuPage> {
  String _areaSelectedItem = '';
  final List<String> _areaItems = [
    'XXX',
    'YYY',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buat Janji Temu'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'yyyy/MM/dd',
                  locale: const Locale('id', 'ID'),
                  style: smartRTTextNormal_Primary,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 90)),
                  dateLabelText: 'Tanggal Janjian',
                  onChanged: (val) => print(val),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Tanggal Janjian tidak boleh kosong";
                    }
                  },
                  onSaved: (val) => print(val),
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
                      return 'Tidak boleh kosong';
                    }
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
