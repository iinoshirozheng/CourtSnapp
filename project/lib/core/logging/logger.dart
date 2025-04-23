import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Log levels for the application
enum LogLevel { debug, info, warning, error }

/// A centralized logger for the application
class AppLogger {
  /// Internal singleton instance
  static final AppLogger _instance = AppLogger._internal();

  /// Factory constructor to return the same instance
  factory AppLogger() => _instance;

  /// Private constructor
  AppLogger._internal();

  /// Whether to show debug logs
  bool _showDebugLogs = kDebugMode;

  /// Configure the logger
  void configure({bool showDebugLogs = kDebugMode}) {
    _showDebugLogs = showDebugLogs;
  }

  /// Log a debug message
  void d(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    if (_showDebugLogs) {
      _log(
        LogLevel.debug,
        message,
        tag: tag,
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Log an info message
  void i(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(
      LogLevel.info,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a warning message
  void w(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(
      LogLevel.warning,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log an error message
  void e(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Internal log method
  void _log(
    LogLevel level,
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final logTag = tag ?? 'CourtSnapp';
    final logLevel = level.toString().split('.').last.toUpperCase();
    final timestamp = DateTime.now().toIso8601String();
    final logMessage = '[$timestamp] $logLevel: $message';

    if (kDebugMode) {
      developer.log(
        logMessage,
        name: logTag,
        error: error,
        stackTrace: stackTrace,
      );
    }

    // In production, you could add integration with a crash reporting service like Firebase Crashlytics
    if (level == LogLevel.error && !kDebugMode) {
      // TODO: Report to crash reporting service
      // Example: FirebaseCrashlytics.instance.recordError(error, stackTrace);
    }
  }
}
