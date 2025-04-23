/// Spacing constants using 8pt grid system
class SpacingConstants {
  /// Base grid unit - 8pt
  static const double grid = 8.0;

  /// Spacing 2 - 8pt (1x grid)
  static const double spacing2 = grid * 1;

  /// Spacing 3 - 12pt (1.5x grid)
  static const double spacing3 = grid * 1.5;

  /// Spacing 4 - 16pt (2x grid)
  static const double spacing4 = grid * 2;

  /// Spacing 5 - 24pt (3x grid)
  static const double spacing5 = grid * 3;

  /// Spacing 6 - 32pt (4x grid)
  static const double spacing6 = grid * 4;

  /// Spacing 7 - 48pt (6x grid)
  static const double spacing7 = grid * 6;

  /// Standard button height - 48pt (6x grid)
  static const double buttonHeight = grid * 6;

  /// Standard horizontal margin - 24pt (3x grid)
  static const double horizontalMargin = grid * 3;

  // Private constructor to prevent instantiation
  const SpacingConstants._();
}
