import 'dart:convert';

import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:store/core/di/injection_container.dart';
import 'package:store/features/login/data/models/login_model.dart';

class LocalStorage {
  Future<void> saveUserLogin({required LoginModel loginModel}) async {
    final prefs = sl<SecureSharedPref>();
    await prefs.putString('user', jsonEncode(loginModel.toJson()));
  }

  Future<LoginModel?> getUser() async {
    final prefs = sl<SecureSharedPref>();
    final data = await prefs.getString('user');

    if (data != null) {
      return LoginModel.fromJson(jsonDecode(data));
    }

    return null;
  }

  Future<void> clearUser() async {
    final prefs = sl<SecureSharedPref>();
    await prefs.clearAll();
  }
}
