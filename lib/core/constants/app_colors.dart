import 'package:flutter/material.dart';

/// Application color scheme constants
class AppColors {
  /// Main brand color - green
  static const Color brandColor = Color(0xFF007F3B);

  /// Error color - red
  static const Color errorColor = Color(0xFFD32F2F);

  /// Success color - green
  static const Color successColor = Color(0xFF4CAF50);

  /// Warning color - amber
  static const Color warningColor = Color(0xFFFFC107);

  /// Info color - blue
  static const Color infoColor = Color(0xFF2196F3);

  /// Background color for input fields
  static const Color inputBgColor = Color(0xFFF5F5F5);

  /// Border color for input fields (unfocused)
  static const Color inputBorderColor = Color(0xFFE0E0E0);

  /// Text color for primary content
  static const Color textPrimary = Color(0xFF212121);

  /// Text color for secondary content
  static const Color textSecondary = Color(0xFF757575);

  /// Text color for hints
  static const Color textHint = Color(0xFF9E9E9E);

  /// Divider color
  static const Color divider = Color(0xFFE0E0E0);

  /// Background color for scaffold
  static const Color scaffoldBackground = Colors.white;

  // Private constructor to prevent instantiation
  const AppColors._();
}
