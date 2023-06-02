import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/authentications/otp_page.dart';
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
      var response = await NetUtil().dioClient.post('/users/register', data: {
        "noTelp": _noTelpController.text,
        "kataSandi": _kataSandiController.text,
        "namaLengkap": widget.args.namaLengkap,
        "jenisKelamin": widget.args.jenisKelamin,
        "tanggalLahir": widget.args.tanggalLahir
      });

      int newUserID = int.parse(response.data.toString());

      if (response.statusCode.toString() == '200') {
        var resp = await NetUtil().dioClient.post('/users/role/log/add', data: {
          "user_id": newUserID,
          "after_user_role_id": 2,
        });
        gotoOTP();
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  void gotoOTP() {
    OTPPageArguments argsForOTPPage = OTPPageArguments(
        namaLengkap: widget.args.namaLengkap,
        jenisKelamin: widget.args.jenisKelamin,
        tanggalLahir: widget.args.tanggalLahir,
        kataSandi: _kataSandiController.text,
        noTelp: _noTelpController.text);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, OTPPage.id,
        arguments: argsForOTPPage);
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
          padding: paddingScreen,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Akun Anda',
                    style: smartRTTextTitle_Primary,
                  ),
                  Text(
                    'Pastikan anda mengisi dengan no telp yang valid dan kata sandi yang tidak mudah ditebak orang lain',
                    style: smartRTTextNormal_Primary,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    style: smartRTTextNormal_Primary,
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
                  SB_height15,
                  TextFormField(
                    obscureText: _isObscure,
                    enableSuggestions: false,
                    autocorrect: false,
                    style: smartRTTextNormal_Primary,
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: smartRTPrimaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      labelStyle: smartRTTextNormal_Primary,
                    ),
                    controller: _kataSandiController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Kata Sandi tidak boleh kosong';
                      }
                    },
                  ),
                  SB_height15,
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
