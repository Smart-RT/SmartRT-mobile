import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/screens/public_screens/authentications/otp_page.dart';
import 'package:smart_rt/utilities/net_util.dart';
import 'package:smart_rt/widgets/parts/explain_part.dart';

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
        title: Text('DAFTAR AKUN ( 2 / 2)'),
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
                    title: 'Akun Anda',
                    notes:
                        'Pastikan anda mengisi dengan no telp yang valid dan kata sandi yang tidak mudah ditebak orang lain'),
                SB_height30,
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  style: smartRTTextNormal,
                  decoration: const InputDecoration(
                    labelText: 'Nomor Telepon',
                  ),
                  controller: _noTelpController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nomor Telepon tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                SB_height15,
                TextFormField(
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: smartRTTextNormal,
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
                    labelStyle: smartRTTextNormal,
                  ),
                  controller: _kataSandiController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kata Sandi tidak boleh kosong';
                    }
                    return null;
                  },
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
                doRegister();
              }
            },
            child: Text(
              'DAFTAR',
              style: smartRTTextLarge.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
