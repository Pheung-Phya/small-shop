import 'dart:ui';
import 'package:get/get.dart';

class TraslationController extends GetxController {
  var currentLanguage = 'us';
  void changeLanguage(String languageCode) {
    currentLanguage = languageCode;
    Get.updateLocale(Locale(languageCode));
  }
}
