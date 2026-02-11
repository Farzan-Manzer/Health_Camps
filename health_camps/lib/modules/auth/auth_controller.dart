import 'package:get/get.dart';
import 'package:health_camps/data/services/auth_service.dart';
import 'package:health_camps/data/services/secure_storage_service.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final result = await AuthService.login(
        username: username,
        password: password,
      );

      final token = result['token'];
      await SecureStorageService.saveToken(token);

      isLoggedIn.value = true;
      Get.offAllNamed('/camp');

      // Navigation will be added later
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await SecureStorageService.deleteToken();
    isLoggedIn.value = false;
  }
}
