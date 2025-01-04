import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  var themeMode = false.obs;
  void toggleTheme() {
    themeMode.value = !themeMode.value;
    Get.changeTheme(themeMode.value ? ThemeData.dark() : ThemeData.light());
  }
}
