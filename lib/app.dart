import 'package:flutter/material.dart';
import 'package:project_locator/controller_binder.dart';
import 'package:project_locator/screens/home_screen.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Locate Me',
      home: const HomeScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
