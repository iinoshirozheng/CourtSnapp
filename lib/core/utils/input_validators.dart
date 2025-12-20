import 'package:email_validator/email_validator.dart';

/// A utility class for validating form inputs
class InputValidator {
  /// Private constructor to prevent instantiation
  InputValidator._();

  /// Validates an email address
  ///
  /// Returns null if valid, error message if invalid
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    if (!EmailValidator.validate(value)) {
      return 'Please enter a valid email';
    }

    return null;
  }

  /// Validates a password
  ///
  /// Returns null if valid, error message if invalid
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  /// Validates a name field
  ///
  /// Returns null if valid, error message if invalid
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }

    return null;
  }

  /// Validates a phone number
  ///
  /// Returns null if valid, error message if invalid
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // Basic regex for phone number validation
    // Matches formats like: (123) 456-7890, 123-456-7890, 1234567890
    final phoneRegExp = RegExp(r'^\(?[\d]{3}\)?[- ]?[\d]{3}[- ]?[\d]{4}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Validates a required field
  ///
  /// Returns null if valid, error message if invalid
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Field'} is required';
    }

    return null;
  }
}
