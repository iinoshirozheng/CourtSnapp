import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? width;
  final Color textColor;
  final TextStyle? textStyle;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.textColor = const Color(0xFF007F3B), // Default to brand color
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: isLoading ? null : onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child:
            isLoading
                ? const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
                : Text(
                  text,
                  textAlign: TextAlign.center,
                  style:
                      textStyle ??
                      TextStyle(
                        color: textColor,
                        fontSize: screenHeight * 0.017,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.25,
                      ),
                ),
      ),
    );
  }
}
