import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/kesehatan/form_lapor_kesehatan_page_2.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class FormLaporKesehatanPage1 extends StatefulWidget {
  static const String id = 'FormLaporKesehatanPage1';
  const FormLaporKesehatanPage1({Key? key}) : super(key: key);

  @override
  State<FormLaporKesehatanPage1> createState() =>
      _FormLaporKesehatanPage1State();
}

class _FormLaporKesehatanPage1State extends State<FormLaporKesehatanPage1> {
  String _tipeLaporanSelectedItem = '';
  final List<String> _tipeLaporanItems = [
    'Diri Sendiri',
    'Warga Lain',
  ];
  bool _FullNameVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Lapor Kesehatan ( 1 / 2 )'),
      ),
      body: Padding(
        padding: paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TERKAIT',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Laporan yang anda buat apakah untuk melaporkan kesehatan anda atau orang lain? Pilihlah salah satu dan pastikan laporan tersebut valid',
                  style: smartRTTextNormal_Primary,
                  textAlign: TextAlign.justify,
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
                    'Dibuat untuk...',
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
                  items: _tipeLaporanItems
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
                  },
                  onChanged: (value) {
                    setState(() {
                      _tipeLaporanSelectedItem = value.toString();
                      if (_tipeLaporanSelectedItem == 'Diri Sendiri') {
                        _FullNameVisibility = false;
                      } else {
                        _FullNameVisibility = true;
                      }
                    });
                  },
                  onSaved: (value) {
                    _tipeLaporanSelectedItem = value.toString();
                  },
                ),
                SB_height15,
                Visibility(
                  visible: _FullNameVisibility,
                  child: TextFormField(
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                    },
                  ),
                ),
                SB_height15,
                Visibility(
                  visible: _FullNameVisibility,
                  child: TextFormField(
                    readOnly: true,
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Alamat',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat tidak boleh kosong';
                      }
                    },
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, FormLaporKesehatanPage2.id);
                },
                child: Text(
                  'SELANJUTNYA',
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
