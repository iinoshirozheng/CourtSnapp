import 'package:flutter/material.dart';

/// Utility extensions for Color class
extension ColorExtension on Color {
  /// Create a new color with any of its values modified
  ///
  /// @param red The new red value (0-255)
  /// @param green The new green value (0-255)
  /// @param blue The new blue value (0-255)
  /// @param alpha The new alpha value (0.0-1.0)
  /// @return A new Color with the specified values changed
  Color withValues({int? red, int? green, int? blue, double? alpha}) {
    int clampChannel(double value) =>
        (value * 255).round().clamp(0, 255).toInt();

    return Color.fromRGBO(
      red ?? clampChannel(r),
      green ?? clampChannel(g),
      blue ?? clampChannel(b),
      alpha ?? a,
    );
  }
}
