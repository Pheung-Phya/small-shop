import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:state_management/widgets/screen.dart';
import 'package:state_management/widgets/translation_model.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    String? savedLanguage = box.read('languageCode');
    if (savedLanguage != null) {
      Get.updateLocale(Locale(savedLanguage));
    }
    return GetMaterialApp(
      translations: TranslationModel(),
      locale:
          savedLanguage != null ? Locale(savedLanguage) : const Locale('us'),
      fallbackLocale: const Locale('us'),
      home: Screen(),
    );
  }
}
