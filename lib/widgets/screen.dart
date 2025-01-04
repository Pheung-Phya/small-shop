import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:state_management/widgets/drawer_app.dart';

class Screen extends StatefulWidget {
  Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerApp(),
        appBar: AppBar(
          title: Text('hello'.tr),
        ),
        body: Center(
          child: Column(
            children: [
              Text('how are you?'.tr),
              Text('how are you?'.tr),
            ],
          ),
        ));
  }
}
