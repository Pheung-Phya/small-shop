import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/app/controller/setting_controller.dart';
import 'package:state_management/app/view/card_product.dart';
import 'package:state_management/app/view/checkout_product.dart';
import 'package:state_management/app/view/home_product.dart';
import 'package:state_management/app/view/setting.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // themeMode: SettingController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeProduct(),
        '/card': (context) => const CardProduct(),
        '/checkout': (context) => const CheckoutProduct(),
        '/setting': (context) => Setting()
      },
    );
  }
}
