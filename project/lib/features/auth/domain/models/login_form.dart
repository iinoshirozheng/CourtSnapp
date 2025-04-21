import 'package:formz/formz.dart';
import 'email.dart';
import 'password.dart';

class LoginForm {
  const LoginForm({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;

  bool get isValid => email.isValid && password.isValid;

  LoginForm copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
  }) {
    return LoginForm(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
