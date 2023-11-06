import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:smart_rt/constants/theme.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/application_provider.dart';
import 'package:smart_rt/providers/area_bill_provider.dart';
import 'package:smart_rt/providers/arisan_provider.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:smart_rt/providers/committe_provider.dart';
import 'package:smart_rt/providers/event_provider.dart';
import 'package:smart_rt/providers/health_provider.dart';
import 'package:smart_rt/providers/neighbourhood_head_provider.dart';
import 'package:smart_rt/providers/news_provider.dart';
import 'package:smart_rt/providers/population_provider.dart';
import 'package:smart_rt/providers/role_request_provider.dart';
import 'package:smart_rt/providers/setting_provider.dart';
import 'package:smart_rt/providers/subscribe_provider.dart';
import 'package:smart_rt/providers/voting_provider.dart';
import 'package:smart_rt/routes/routes.dart';
import 'package:smart_rt/screens/admin_screens/home/beranda_admin_page.dart';
import 'package:smart_rt/screens/public_screens/authentications/login_page.dart';
import 'package:smart_rt/screens/public_screens/home/public_home.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isDebugging = true;
  if (isDebugging) {
    debugPrint = (String? message, {int? wrapWidth}) => log('Debug: $message');
    debugPrint('[Main.Dart] => loadApp');
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Baca Storage...
  await ApplicationProvider.loadApp();
  await AuthProvider.loadNotification();

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
    } else if (roleUser == Role.None) {
      routeStart = LoginPage.id;
    } else {
      routeStart = PublicHome.id;
    }
    Future.delayed(const Duration(milliseconds: 500), () {
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
        ChangeNotifierProvider(create: ((context) => ArisanProvider())),
        ChangeNotifierProvider(create: ((context) => HealthProvider())),
        ChangeNotifierProvider(create: ((context) => EventProvider())),
        ChangeNotifierProvider(create: ((context) => NewsProvider())),
        ChangeNotifierProvider(create: ((context) => CommitteProvider())),
        ChangeNotifierProvider(create: ((context) => VotingProvider())),
        ChangeNotifierProvider(create: ((context) => PopulationProvider())),
        ChangeNotifierProvider(create: ((context) => RoleRequestProvider())),
        ChangeNotifierProvider(create: ((context) => SettingProvider())),
        ChangeNotifierProvider(create: ((context) => SubscribeProvider())),
        ChangeNotifierProvider(
            create: ((context) => NeighbourhoodHeadProvider())),
        ChangeNotifierProvider(create: ((context) => AreaBillProvider())),
      ],
      builder: (context, child) {
        ApplicationProvider.context = context;
        return MaterialApp(
          title: 'Flutter Demo',
          theme: getThemeData(),
          initialRoute: routeStart,
          onGenerateRoute: Routes.generateRoute,
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            MonthYearPickerLocalizations.delegate,
          ],
        );
      },
    );
  }
}
