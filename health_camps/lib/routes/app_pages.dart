import 'package:get/get.dart';
import 'package:health_camps/modules/auth/auth_binding.dart';
import 'package:health_camps/modules/auth/login_view.dart';
import 'package:health_camps/modules/camp/camp_view.dart';

class AppPages {
  static const login = '/login';
  static const camp = '/camp';

  static final routes = [
    GetPage(name: login, page: () => const LoginView(), binding: AuthBinding()),
    GetPage(name: camp, page: () => CampView(), binding: AuthBinding()),
  ];
}
