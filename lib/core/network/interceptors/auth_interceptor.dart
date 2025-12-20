import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:project/core/logging/index.dart';

/// An interceptor for adding authentication headers to requests
class AuthInterceptor extends Interceptor {
  final AppLogger _logger = AppLogger();
  final Dio _dio;

  /// Function to get the current access token
  final Future<String?> Function() getToken;

  /// Function to refresh the token when it expires
  final Future<String?> Function() refreshToken;

  /// Whether a token refresh is in progress
  bool _isRefreshing = false;

  /// Requests waiting for token refresh
  final List<_RequestQueueItem> _queue = [];

  /// Creates an auth interceptor with token management
  AuthInterceptor(
    this._dio, {
    required this.getToken,
    required this.refreshToken,
  });

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (!options.path.contains('/auth/')) {
      // Only add token to non-auth endpoints
      final token = await getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
        _logger.d('Adding auth token to request: ${options.path}');
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      _logger.d('Received 401 unauthorized, attempting to refresh token');

      // Try to refresh the token if we get a 401
      try {
        final options = err.requestOptions;

        // Don't try to refresh token for refresh token requests
        if (options.path.contains('/auth/refresh')) {
          return handler.next(err);
        }

        // Handle refresh token flow
        if (_isRefreshing) {
          // If already refreshing, queue this request
          await _queueRequest(err, handler);
          return;
        }

        // Start refreshing
        _isRefreshing = true;

        // Get a new token
        final newToken = await refreshToken();

        // If token refresh failed, propagate the error
        if (newToken == null) {
          _logger.e('Token refresh failed');
          // Process queued requests with the error
          _processQueue(null, err);
          return handler.next(err);
        }

        // Successfully refreshed token
        _logger.d('Token refreshed successfully');

        // Retry original request with new token
        options.headers['Authorization'] = 'Bearer $newToken';

        // Process queued requests with the new token
        _processQueue(newToken, null);

        // Retry the original request
        _logger.d('Retrying original request: ${options.path}');
        final response = await _dio.fetch(options);
        return handler.resolve(response);
      } catch (e) {
        _logger.e('Error during token refresh: $e');
        _isRefreshing = false;
        // Process queued requests with the error
        _processQueue(null, err);
        return handler.next(err);
      } finally {
        _isRefreshing = false;
      }
    }

    // For other errors, just pass them through
    return handler.next(err);
  }

  /// Queue a request to be retried after token refresh
  Future<void> _queueRequest(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _logger.d('Queueing request: ${err.requestOptions.path}');

    final completer = Completer<void>();

    _queue.add(
      _RequestQueueItem(
        options: err.requestOptions,
        handler: handler,
        completer: completer,
      ),
    );

    return completer.future;
  }

  /// Process all queued requests with the refreshed token or error
  void _processQueue(String? token, DioException? error) {
    _logger.d('Processing ${_queue.length} queued requests');

    for (final item in _queue) {
      if (token != null) {
        // Retry with new token
        item.options.headers['Authorization'] = 'Bearer $token';
        _dio
            .fetch(item.options)
            .then(
              (response) {
                item.handler.resolve(response);
                item.completer.complete();
              },
              onError: (e) {
                final dioError = e as DioException;
                item.handler.next(dioError);
                item.completer.complete();
              },
            );
      } else if (error != null) {
        // Pass along the error
        item.handler.next(error);
        item.completer.complete();
      }
    }

    _queue.clear();
  }
}

/// Represents a queued request waiting for token refresh
class _RequestQueueItem {
  /// The original request options
  final RequestOptions options;

  /// The error handler for the request
  final ErrorInterceptorHandler handler;

  /// Completer to resolve when the request is processed
  final Completer<void> completer;

  _RequestQueueItem({
    required this.options,
    required this.handler,
    required this.completer,
  });
}
