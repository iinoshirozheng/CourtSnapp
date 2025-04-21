import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import '../../domain/models/email.dart';
import '../../domain/models/password.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage];

  // Helper getters for UI validation
  bool get isEmailValid => email.isValid;
  bool get isPasswordValid => password.isValid;
  bool get isFormValid => isEmailValid && isPasswordValid;
  bool get isSubmitting => status == FormzSubmissionStatus.inProgress;
  bool get hasSubmitted => status == FormzSubmissionStatus.success;
  bool get hasError => status == FormzSubmissionStatus.failure;

  // Password validation helpers
  bool get hasUppercase => password.hasUppercase;
  bool get hasLetter => password.hasLetter;
  bool get hasNumber => password.hasNumber;
  bool get hasMinLength => password.hasMinLength;
}
