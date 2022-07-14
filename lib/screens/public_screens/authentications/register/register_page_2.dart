import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/utilities/net_util.dart';

class RegisterPage2Arguments {
  String namaLengkap;
  String jenisKelamin;
  String tanggalLahir;

  RegisterPage2Arguments(
      {required this.namaLengkap,
      required this.jenisKelamin,
      required this.tanggalLahir});
}

class RegisterPage2 extends StatefulWidget {
  static const String id = 'RegisterPage2';
  RegisterPage2Arguments args;
  RegisterPage2({Key? key, required this.args}) : super(key: key);

  @override
  State<RegisterPage2> createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();
  final _noTelpController = TextEditingController();
  final _kataSandiController = TextEditingController();
  bool _isObscure = true;

  void doRegister() async {
    try {
      var response = await NetUtil.dioClient.post('/users/register', data: {
        "phone": _noTelpController.text,
        "password": _kataSandiController.text,
        "full_name": widget.args.namaLengkap,
        "gender": widget.args.jenisKelamin,
        "born_date": widget.args.tanggalLahir
      });

      debugPrint(response.toString());

    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar ( 2 / 2)'),
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
                    'Akun Anda',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    'Pastikan anda mengisi dengan no telp yang valid dan kata sandi yang tidak mudah ditebak orang lain',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: const InputDecoration(
                      labelText: 'Nomor Telepon',
                    ),
                    controller: _noTelpController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor Telepon tidak boleh kosong';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: Theme.of(context).textTheme.bodyText1,
                    decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Color(0xff311c0a),
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                      ),
                    
                    controller: _kataSandiController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kata Sandi tidak boleh kosong';
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
                    if (_formKey.currentState!.validate()) {
                      doRegister();
                    }
                  },
                  child: Text(
                    'DAFTAR',
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
