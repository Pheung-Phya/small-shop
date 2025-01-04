import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:state_management/app/controller/setting_controller.dart';

class Setting extends StatelessWidget {
  Setting({super.key});

  final SettingController themeMode = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Change Background'),
                Obx(() {
                  return Switch(
                    value: !themeMode.themeMode.value,
                    onChanged: (value) {
                      themeMode.toggleTheme();
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
