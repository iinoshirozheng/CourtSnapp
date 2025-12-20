import 'package:flutter/material.dart';
import 'package:project/core/constants/app_colors.dart';

/// A reusable dialog for displaying authentication errors
class AuthErrorDialog extends StatelessWidget {
  /// The error title
  final String title;

  /// The error message to display
  final String message;

  /// Action buttons to display at the bottom of the dialog
  final List<Widget>? actions;

  /// Optional text color for the error message
  final Color? textColor;

  /// Constructor
  const AuthErrorDialog({
    super.key,
    this.title = 'Login Error',
    required this.message,
    this.actions,
    this.textColor,
  });

  /// Helper method to show the dialog
  static Future<T?> show<T>({
    required BuildContext context,
    String title = 'Login Error',
    required String message,
    List<Widget>? actions,
    Color? textColor,
  }) {
    return showDialog<T>(
      context: context,
      builder:
          (context) => AuthErrorDialog(
            title: title,
            message: message,
            actions: actions,
            textColor: textColor,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final errorColor = textColor ?? AppColors.errorColor;

    return AlertDialog(
      title: Text(title),
      content: SelectableText.rich(
        TextSpan(text: message, style: TextStyle(color: errorColor)),
      ),
      actions:
          actions ??
          [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
    );
  }
}
