import 'package:dio/dio.dart';
import 'package:health_camps/data/services/secure_storage_service.dart';

class ApiClient {
  ApiClient._() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://healths-api.farzan.manzer.in',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    //interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }

  static final ApiClient instance = ApiClient._();

  late final Dio dio;

  // GET
  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // POST
  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  //TOKEN
  Future<String?> _getToken() async {
    return await SecureStorageService.getToken();
  }

  //ERROR HANDLER
  String _handleDioError(DioException error) {
    if (error.response != null) {
      return error.response?.data.toString() ?? 'Server error';
    } else {
      return 'Network error. Please check your connection.';
    }
  }
}
