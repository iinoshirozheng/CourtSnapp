import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  // Simple password validation
  static final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[0-9]).{8,20}$');

  @override
  PasswordValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return PasswordValidationError.empty;
    }
    return passwordRegExp.hasMatch(value!)
        ? null
        : PasswordValidationError.invalid;
  }

  // Helper methods to check specific requirements
  bool get hasUppercase => value.contains(RegExp(r'[A-Z]'));
  bool get hasLetter => value.contains(RegExp(r'[a-zA-Z]'));
  bool get hasNumber => value.contains(RegExp(r'[0-9]'));
  bool get hasMinLength => value.length >= 8 && value.length <= 20;
}
