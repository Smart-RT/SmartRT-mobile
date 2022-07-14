import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/constants/config.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_1.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dio/dio.dart';
import 'package:smart_rt/utilities/net_util.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _noTelpController = TextEditingController();
  TextEditingController _kataSandiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  void doLogin() async {
    try {
      var response = await NetUtil.dioClient.post('/users/login', data: {
        "phone": _noTelpController.text,
        "password": _kataSandiController.text
      });
      debugPrint(response.toString());
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint(e.response!.data.toString());
      }
    }
  }

  void gotoRegister() {
    Navigator.pushReplacementNamed(context, RegisterPage1.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Lottie.asset(
                            'assets/lotties/welcome/welcome-smile.json',
                            fit: BoxFit.fitWidth),
                      ),
                      Text(
                        '- SMART RT -',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _noTelpController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomor Telepon tidak boleh kosong';
                          }
                        },
                        style: Theme.of(context).textTheme.bodyText2,
                        decoration: InputDecoration(
                          labelText: 'Nomor Telepon',
                          floatingLabelStyle: Theme.of(context)
                              .inputDecorationTheme
                              .floatingLabelStyle!
                              .copyWith(
                                color: Color(0xffb4a290),
                              ),
                          labelStyle: Theme.of(context).textTheme.bodyText2,
                          enabledBorder: Theme.of(context)
                              .inputDecorationTheme
                              .enabledBorder!
                              .copyWith(
                                borderSide: const BorderSide(
                                  color: Color(
                                    0xffb4a290,
                                  ),
                                ),
                              ),
                          focusedBorder: Theme.of(context)
                              .inputDecorationTheme
                              .focusedBorder!
                              .copyWith(
                                borderSide:
                                    const BorderSide(color: Color(0xffb4a290)),
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: _kataSandiController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kata Sandi tidak boleh kosong';
                          }
                        },
                        style: Theme.of(context).textTheme.bodyText2,
                        obscureText: _isObscure,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Kata Sandi',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xffb4a290),
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          floatingLabelStyle: Theme.of(context)
                              .inputDecorationTheme
                              .floatingLabelStyle!
                              .copyWith(
                                color: Color(0xffb4a290),
                              ),
                          labelStyle: Theme.of(context).textTheme.bodyText2,
                          enabledBorder: Theme.of(context)
                              .inputDecorationTheme
                              .enabledBorder!
                              .copyWith(
                                borderSide: const BorderSide(
                                  color: Color(
                                    0xffb4a290,
                                  ),
                                ),
                              ),
                          focusedBorder: Theme.of(context)
                              .inputDecorationTheme
                              .focusedBorder!
                              .copyWith(
                                borderSide: const BorderSide(
                                  color: Color(0xffb4a290),
                                ),
                              ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: Theme.of(context)
                              .elevatedButtonTheme
                              .style!
                              .copyWith(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xffb4a290))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              doLogin();
                            }
                            // Dio dio = Dio(BaseOptions(baseUrl: backendURL));
                            // Response<dynamic> response = await dio.get("/users");
                            // debugPrint(response.toString());
                            // Kalau Get, parameternya kan ada 2 tipe
                            // 1. parameter
                            // 2. Query Parameter
                            // Parameter itu yang di /:nama_variabel, contoh users/1
                            // Query parameter itu yang ? sama & contoh limit=1&ganteng=true
                            // Query Parameter pake ini di dio queryParameters: {"limit": 1, "ganteng": true}
                            // Kalau Post, put, dan Patch kan punya body
                            // Cara lempar body pake attribut data di dio
                            // await dio.post("/users",
                            //     data: {
                            //       "nama": "jose",
                            //       "password": "gantengsekali9988"
                            //     },
                            //     options: Options(
                            //         contentType:
                            //             Headers.formUrlEncodedContentType));
                          },
                          child: Text(
                            'MASUK',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.brown[400],
                          ),
                          children: [
                            const TextSpan(text: 'Tidak mempunyai akun? '),
                            TextSpan(
                              text: ' Daftar Sekarang',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffb4a290),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  gotoRegister();
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
