import 'package:flutter/material.dart';
import 'package:project/shared/components/indicators/error_message.dart';

/// A specialized error message component for authentication screens
class AuthErrorMessage extends StatelessWidget {
  /// The error message to display
  final String? errorMessage;

  /// Constructor
  const AuthErrorMessage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null || errorMessage!.isEmpty) {
      return const SizedBox.shrink();
    }

    return ErrorMessage(message: errorMessage!);
  }
}
