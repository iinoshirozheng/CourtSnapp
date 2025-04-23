import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/constants/app_colors.dart';
import 'package:project/core/constants/spacing_constants.dart';

/// A reusable error message component
class ErrorMessage extends StatelessWidget {
  /// The error message to display
  final String message;

  /// Optional custom text style
  final TextStyle? style;

  /// Optional custom padding
  final EdgeInsetsGeometry? padding;

  /// Optional text alignment
  final TextAlign textAlign;

  /// Optional color for the error text
  final Color? color;

  /// Constructor
  const ErrorMessage({
    super.key,
    required this.message,
    this.style,
    this.padding,
    this.textAlign = TextAlign.center,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final errorColor = color ?? AppColors.errorColor;

    return Padding(
      padding: padding ?? const EdgeInsets.only(top: SpacingConstants.spacing3),
      child: Text(
        message,
        textAlign: textAlign,
        style:
            style ??
            GoogleFonts.poppins(
              fontSize: 12,
              color: errorColor,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
