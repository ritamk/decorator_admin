import 'dart:convert';

import 'package:decorator_admin/model/employee_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static SharedPreferences? sharedPreferences;

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static const String _loggedInKey = "loggedIn";
  static const String _uidKey = "uid";
  static const String _userDetailKey = "userDetail";

  static Future<bool> setLoggedIn(bool loggedInOrNot) async =>
      await sharedPreferences!.setBool(_loggedInKey, loggedInOrNot);

  static bool getLoggedIn() {
    try {
      return sharedPreferences!.getBool(_loggedInKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> setUid(String uid) async =>
      await sharedPreferences!.setString(_uidKey, uid);

  static String? getUid() {
    try {
      String? user = sharedPreferences!.getString(_uidKey);
      return user != null
          ? user == ""
              ? null
              : user
          : null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> setDetailedUserData(EmployeeModel employee) async =>
      await sharedPreferences!.setString(
          _userDetailKey,
          jsonEncode({
            "name": employee.name,
            "email": employee.email,
            "phone": employee.phone,
          }));

  static EmployeeModel? getDetailedUseData() {
    try {
      final String? data = sharedPreferences!.getString(_userDetailKey);
      if (data != null) {
        final Map<String, dynamic> decoded = jsonDecode(data);
        if (decoded["name"] == null) return null;
        return EmployeeModel(
          name: decoded["name"],
          email: decoded["email"],
          phone: decoded["phone"],
        );
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
