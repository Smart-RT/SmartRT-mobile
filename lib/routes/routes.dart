import 'package:flutter/material.dart';
import 'package:smart_rt/screens/public_screens/authentications/loginPage.dart';
import 'package:smart_rt/screens/public_screens/authentications/welcomePage.dart';
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
