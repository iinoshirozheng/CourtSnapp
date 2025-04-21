import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  // Very simple email validation
  static final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  EmailValidationError? validator(String? value) {
    if (value?.isEmpty ?? true) {
      return EmailValidationError.empty;
    }
    return emailRegExp.hasMatch(value!) ? null : EmailValidationError.invalid;
  }
}
