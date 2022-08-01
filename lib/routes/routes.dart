import 'package:flutter/material.dart';
import 'package:smart_rt/screens/guest_screens/guest_home.dart';
import 'package:smart_rt/screens/public_screens/authentications/login_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/otp_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_1.dart';
import 'package:smart_rt/screens/public_screens/authentications/register/register_page_2.dart';
import 'package:smart_rt/screens/public_screens/authentications/welcome_page.dart';
import 'package:smart_rt/screens/public_screens/test_screen.dart';
import 'package:smart_rt/screens/public_screens/test_screen2.dart';

class Routes {
  static Route<dynamic> Function(RouteSettings) generateRoute =
      (RouteSettings settings) {
    switch (settings.name) {
      case WelcomePage.id:
        return MaterialPageRoute(builder: (context) {
          return const WelcomePage();
        });
      case LoginPage.id:
        return MaterialPageRoute(builder: (context) {
          return const LoginPage();
        });
      case RegisterPage1.id:
        return MaterialPageRoute(builder: (context) {
          return const RegisterPage1();
        });
      case RegisterPage2.id:
        return MaterialPageRoute(builder: (context) {
          return RegisterPage2(
            args: settings.arguments as RegisterPage2Arguments,
          );
        });
      case OTPPage.id:
        return MaterialPageRoute(builder: (context) {
          return OTPPage(
            args: settings.arguments as OTPPageArguments,
          );
        });
      case GuestHome.id:
        return MaterialPageRoute(builder: (context) {
          return const GuestHome();
        });
      case TestScreen.id:
        return MaterialPageRoute(builder: (context) {
          return const TestScreen();
        });
      case TestScreen2.id:
        return MaterialPageRoute(builder: (context) {
          return const TestScreen2();
        });
      default:
        assert(false, 'ROUTE NAME NOT FOUND');
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return const Scaffold(
              body: Text('ROUTE NAME NOT FOUND'),
            );
          },
        );
    }
  };
}
