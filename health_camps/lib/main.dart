import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_camps/modules/auth/auth_controller.dart';
import 'package:health_camps/routes/app_pages.dart';
import 'package:health_camps/data/services/secure_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final token = await SecureStorageService.getToken();
  Get.put(AuthController());

  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? AppPages.camp : AppPages.login,
      getPages: AppPages.routes,
    );
  }
}
