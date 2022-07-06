import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/screens/public_screens/authentications/register_page.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height-50,
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
                    TextField(
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        labelText: 'Nomor Telepon',
                        floatingLabelStyle: Theme.of(context).inputDecorationTheme.floatingLabelStyle!.copyWith(
                          color: Color(0xffb4a290),
                        ),
                        labelStyle: const TextStyle(
                          color: Color(0xffb4a290),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Color(0xffb4a290)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Color(0xffb4a290)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      style: Theme.of(context).textTheme.bodyText2,
                      obscureText: _isObscure,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'Kata Sandi',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xffb4a290),
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        floatingLabelStyle: Theme.of(context).inputDecorationTheme.floatingLabelStyle!.copyWith(
                          color: Color(0xffb4a290),
                        ),
                        labelStyle: const TextStyle(
                          color: Color(0xffb4a290),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Color(0xffb4a290)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Color(0xffb4a290)),
                          borderRadius: BorderRadius.circular(5),
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
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xffb4a290),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'MASUK',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
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
                            recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.pushNamed(context, RegisterPage.id);
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
    );
  }
}
