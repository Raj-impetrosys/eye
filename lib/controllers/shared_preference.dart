import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static Future saveEmployeeInfo(
      {required int id,
      required String firstName,
      required String lastName}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("id", id);
    await prefs.setString("firstName", firstName);
    await prefs.setString("lastName", lastName);
    await prefs.setBool("isLogin", true);
  }

  static Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("id");
  }

  static Future<String?> getFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("firstName");
  }

  static Future<String?> getLastName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("lastName");
  }

  static Future<bool> getIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false;
  }

  static Future logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}
