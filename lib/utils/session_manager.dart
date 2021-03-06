import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  static setListDynamicData(String key, List<dynamic> val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, val);
  }

  static Future<List<dynamic>> getListDynamicData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var yourList = prefs.getStringList(key);
    return yourList;
  }

  static void setStringData(String key, String val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  static void setDateTime(String key, String val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, val);
  }

  static Future<String> getDateTime(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static void setStringList(String key, List<String> val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, val);
  }

  static void setIntData(String key, int val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, val);
  }

  static void setBooleanData(String key, bool val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, val);
  }

  static getStringData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<int> getIntData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? 0;
  }

   static void getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getStringList(key);
  }

  static Future<bool> removeString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key) ?? false;
  }

  static Future<bool> clearSession() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.clear() ?? false;
  }

  static Future<bool> getBooleanData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key)?? false;
  }

  static void setDayStreakData(String key, int val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, val);
  }

  static Future<String> getDayStreakData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? '';
  }

}
