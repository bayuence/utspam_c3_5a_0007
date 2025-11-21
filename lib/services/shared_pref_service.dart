import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefService {
  static SharedPreferences? _prefs;

  //dipanggil di main
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //simpan data register
  static Future<void> saveUser(String username, String password) async {
    await _prefs?.setString('saved_username', username);
    await _prefs?.setString('saved_password', password); 
  }

  //ambil data register
  static Map<String, String>? getUser() {
    final username = _prefs?.getString('saved_username');
    final password = _prefs?.getString('saved_password');

    if (username != null && password != null) {
      return {
        'username': username,
        'password': password,
      };
    }
    return null;
  }
}