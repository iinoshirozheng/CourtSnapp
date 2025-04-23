import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A primary button component for the application
///
/// Supports solid background or gradient text
/// Provides loading state indication
class PrimaryButton extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// The callback to execute when the button is pressed
  final VoidCallback? onPressed;

  /// Whether the button is currently in a loading state
  final bool isLoading;

  /// The width of the button (optional, defaults to full width)
  final double? width;

  /// The height of the button (optional, defaults to 56)
  final double height;

  /// The icon to display before the text (optional)
  final IconData? icon;

  /// The color of the button (optional, defaults to primary green)
  final Color? color;

  /// The text color of the button (optional, defaults to white)
  final Color textColor;

  /// The border radius of the button (optional, defaults to 16)
  final double borderRadius;

  /// Optional gradient to apply to text
  final Gradient? gradient;

  /// Font size for the button text
  final double? fontSize;

  /// Creates a primary button
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 56,
    this.icon,
    this.color,
    this.textColor = Colors.white,
    this.borderRadius = 16,
    this.gradient,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = color ?? const Color(0xFF007F3B);
    final disabledColor = Colors.grey.shade300;

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: onPressed == null ? disabledColor : primaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: 4,
        shadowColor: Colors.black.withAlpha(100),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child:
                  isLoading
                      ? SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(textColor),
                        ),
                      )
                      : _buildButtonContent(),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the button content based on settings
  Widget _buildButtonContent() {
    if (gradient != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 8),
          ],
          ShaderMask(
            shaderCallback: (bounds) => gradient!.createShader(bounds),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: fontSize ?? 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
