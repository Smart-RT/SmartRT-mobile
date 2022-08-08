import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:smart_rt/screens/guest_screens/home/guest_home.dart';
import 'package:smart_rt/screens/public_screens/janji_temu/list_janji_temu_page.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:smart_rt/constants/theme.dart';
import 'package:smart_rt/routes/routes.dart';
import 'package:smart_rt/screens/public_screens/authentications/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isDebugging = true;
  if (isDebugging) {
    debugPrint = (String? message, {int? wrapWidth}) => log('Debug: $message');
    debugPrint('[Main.Dart] => loadApp');
  }

  // Baca Storage...
  await ApplicationProvider.loadApp();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ApplicationProvider())),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: getThemeData(),
          home: const GuestHome(),
          initialRoute: GuestHome.id,
          // home: const WelcomePage(),
          // initialRoute: WelcomePage.id,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
