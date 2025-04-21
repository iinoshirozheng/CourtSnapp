import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginWithGoogleSubmitted extends LoginEvent {
  const LoginWithGoogleSubmitted();
}

class LoginWithFacebookSubmitted extends LoginEvent {
  const LoginWithFacebookSubmitted();
}

class LoginWithAppleSubmitted extends LoginEvent {
  const LoginWithAppleSubmitted();
}

class ResetLoginStatus extends LoginEvent {
  const ResetLoginStatus();
}
