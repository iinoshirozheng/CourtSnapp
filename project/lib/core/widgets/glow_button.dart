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
    // 檢查當前是否為深色模式
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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

                            // Center text
                            Center(
                              child: Text(
                                widget.text,
                                style: TextStyle(
                                  color: widget.textColor,
                                  fontWeight:
                                      FontWeight
                                          .w600, // Semi-bold for better readability
                                  fontSize: widget.fontSize ?? 16,
                                  letterSpacing: 0.5, // Improved letter spacing
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Glow border layer (深色模式始終顯示，淺色模式僅在懸停時顯示)
                    if (isDarkMode || _isHovered)
                      CustomPaint(
                        size: Size(widget.width, widget.height),
                        painter: CourtGlowBorderPainter(
                          _glowAnimationController.value,
                          borderRadius: widget.borderRadius,
                          opacity: 1.0,
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
}

/// CustomPainter that renders a flowing court-colored gradient border with glow effect
class CourtGlowBorderPainter extends CustomPainter {
  final double progress;
  final double borderRadius;
  final double opacity;

  CourtGlowBorderPainter(
    this.progress, {
    this.borderRadius = 10.0,
    this.opacity = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // Court colors gradient (pink, green, blue)
    final gradient = SweepGradient(
      startAngle: 0.0,
      endAngle: math.pi * 2,
      colors: const [
        Color(0xFFF9BBCB), // Pink (border)
        Color(0xFFB8E0B9), // Light green (court)
        Color(0xFF8AD28B), // Green (court)
        Color(0xFF77CEF9), // Light blue (net area)
        Color(0xFF5BBAED), // Blue (net area)
        Color(0xFFF9BBCB), // Pink (border)
      ],
      transform: GradientRotation(2 * math.pi * progress),
    ).createShader(rect);

    // Outer glow layer (blurred)
    final glowPaint =
        Paint()
          ..shader = gradient
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7.0)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4.0;

    // Inner sharp layer
    final sharpPaint =
        Paint()
          ..shader = gradient
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

    // Draw the blurred background glow
    canvas.drawRRect(rrect, glowPaint);

    // Draw the sharp inner border
    canvas.drawRRect(rrect, sharpPaint);
  }

  @override
  bool shouldRepaint(CourtGlowBorderPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.opacity != opacity;
  }
}
