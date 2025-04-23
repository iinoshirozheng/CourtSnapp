import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A customized text field with focus effects, error handling, and more
class CustomTextField extends StatelessWidget {
  /// The controller for the text field
  final TextEditingController controller;

  /// The focus node for the text field
  final FocusNode focusNode;

  /// The placeholder text to display when the field is empty
  final String hintText;

  /// The icon to display at the beginning of the text field
  final IconData prefixIcon;

  /// The background color of the text field
  final Color inputBgColor;

  /// The border color when the field is not focused
  final Color inputBorderColor;

  /// The border color when the field is focused
  final Color inputFocusBorderColor;

  /// The brand color used for focus effects
  final Color brandColor;

  /// The color to use for error states
  final Color errorColor;

  /// Whether to obscure the text (for passwords)
  final bool obscureText;

  /// Whether the input is valid
  final bool isValid;

  /// Whether the field is currently focused
  final bool isFocused;

  /// Whether to show error state
  final bool showError;

  /// The error message to display when showError is true
  final String? errorText;

  /// Widget to display at the end of the text field
  final Widget? suffixIcon;

  /// The keyboard type for the field
  final TextInputType keyboardType;

  /// The action to perform when the submit button is pressed
  final TextInputAction textInputAction;

  /// Callback when the text field is submitted
  final Function(String)? onSubmitted;

  /// Constructor
  const CustomTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.prefixIcon,
    required this.inputBgColor,
    required this.inputBorderColor,
    required this.inputFocusBorderColor,
    required this.brandColor,
    required this.errorColor,
    this.obscureText = false,
    this.isValid = true,
    this.isFocused = false,
    this.showError = false,
    this.errorText,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: inputBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  showError
                      ? errorColor
                      : isFocused
                      ? inputFocusBorderColor
                      : inputBorderColor,
              width: isFocused || showError ? 1.5 : 1.0,
            ),
            boxShadow:
                isFocused
                    ? [
                      BoxShadow(
                        color: (showError ? errorColor : brandColor).withValues(
                          alpha: 0.1,
                        ),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
            cursorColor: showError ? errorColor : brandColor,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 14,
              ),
              prefixIcon: Icon(
                prefixIcon,
                size: 18,
                color:
                    showError
                        ? errorColor
                        : isFocused
                        ? brandColor
                        : Colors.grey[400],
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
        if (showError && errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 12),
            child: Text(
              errorText!,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: errorColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
      ],
    );
  }
}
