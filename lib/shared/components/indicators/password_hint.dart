import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A visual indicator for password requirements
class PasswordHint extends StatelessWidget {
  /// The text to display for this requirement
  final String text;

  /// Whether this requirement has been met
  final bool isValid;

  /// The font size for the text
  final double fontSize;

  /// Constructor
  const PasswordHint({
    super.key,
    required this.text,
    required this.isValid,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.symmetric(
        horizontal: fontSize * 0.7,
        vertical: fontSize * 0.4,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isValid ? Colors.green[50] : Colors.grey[200],
        borderRadius: BorderRadius.circular(fontSize * 1.8),
        border: Border.all(
          color: isValid ? Colors.green[400]! : Colors.transparent,
          width: 1,
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: isValid ? FontWeight.w500 : FontWeight.w400,
          color: isValid ? Colors.green[700] : Colors.grey[700],
          height: 1.1,
        ),
      ),
    );
  }
}
