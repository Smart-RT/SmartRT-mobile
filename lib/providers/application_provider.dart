import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_rt/models/user/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';

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

  void changeApplicationMode(Role newMode) {
    mode = newMode;
    notifyListeners();
  }

  static Future<void> loadApp() async {
    await Future.wait([
      // Load Data User
      loadDataUser(),
    ]);
  }

  void initApp(BuildContext? context) async {
    // Nanti kalau mau inisialisasi firebase disini
    // Buat sistem notifikasi
    await Future.wait([]);
    // Kalau udah notify listener
    notifyListeners();
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
