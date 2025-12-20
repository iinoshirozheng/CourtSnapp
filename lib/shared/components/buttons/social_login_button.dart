import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A button for social media login options
class SocialLoginButton extends StatelessWidget {
  /// The icon to display for the social platform
  final Widget icon;

  /// Optional text to display alongside the icon
  final String? text;

  /// Background color for the button
  final Color bgColor;

  /// Text color for the button
  final Color textColor;

  /// Border color for the button
  final Color borderColor;

  /// Button height
  final double height;

  /// Border radius for the button
  final double borderRadius;

  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Whether to show a loading indicator instead of content
  final bool isLoading;

  /// Constructor
  const SocialLoginButton({
    super.key,
    required this.icon,
    this.text,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
    this.height = 48.0,
    this.borderRadius = 16.0,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Ink(
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child:
                isLoading
                    ? Center(
                      child: SizedBox(
                        height: height * 0.5,
                        width: height * 0.5,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(textColor),
                        ),
                      ),
                    )
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon,
                        if (text != null) ...[
                          const SizedBox(width: 12),
                          Text(
                            text!,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}
