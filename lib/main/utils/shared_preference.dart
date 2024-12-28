import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPrefCache {
  static const String KEY_LOCALE = "app_locale";
}

class SharedPreferenceUtils {
  static Future saveLocale(String localeStr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SPrefCache.KEY_LOCALE, localeStr);
  }

  static Future<String> getLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SPrefCache.KEY_LOCALE) ?? "en";
  }
}
