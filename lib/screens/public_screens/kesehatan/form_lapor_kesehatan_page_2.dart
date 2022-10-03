import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class FormLaporKesehatanPage2 extends StatefulWidget {
  static const String id = 'FormLaporKesehatanPage2';
  const FormLaporKesehatanPage2({Key? key}) : super(key: key);

  @override
  State<FormLaporKesehatanPage2> createState() =>
      _FormLaporKesehatanPage2State();
}

class _FormLaporKesehatanPage2State extends State<FormLaporKesehatanPage2> {
  String _PenyakitSelectedItem = '';
  final List<String> _PenyakitItems = [
    'ABC',
    'Lainnya / Kurang Tahu',
  ];
  bool _NotesVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulir Lapor Kesehatan ( 2 / 2 )'),
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
                  'DETAIL',
                  style: smartRTTextTitle_Primary,
                ),
                Text(
                  'Mohon memberikan keterangan mengenai penyakit yang anda ketahui tersebut dan pastikan laporan anda dapat dipertanggung jawabkan',
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
                    'Keluhan / Sakit yang di derita...',
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
                  items: _PenyakitItems
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
                      _PenyakitSelectedItem = value.toString();
                      if (_PenyakitSelectedItem == 'Lainnya / Kurang Tahu') {
                        _NotesVisibility = true;
                      } else {
                        _NotesVisibility = false;
                      }
                    });
                  },
                  onSaved: (value) {
                    _PenyakitSelectedItem = value.toString();
                  },
                ),
                SB_height15,
                Visibility(
                  visible: _NotesVisibility,
                  child: TextFormField(
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Catatan / Deskripsi',
                    ),
                    maxLines: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Catatan / deskripsi tidak boleh kosong';
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
                  // Navigator.pushNamed(context, DaftarKetuaFormPage2.id);
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
