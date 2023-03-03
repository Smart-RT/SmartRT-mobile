import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_2.dart';
import 'package:date_time_picker/date_time_picker.dart';

class RegisterPage1 extends StatefulWidget {
  static const String id = 'RegisterPage1';
  const RegisterPage1({Key? key}) : super(key: key);

  @override
  State<RegisterPage1> createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  final _formKey = GlobalKey<FormState>();
  final _namaLengkapController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  String _genderSelectedValue = '';

  final List<String> genderItems = [
    'Laki-Laki',
    'Perempuan',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar ( 1 / 2 )'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: paddingScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Saya',
                    style: smartRTTextTitle_Primary,
                  ),
                  Text(
                    'Pastikan anda mengisi dengan data yang valid dan sesuai dengan KTP',
                    style: smartRTTextNormal_Primary,
                  ),
                  SB_height15,
                  TextFormField(
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: const InputDecoration(
                      labelText: 'Nama Lengkap',
                    ),
                    controller: _namaLengkapController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                    },
                  ),
                  SB_height15,
                  DropdownButtonFormField2(
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
                    hint: Text(
                      'Jenis Kelamin',
                      style: smartRTTextLargeBold_Primary,
                    ),
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
                    items: genderItems
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
                        _genderSelectedValue = value.toString();
                      });
                    },
                    onSaved: (value) {
                      _genderSelectedValue = value.toString();
                    },
                  ),
                  SB_height15,
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'yyyy/MM/dd',
                    style: smartRTTextNormal_Primary,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    dateLabelText: 'Tanggal Lahir',
                    onChanged: (val) => print(val),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Tanggal Lahir tidak boleh kosong";
                      }
                    },
                    onSaved: (val) => print(val),
                    controller: _tanggalLahirController,
                  ),
                  SB_height15,
                ],
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      RegisterPage2Arguments argsForRegisterPage2 =
                          RegisterPage2Arguments(
                              namaLengkap: _namaLengkapController.text,
                              jenisKelamin: _genderSelectedValue,
                              tanggalLahir: _tanggalLahirController.text);
                      Navigator.pushNamed(context, RegisterPage2.id,
                          arguments: argsForRegisterPage2);
                    }
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
      ),
    );
  }
}
