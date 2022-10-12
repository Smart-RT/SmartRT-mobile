import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_rt/models/user.dart';
import 'package:smart_rt/providers/auth_provider.dart';

class ApplicationProvider extends ChangeNotifier {
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

  static Future<void> loadDataUser() async {
    String? jwt = await ApplicationProvider.storage.read(key: 'jwt');
    String? refreshToken =
        await ApplicationProvider.storage.read(key: 'refreshToken');
    String? user = await ApplicationProvider.storage.read(key: 'user');
    if (user != null && user != "") {
      AuthProvider.currentUser = User.fromData(jsonDecode(user));
      AuthProvider.isLoggedIn = true;
      debugPrint("USER dari Storage: ${AuthProvider.currentUser!.id}");
    }
    // currentUserJWT = jwt ?? '';
    // currentUserRefreshToken = refreshToken ?? '';
  }
}
