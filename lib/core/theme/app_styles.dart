import 'package:flutter/material.dart';

class AppStyles {
  // Brand Colors
  static const Color brandPrimary = Color(0xFF007F3B); // Grass Green
  static const Color brandSecondary = Color(0xFFFFFFFF); // Court Line White
  static const Color brandAccent = Color(0xFFFFD600); // Tennis Ball Yellow
  static const Color brandNeutral = Color(0xFF666666); // Net Gray

  // Text Colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF555555);
  static const Color textHint = Color(0xFF888888);

  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Shadow
  static BoxShadow primaryShadow = BoxShadow(
    color: brandPrimary.withValues(alpha: 0.3),
    blurRadius: 8,
    offset: const Offset(0, 3),
  );

  // Border Radius
  static final BorderRadius smallRadius = BorderRadius.circular(8);
  static final BorderRadius mediumRadius = BorderRadius.circular(12);
  static final BorderRadius largeRadius = BorderRadius.circular(16);
  static final BorderRadius roundedRadius = BorderRadius.circular(24);

  const AppStyles._();
}
