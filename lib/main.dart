import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/screens/admin_screens/home/beranda_admin_page.dart';
import 'package:smart_rt/screens/guest_screens/home/guest_home.dart';
import 'package:smart_rt/screens/guest_screens/home/home_part/beranda_page.dart';
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
  String? routeStart;

  @override
  void initState() {
    Role roleUser = AuthProvider.currentUser?.user_role ?? Role.None;
    if (roleUser == Role.Admin) {
      routeStart = BerandaAdminPage.id;
    } else if (roleUser == Role.Guest) {
      routeStart = GuestHome.id;
    } else {
      routeStart = WelcomePage.id;
    }
    Future.delayed(Duration(milliseconds: 500), () {
      ApplicationProvider.context!
          .read<ApplicationProvider>()
          .initApp(ApplicationProvider.context!);
    });
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ApplicationProvider())),
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: getThemeData(),
          // home: const BerandaAdminPage(),we
          // initialRoute: BerandaAdminPage.id,
          // home: const GuestHome(),
          // initialRoute: GuestHome.id,
          // home: const WelcomePage(),
          initialRoute: routeStart,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
