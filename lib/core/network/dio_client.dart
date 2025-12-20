import 'package:dio/dio.dart';
import 'package:project/core/logging/index.dart';
import 'package:project/core/network/interceptors/index.dart';

/// Factory for creating configured Dio instances
class DioClientFactory {
  final AppLogger _logger = AppLogger();

  /// Create a basic Dio client with common configuration
  Dio createBasicClient({
    String baseUrl = '',
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    Map<String, dynamic>? headers,
    bool logRequests = true,
  }) {
    _logger.d('Creating basic Dio client with baseUrl: $baseUrl');

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        headers: headers ?? {'Content-Type': 'application/json'},
      ),
    );

    if (logRequests) {
      dio.interceptors.add(LoggingInterceptor());
    }

    return dio;
  }

  /// Create an authenticated Dio client with token handling
  Dio createAuthenticatedClient({
    required String baseUrl,
    required Future<String?> Function() getToken,
    required Future<String?> Function() refreshToken,
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    Map<String, dynamic>? headers,
    bool logRequests = true,
  }) {
    _logger.d('Creating authenticated Dio client with baseUrl: $baseUrl');

    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        headers: headers ?? {'Content-Type': 'application/json'},
      ),
    );

    // Add auth interceptor first so it runs before the logging interceptor
    dio.interceptors.add(
      AuthInterceptor(dio, getToken: getToken, refreshToken: refreshToken),
    );

    if (logRequests) {
      dio.interceptors.add(LoggingInterceptor());
    }

    return dio;
  }
}
