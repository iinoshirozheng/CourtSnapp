import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
  final String email;
  final bool isEmailValid;
  final String password;
  final bool hasUppercase;
  final bool hasLetter;
  final bool hasNumber;
  final bool hasMinLength;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool showPasswordHints;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  const LoginState({
    this.email = '',
    this.isEmailValid = false,
    this.password = '',
    this.hasUppercase = false,
    this.hasLetter = false,
    this.hasNumber = false,
    this.hasMinLength = false,
    this.isPasswordValid = false,
    this.isSubmitting = false,
    this.showPasswordHints = false,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  bool get isFormValid => isEmailValid && isPasswordValid && !isSubmitting;

  LoginState copyWith({
    String? email,
    bool? isEmailValid,
    String? password,
    bool? hasUppercase,
    bool? hasLetter,
    bool? hasNumber,
    bool? hasMinLength,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? showPasswordHints,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      password: password ?? this.password,
      hasUppercase: hasUppercase ?? this.hasUppercase,
      hasLetter: hasLetter ?? this.hasLetter,
      hasNumber: hasNumber ?? this.hasNumber,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showPasswordHints: showPasswordHints ?? this.showPasswordHints,
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    email,
    isEmailValid,
    password,
    hasUppercase,
    hasLetter,
    hasNumber,
    hasMinLength,
    isPasswordValid,
    isSubmitting,
    showPasswordHints,
    status,
    errorMessage,
  ];
}
