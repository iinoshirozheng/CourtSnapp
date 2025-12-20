import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A standardized label component for form fields
class FormLabel extends StatelessWidget {
  /// The text to display as the label
  final String text;

  /// The text color (defaults to black87)
  final Color color;

  /// The font size (defaults to 14)
  final double fontSize;

  /// The font weight (defaults to medium - 500)
  final FontWeight fontWeight;

  /// Constructor
  const FormLabel({
    super.key,
    required this.text,
    this.color = Colors.black87,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
