import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/screens/public_screens/authentications/loginPage.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child:
                      Lottie.asset('assets/lotties/welcome/welcome-group.json'),
                ),
                const Text(
                  'Selamat Datang !',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.brown,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.brown[400],
                    ),
                    children: const <TextSpan>[
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
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(width: 3, color: Colors.brown),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'DAFTAR BUAT AKUN',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.brown,
                      ),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()..onTap = () {
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
