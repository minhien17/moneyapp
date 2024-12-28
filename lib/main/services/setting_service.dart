import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneyapp/main/utils/shared_preference.dart';

class SettingService extends GetxService {
  Locale locale = Locale('en');

  Future<SettingService> init() async {
    getLocale();
    return this;
  }

  void getLocale() async {
    String s = await SharedPreferenceUtils.getLocale();
    locale = Locale(s);
  }

  void saveLocale(String s) {
    SharedPreferenceUtils.saveLocale(s);
  }
}
