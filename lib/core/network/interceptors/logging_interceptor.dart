import 'package:dio/dio.dart';
import 'package:project/core/logging/index.dart';

/// An interceptor for logging HTTP requests and responses
class LoggingInterceptor extends Interceptor {
  final AppLogger _logger = AppLogger();

  /// Whether to log request/response bodies (can be expensive for large payloads)
  final bool logBody;

  /// Creates a logging interceptor
  LoggingInterceptor({this.logBody = false});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d('┌─────────────── Request ───────────────');
    _logger.d('│ ${options.method} ${options.uri}');
    _logger.d('│ Headers: ${_formatHeaders(options.headers)}');

    if (logBody && options.data != null) {
      _logger.d('│ Body: ${options.data}');
    }

    _logger.d('└─────────────────────────────────────');

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d('┌─────────────── Response ──────────────');
    _logger.d(
      '│ ${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    _logger.d('│ Status: ${response.statusCode}');
    _logger.d('│ Headers: ${_formatHeaders(response.headers.map)}');

    if (logBody) {
      _logger.d('│ Body: ${response.data}');
    }

    _logger.d('└─────────────────────────────────────');

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('┌─────────────── Error ─────────────────');
    _logger.e('│ ${err.requestOptions.method} ${err.requestOptions.uri}');
    _logger.e('│ Status: ${err.response?.statusCode}');
    _logger.e('│ Error: ${err.error}');

    if (err.response != null) {
      _logger.e('│ Response: ${err.response?.data}');
    }

    _logger.e('└─────────────────────────────────────');

    return super.onError(err, handler);
  }

  /// Format headers for nicer logging output
  String _formatHeaders(Map<String, dynamic> headers) {
    final formatted = <String, dynamic>{};
    headers.forEach((key, value) {
      // Mask authorization header values for security
      if (key.toLowerCase() == 'authorization') {
        formatted[key] = 'Bearer ********';
      } else {
        formatted[key] = value;
      }
    });
    return formatted.toString();
  }
}
