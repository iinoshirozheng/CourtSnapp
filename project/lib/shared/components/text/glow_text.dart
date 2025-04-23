import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A professionally designed flowing glow text component, especially suitable for dark mode
class GlowText extends StatefulWidget {
  const GlowText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.strutStyle,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.glowColor,
    this.glowRadius = 5.0,
    this.glowIntensity = 0.6,
    this.animationDuration = const Duration(seconds: 10),
    this.gradientColors,
  });

  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final Color? glowColor;
  final double glowRadius;
  final double glowIntensity;
  final Duration animationDuration;
  final List<Color>? gradientColors;

  @override
  State<GlowText> createState() => _GlowTextState();
}

class _GlowTextState extends State<GlowText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // Tennis court-inspired color system
  static const List<Color> courtColors = [
    Color(0xFFF9BBCB), // Pink (border)
    Color(0xFFB8E0B9), // Light green (court)
    Color(0xFF8AD28B), // Green (court)
    Color(0xFF77CEF9), // Light blue (net area)
    Color(0xFF5BBAED), // Blue (net area)
    Color(0xFFF9BBCB), // Pink (border) - repeating for gradient flow
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Use regular text in light mode
    if (!isDarkMode) {
      return Text(
        widget.text,
        style: widget.style,
        textAlign: widget.textAlign,
        strutStyle: widget.strutStyle,
        textDirection: widget.textDirection,
        locale: widget.locale,
        softWrap: widget.softWrap,
        overflow: widget.overflow,
        textScaler: widget.textScaler,
        maxLines: widget.maxLines,
        semanticsLabel: widget.semanticsLabel,
      );
    }

    // Use glowing text in dark mode
    final textStyle = widget.style ?? Theme.of(context).textTheme.bodyLarge!;
    final colors = widget.gradientColors ?? courtColors;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: colors,
              transform: GradientRotation(
                2 * math.pi * _animationController.value,
              ),
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: textStyle.copyWith(
              shadows: [
                Shadow(
                  color:
                      widget.glowColor ??
                      colors.first.withValues(alpha: widget.glowIntensity),
                  blurRadius: widget.glowRadius,
                ),
                Shadow(
                  color:
                      widget.glowColor ??
                      colors.last.withValues(alpha: widget.glowIntensity),
                  blurRadius: widget.glowRadius,
                ),
              ],
            ),
            textAlign: widget.textAlign,
            strutStyle: widget.strutStyle,
            textDirection: widget.textDirection,
            locale: widget.locale,
            softWrap: widget.softWrap,
            overflow: widget.overflow,
            textScaler: widget.textScaler,
            maxLines: widget.maxLines,
            semanticsLabel: widget.semanticsLabel,
          ),
        );
      },
    );
  }
}

// Extension method for color manipulation
extension ColorExtension on Color {
  Color withValues({double? red, double? green, double? blue, double? alpha}) {
    return Color.fromARGB(
      (alpha != null ? alpha * 255 : this.alpha).round(),
      (red != null ? red * 255 : this.red).round(),
      (green != null ? green * 255 : this.green).round(),
      (blue != null ? blue * 255 : this.blue).round(),
    );
  }
}
