import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/admin_screens/daftar_akun/buat_akun_admin_page.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/detail_riwayat_bantuan_page.dart';
import 'package:smart_rt/widgets/cards/card_with_status.dart';
import 'package:smart_rt/widgets/cards/card_with_time_location.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TugasSayaPage extends StatefulWidget {
  static const String id = 'TugasSayaPage';
  const TugasSayaPage({Key? key}) : super(key: key);

  @override
  State<TugasSayaPage> createState() => _TugasSayaPageState();
}

class _TugasSayaPageState extends State<TugasSayaPage> {
  String _waktuSelectedItem = 'Hari Ini';
  final List<String> _waktuItems = [
    'Hari Ini',
    'Bulan Ini',
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField2(
                  style: smartRTTextLargeBold_Primary,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  value: _waktuSelectedItem,
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
                  items: _waktuItems
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
                      return 'Waktu tidak boleh kosong';
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      _waktuSelectedItem = value.toString();
                    });
                  },
                  onSaved: (value) {
                    _waktuSelectedItem = value.toString();
                  },
                ),
                SB_height50,
                Text('Tugas Pada ${_waktuSelectedItem}', style: smartRTTextTitleCard_Primary,) 
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