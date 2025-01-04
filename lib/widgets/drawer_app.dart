import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Image.asset('assets/ganzberg.jpg'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('H O M E'),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('A B O U T'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('S E T T I N G'),
            onTap: () {
              Get.back();
              //       Get.to(SettingScreen());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('L O G O U T'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
