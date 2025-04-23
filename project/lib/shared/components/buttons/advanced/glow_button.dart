import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A professionally designed button with slide animation, glow effect, and
/// tactile feedback following UI/UX best practices
class GlowButton extends StatefulWidget {
  const GlowButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = 220.0,
    this.height = 56.0, // Increased for better tap target
    this.borderRadius = 16.0, // Standardized border radius
    this.backgroundColor = const Color(0xFF111111),
    this.textColor = Colors.white,
    this.animationDuration = const Duration(seconds: 20),
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.fontSize,
    this.variant = ButtonVariant.primary,
  });

  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final Duration animationDuration;
  final Duration fadeInDuration;
  final double? fontSize;
  final ButtonVariant variant;

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

/// Different button style variants
enum ButtonVariant { primary, secondary, text }

class _GlowButtonState extends State<GlowButton> with TickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _glowAnimationController;
  late AnimationController _slideAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _glowAnimationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();

    // Slide animation controller
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Scale animation for tactile feedback
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _glowAnimationController.dispose();
    _slideAnimationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  // Court-inspired color system
  static const List<Color> courtColors = [
    Color(0xFFF9BBCB), // Pink (border)
    Color(0xFFB8E0B9), // Light green (court)
    Color(0xFF8AD28B), // Green (court)
    Color(0xFF77CEF9), // Light blue (net area)
    Color(0xFF5BBAED), // Blue (net area)
    Color(0xFFF9BBCB), // Pink (border) - repeating for gradient flow
  ];

  @override
  Widget build(BuildContext context) {
    // Check if in dark mode
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() => _isHovered = true);
        _slideAnimationController.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _slideAnimationController.reverse();
      },
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
          _scaleAnimationController.forward();
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _scaleAnimationController.reverse();
          widget.onPressed();
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
          _scaleAnimationController.reverse();
        },
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _glowAnimationController,
            _slideAnimationController,
            _scaleAnimationController,
          ]),
          builder: (context, child) {
            return ScaleTransition(
              scale: _scaleAnimation,
              child: SizedBox(
                width: widget.width,
                height: widget.height,
                child: Stack(
                  children: [
                    // Shadow layer
                    if (!_isPressed)
                      Positioned.fill(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(
                                  51,
                                ), // 0.2 opacity
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                        ),
                      ),

                    // Button content (base layer)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.backgroundColor,
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Slide right overlay
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                widget.borderRadius,
                              ),
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(-1, 0),
                                  end: Offset(0, 0),
                                ).animate(_slideAnimation),
                                child: Container(
                                  width: widget.width,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: courtColors,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      widget.borderRadius,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Glow layer
                            AnimatedOpacity(
                              opacity: _isHovered || _isPressed ? 1.0 : 0.0,
                              duration: widget.fadeInDuration,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    widget.borderRadius,
                                  ),
                                  boxShadow: _buildGlowWithAnimation(),
                                ),
                              ),
                            ),

                            // Text layer
                            Center(
                              child: Text(
                                widget.text,
                                style: TextStyle(
                                  color: widget.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: widget.fontSize ?? 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<BoxShadow> _buildGlowWithAnimation() {
    final animValue = _glowAnimationController.value;
    final hoverIntensity = _isHovered || _isPressed ? 1.0 : 0.5;

    return courtColors.asMap().entries.map((entry) {
      final idx = entry.key;
      final color = entry.value;
      final offset =
          (idx + animValue * courtColors.length) % courtColors.length;
      final pulseValue = (math.sin(offset * math.pi) + 1) / 2;
      final maxSpread = 15.0 * hoverIntensity;
      final spread = maxSpread * pulseValue;

      return BoxShadow(
        color: color.withOpacity(0.3 * hoverIntensity),
        blurRadius: 25.0 * hoverIntensity,
        spreadRadius: spread,
      );
    }).toList();
  }
}

// Extension method for color manipulation
extension ColorWithValues on Color {
  Color withValues({double? red, double? green, double? blue, double? alpha}) {
    return Color.fromARGB(
      (alpha != null ? alpha * 255 : this.alpha).round(),
      (red != null ? red * 255 : this.red).round(),
      (green != null ? green * 255 : this.green).round(),
      (blue != null ? blue * 255 : this.blue).round(),
    );
  }
}
