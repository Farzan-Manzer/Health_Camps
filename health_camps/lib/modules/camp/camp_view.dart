import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_camps/modules/auth/auth_controller.dart';

class CampView extends StatelessWidget {
  CampView({super.key});

  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camp Screen'),
        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
              Get.offAllNamed('/login');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('You are logged in Bro', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
