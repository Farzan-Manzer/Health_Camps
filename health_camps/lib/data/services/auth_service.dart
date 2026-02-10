import 'package:health_camps/data/services/api_client.dart';

class AuthService {
  AuthService._();

  // ---------------- LOGIN ----------------
  static Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await ApiClient.instance.post(
      '/auth/login',
      data: {'username': username, 'password': password},
    );

    if (response.data is! Map<String, dynamic>) {
      throw 'Invalid login response format';
    }

    final data = response.data as Map<String, dynamic>;

    if (!data.containsKey('token')) {
      throw 'Token not found in response';
    }

    return data;
  }
}
