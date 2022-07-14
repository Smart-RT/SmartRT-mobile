import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_2.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_x.dart';
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
  String _genderSelectedValue= '';


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
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tentang Saya',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Pastikan anda mengisi dengan data yang valid dan sesuai dengan KTP',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    autocorrect: false,
                    style: Theme.of(context).textTheme.bodyText1,
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
                  const SizedBox(
                    height: 15,
                  ),
                  DropdownButtonFormField2(
                    style: Theme.of(context).textTheme.bodyText1,
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
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xff311c0a),
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 25, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    items: genderItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style:  Theme.of(context).textTheme.bodyText1,
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
                  const SizedBox(
                    height: 15,
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    style: Theme.of(context).textTheme.bodyText1,
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
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      RegisterPage2Arguments argsForRegisterPage2 = RegisterPage2Arguments(namaLengkap: _namaLengkapController.text, jenisKelamin: _genderSelectedValue, tanggalLahir: _tanggalLahirController.text);
                      Navigator.pushNamed(context, RegisterPage2.id, arguments: argsForRegisterPage2);
                    }
                  },
                  child: Text(
                    'SELANJUTNYA',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
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
