import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Ini pake yang diatas aja, sama kok.
  debugPrint("Dapet message di background.");
  debugPrint("Handling a background message: ${message.messageId}");
  ApplicationProvider.showNotification(
      hashCode: message.hashCode,
      notificationTitle: message.data["title"],
      notificationBody: message.data["body"]);
}

class ApplicationProvider extends ChangeNotifier {
  // Buat static context
  static BuildContext? context;

  // Buat Flutter Storage
  static final storage = FlutterSecureStorage();

  // Buat variable untuk tampung user dan jwt dan refreshToken
  static String currentUserJWT = '';
  static String currentUserRefreshToken = '';

  // Buat Function yang jalanin Notify Listener
  void updateListener() => notifyListeners();

  // Misal Nanti mode akan diisi dengan warga / RT
  Role mode = Role.None;

  // Untuk Notifikasi
  static final FlutterLocalNotificationsPlugin localNotification =
      FlutterLocalNotificationsPlugin();
  static const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  static const InitializationSettings initializationSettings =
      InitializationSettings(android: androidInitSettings);

  static const AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    "smart_rt_notifications",
    "SmartRT Notifications",
    channelDescription: "All SmartRT Notifications",
    importance: Importance.max,
    priority: Priority.high,
    groupKey: 'smart_rt_notifications',
    playSound: true,
    styleInformation: BigTextStyleInformation(''),
    setAsGroupSummary: true,
  );
  static const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);
  static const AndroidNotificationChannel androidNotificationChannel =
      AndroidNotificationChannel(
          "smart_rt_notifications", "SmartRT Notifications",
          description: "All SmartRT Notifications", importance: Importance.max);

  void changeApplicationMode(Role newMode) {
    mode = newMode;
    notifyListeners();
  }

  static Future<void> loadApp() async {
    await Future.wait([
      // Load Data User
      initNotificationSystem(),
      loadDataUser(),
    ]);
  }

  void initApp(BuildContext? context) async {
    // Nanti kalau mau inisialisasi firebase disini
    await Future.wait([]);
    // Kalau udah notify listener
    notifyListeners();
  }

  static Future<void> initNotificationSystem() async {
    localNotification.initialize(initializationSettings);
    await localNotification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  static Future<void> showNotification(
      {required int hashCode,
      required String notificationTitle,
      required String notificationBody}) async {
    await localNotification.show(hashCode, "$notificationTitle",
        "$notificationBody", notificationDetails);
  }

  static Future<void> loadDataUser() async {
    String? jwt = await ApplicationProvider.storage.read(key: 'jwt');
    String? refreshToken =
        await ApplicationProvider.storage.read(key: 'refreshToken');
    String? user = await ApplicationProvider.storage.read(key: 'user');
    if (user != null && user != "") {
      debugPrint(user);
      AuthProvider.currentUser = User.fromData(jsonDecode(user));
      AuthProvider.isLoggedIn = true;

      // debugPrint("USER dari Storage: ${AuthProvider.currentUser!.token}");
      // Response<dynamic> resp = await NetUtil().dioClient.get('/users/myProfile',
      //     options: Options(headers: {
      //       "Authorization": "bearer ${AuthProvider.currentUser!.token}"
      //     }));
      // User u = User.fromData(resp.data);
      // AuthProvider.currentUser = u;
    }
    currentUserJWT = jwt ?? '';
    currentUserRefreshToken = refreshToken ?? '';
  }
}
