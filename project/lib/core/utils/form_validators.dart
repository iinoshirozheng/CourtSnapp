/// Utility class containing methods for form validation
class FormValidators {
  /// Validates an email address according to standard email format
  ///
  /// @param email The email address to validate
  /// @return true if the email is valid, false otherwise
  static bool validateEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validates a password based on common security requirements
  ///
  /// @param password The password to validate
  /// @return A PasswordValidationResult object containing the validation results
  static PasswordValidationResult validatePassword(String password) {
    final bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    final bool hasNumber = password.contains(RegExp(r'[0-9]'));
    final bool hasMinLength = password.length >= 8 && password.length <= 20;

    return PasswordValidationResult(
      hasUppercase: hasUppercase,
      hasLetter: hasLetter,
      hasNumber: hasNumber,
      hasMinLength: hasMinLength,
    );
  }

  // Private constructor to prevent instantiation
  const FormValidators._();
}

/// Data class representing the result of password validation
class PasswordValidationResult {
  /// Whether the password contains an uppercase letter
  final bool hasUppercase;

  /// Whether the password contains a letter (upper or lowercase)
  final bool hasLetter;

  /// Whether the password contains a number
  final bool hasNumber;

  /// Whether the password meets length requirements (typically 8-20 characters)
  final bool hasMinLength;

  /// Constructor
  const PasswordValidationResult({
    required this.hasUppercase,
    required this.hasLetter,
    required this.hasNumber,
    required this.hasMinLength,
  });

  /// Whether the password is valid (meets all requirements)
  bool get isValid => hasUppercase && hasLetter && hasNumber && hasMinLength;
}
