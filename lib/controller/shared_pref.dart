import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferences {
  static SharedPreferences? sharedPreferences;

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static const String _itemTotalKey = "itemTotal";
  static const String _itemRemainingKey = "itemRemaining";
  static const String _itemRateKey = "itemRate";
}
