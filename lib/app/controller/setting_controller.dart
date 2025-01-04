import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingController extends GetxController {
  var themeMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    themeMode.value = prefs.getBool('isDarkMode') ?? false;
    Get.changeTheme(themeMode.value ? ThemeData.dark() : ThemeData.light());
  }

  void toggleTheme() async {
    themeMode.value = !themeMode.value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', themeMode.value);
    Get.changeTheme(themeMode.value ? ThemeData.dark() : ThemeData.light());
  }
}
