import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/screens/public_screens/authentications/login_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_1.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'WelcomePage';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Color(0xffb4a290),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'Kelola dan tingkatkan kualitas Rukun Tetangga anda dengan '),
                      TextSpan(
                          text: 'MUDAH ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'dan '),
                      TextSpan(
                          text: 'AMAN',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
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
                    style: Theme.of(context).elevatedButtonTheme.style!.copyWith(backgroundColor: MaterialStateProperty.all(Color(0xffb4a290))),
                    onPressed: () {
                      Navigator.pushNamed(context, RegisterPage1.id);
                    },
                    child: Text(
                      'DAFTAR SEKARANG',
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
                      TextSpan(text: 'Sudah mempunyai akun? '),
                      TextSpan(
                        text: ' Masuk Sekarang',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffb4a290),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, LoginPage.id);
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
    );
  }
}
