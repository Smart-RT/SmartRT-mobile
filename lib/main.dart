import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smart_rt/constants/theme.dart';
import 'package:smart_rt/routes/routes.dart';
import 'package:smart_rt/screens/public_screens/authentications/welcomePage.dart';
import 'package:smart_rt/screens/public_screens/test_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bool isDebugging = true;
  if (isDebugging) {
    debugPrint = (String? message, {int? wrapWidth}) => log('Debug: $message');
    debugPrint('[Main.Dart] => loadApp');
  }

  runApp(const SmartRTApp());
}

class SmartRTApp extends StatefulWidget {
  const SmartRTApp({Key? key}) : super(key: key);

  @override
  State<SmartRTApp> createState() => _SmartRTAppState();
}

class _SmartRTAppState extends State<SmartRTApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getThemeData(),
      home: const WelcomePage(),
      initialRoute: WelcomePage.id,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

