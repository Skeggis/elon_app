import 'package:shared_preferences/shared_preferences.dart';

class UsersPreferences {
  static final String _uuid = 'uuid';
  static final String _isLoggedInWithGoogle = 'isLoggedInWithGoogle';

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_uuid) != null && prefs.getString(_uuid) != '';
  }

  static Future<bool> setUsersUUID(String uuid,
      {bool isLoggedInWithGoogle = false}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_isLoggedInWithGoogle, isLoggedInWithGoogle);
    return prefs.setString(_uuid, uuid);
  }
}
