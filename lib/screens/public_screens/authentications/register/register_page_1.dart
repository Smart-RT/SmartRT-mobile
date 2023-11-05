import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_2.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';

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
        title: const Text('DAFTAR AKUN ( 1 / 2 )'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: paddingScreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ExplainPart(
                    title: 'Tentang Saya',
                    notes:
                        'Pastikan anda mengisi dengan data yang valid dan sesuai dengan KTP'),
                SB_height30,
                TextFormField(
                  autocorrect: false,
                  style: smartRTTextNormal,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                  ),
                  controller: _namaLengkapController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SB_height15,
                DropdownButtonFormField2(
                  style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
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
                    style: smartRTTextLarge,
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
                              style: smartRTTextLarge,
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
                  locale: const Locale('id', 'ID'),
                  style: smartRTTextNormal,
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                  dateLabelText: 'Tanggal Lahir',
                  onChanged: (val) => print(val),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Tanggal Lahir tidak boleh kosong";
                    }
                    return null;
                  },
                  onSaved: (val) => print(val),
                  controller: _tanggalLahirController,
                ),
                SB_height15,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: paddingScreen,
        child: SizedBox(
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
              style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
