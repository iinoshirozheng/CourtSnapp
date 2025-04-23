import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A specialized text field for authentication forms with styling and
/// behavior optimized for login, registration and password management screens.
///
/// This component is designed specifically for auth screens with appropriate
/// styling, password visibility toggle, and error handling.
class AuthTextField extends StatelessWidget {
  /// The controller for the text field
  final TextEditingController controller;

  /// The hint text to display when the field is empty
  final String hintText;

  /// The validation error text to display, if any
  final String? errorText;

  /// Whether this is a password field with toggleable visibility
  final bool isPassword;

  /// The keyboard type for the field
  final TextInputType keyboardType;

  /// The text input action (what shows on keyboard's action button)
  final TextInputAction textInputAction;

  /// Callback when field changes
  final Function(String)? onChanged;

  /// Callback when user submits the field
  final Function(String)? onSubmitted;

  /// The prefix icon to display
  final IconData? prefixIcon;

  /// The suffix icon to display
  final Widget? suffixIcon;

  /// Focus node for this text field
  final FocusNode? focusNode;

  /// Whether the field is currently showing an obscured password
  final bool obscureText;

  /// Callback to toggle password visibility when isPassword is true
  final VoidCallback? onTogglePasswordVisibility;

  /// Constructor for the auth text field
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.errorText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.obscureText = false,
    this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          cursorColor: const Color(0xFF007F3B),
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
            errorText: errorText,
            errorStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
            prefixIcon:
                prefixIcon != null
                    ? Icon(prefixIcon, color: const Color(0xFF007F3B), size: 20)
                    : null,
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onPressed: onTogglePasswordVisibility,
                    )
                    : suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey.shade300,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : const Color(0xFF007F3B),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        if (errorText != null) const SizedBox(height: 4),
      ],
    );
  }
}
