import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //simpan data user
  static Future<void> saveUser({
    required String name,
    required String username,
    required String email,
    required String phone,
    required String password,
  }) async {
    await _prefs?.setString('user_name', name);
    await _prefs?.setString('user_username', username);
    await _prefs?.setString('user_email', email);
    await _prefs?.setString('user_phone', phone);
    await _prefs?.setString('user_password', password);
  }

  //ambil data user
  static Map<String, String>? getUser() {
    final name = _prefs?.getString('user_name');
    final username = _prefs?.getString('user_username');
    final email = _prefs?.getString('user_email');
    final phone = _prefs?.getString('user_phone');
    final password = _prefs?.getString('user_password');

    if (name != null &&
        username != null &&
        email != null &&
        phone != null &&
        password != null) {
      return {
        'name': name,
        'username': username,
        'email': email,
        'phone': phone,
        'password': password,
      };
    }
    return null;
  }

  static Future<void> setLoginStatus(bool value) async {
    await _prefs?.setBool('isLoggedIn', value);
  }

  static Future<void> logout() async {
    await _prefs?.remove('isLoggedIn');
  }
}
