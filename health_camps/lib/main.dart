import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_camps/modules/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Camps',
      home: HomeView()
     );
  }
}
