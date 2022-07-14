import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_2.dart';



class RegisterPageX extends StatefulWidget {
  static const String id = 'RegisterPageX';


  RegisterPageX({Key? key}) : super(key: key);

  @override
  State<RegisterPageX> createState() => _RegisterPageXState();
}

class _RegisterPageXState extends State<RegisterPageX> {
  final _formKey = GlobalKey<FormState>();
  final _alamatController = TextEditingController();
  final _RWController = TextEditingController();
  final _RTController = TextEditingController();
  String _kecamatanValue = '';
  String _kelurahanValue = '';

  final List<String> kecamatanItems = [];
  final List<String> kelurahanItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Regster page2')),
      // body: Container(child: Text(widget.args.alamat)),

      appBar: AppBar(
        title: Text('Daftar ( 2 / 3 )'),
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
                    'Alamat Domisili',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Pastikan anda mengisi dengan data yang valid dan sesuai dengan tempat tinggal anda sekarang',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 25,
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
                      'Kecamatan',
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
                    items: kecamatanItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Kecamatan tidak boleh kosong';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _kecamatanValue = value.toString();
                      });
                    },
                    onSaved: (value) {
                      _kecamatanValue = value.toString();
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
                      'Kelurahan',
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
                    items: kelurahanItems
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Kelurahan tidak boleh kosong';
                      }
                    },
                    onChanged: (value) {
                      setState(() {
                        _kelurahanValue = value.toString();
                      });
                    },
                    onSaved: (value) {
                      _kelurahanValue = value.toString();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    autocorrect: false,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: const InputDecoration(
                      labelText: 'Alamat Rumah',
                    ),
                    controller: _alamatController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Alamat Rumah boleh kosong';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: const InputDecoration(
                      labelText: 'RW',
                    ),
                    controller: _RWController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'RW tidak boleh kosong';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: const InputDecoration(
                      labelText: 'RT',
                    ),
                    controller: _RTController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'RT tidak boleh kosong';
                      }
                    },
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
                    // if (_formKey.currentState!.validate()) {
                    // RegisterPage3Arguments argsForRegisterPage3 =
                    //     RegisterPage3Arguments(
                    //         namaLengkap: widget.args.namaLengkap,
                    //         jenisKelamin: widget.args.jenisKelamin,
                    //         tanggalLahir: widget.args.tanggalLahir,
                    //         Kecamatan: _kecamatanValue,
                    //         kelurahan: _kelurahanValue,
                    //         alamat: _alamatController.text,
                    //         rt: _RTController.text,
                    //         rw: _RWController.text);
                    // Navigator.pushNamed(context, RegisterPage2.id,
                    //     arguments: argsForRegisterPage3);
                    // }
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
