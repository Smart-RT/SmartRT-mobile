import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_rt/constants/colors.dart';
import 'package:smart_rt/constants/size.dart';
import 'package:smart_rt/constants/style.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:smart_rt/screens/public_screens/authentications/login_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_1.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  static const String id = 'WelcomePage';
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  void gotoRegister() {
    Navigator.pushNamed(context, RegisterPage1.id);
  }

  void gotoLogin() {
    Navigator.pushNamed(context, LoginPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: smartRTPrimaryColor,
      body: Container(
        padding: paddingScreen,
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
                  style: smartRTTitleText_Secondary,
                ),
                SB_height15,
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: smartRTTextLarge_Secondary,
                    children: <TextSpan>[
                      const TextSpan(
                          text:
                              'Kelola dan tingkatkan kualitas Rukun Tetangga anda dengan '),
                      TextSpan(
                        text: 'MUDAH ',
                        style: smartRTTextLargeBold_Secondary,
                      ),
                      const TextSpan(text: 'dan '),
                      TextSpan(
                        text: 'AMAN',
                        style: smartRTTextLargeBold_Secondary,
                      ),
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
                    style: Theme.of(context)
                        .elevatedButtonTheme
                        .style!
                        .copyWith(
                            backgroundColor: MaterialStateProperty.all(
                                smartRTSecondaryColor)),
                    onPressed: () {
                      gotoRegister();
                      // context.watch<ApplicationProvider>();
                    },
                    child: Text(
                      'DAFTAR SEKARANG',
                      style: smartRTTextLargeBold_Primary,
                    ),
                  ),
                ),
                SB_height15,
                RichText(
                  text: TextSpan(
                    style: smartRTTextSmall_Secondary,
                    children: [
                      const TextSpan(text: 'Sudah mempunyai akun? '),
                      TextSpan(
                        text: ' Masuk Sekarang',
                        style: smartRTTextSmallBold_Secondary,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            gotoLogin();
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
