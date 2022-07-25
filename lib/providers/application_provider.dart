import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApplicationProvider extends ChangeNotifier {
  // Buat Flutter Storage
  static final storage = FlutterSecureStorage();

  // Buat variable untuk tampung user dan jwt dan refreshToken
  static String currentUserJWT = '';
  static String currentUserRefreshToken = '';

  // Buat Function yang jalanin Notify Listener
  void updateListener() => notifyListeners();

  // Misal Nanti mode akan diisi dengan warga / RT
  String mode = 'warga';

  void changeApplicationMode(String newMode) {
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
    currentUserJWT = jwt ?? '';
    currentUserRefreshToken = refreshToken ?? '';
  }
}
