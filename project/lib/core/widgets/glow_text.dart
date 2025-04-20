import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 專業設計的流動發光文字組件，特別適合深色模式
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

  // 網球場靈感的顏色系統
  static const List<Color> courtColors = [
    Color(0xFFF9BBCB), // 粉紅色（邊界）
    Color(0xFFB8E0B9), // 淺綠色（球場）
    Color(0xFF8AD28B), // 綠色（球場）
    Color(0xFF77CEF9), // 淺藍色（網區）
    Color(0xFF5BBAED), // 藍色（網區）
    Color(0xFFF9BBCB), // 粉紅色（邊界）- 重複以實現流動效果
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

    // 如果不是深色模式，使用普通文字
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

    // 深色模式使用發光文字
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
