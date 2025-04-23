import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  const LoginEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class LoginPasswordVisibilityChanged extends LoginEvent {
  final bool isVisible;

  const LoginPasswordVisibilityChanged(this.isVisible);

  @override
  List<Object> get props => [isVisible];
}

class LoginWithCredentialsPressed extends LoginEvent {
  const LoginWithCredentialsPressed();
}

class LoginWithGooglePressed extends LoginEvent {
  const LoginWithGooglePressed();
}

class LoginWithFacebookPressed extends LoginEvent {
  const LoginWithFacebookPressed();
}

class LoginWithApplePressed extends LoginEvent {
  const LoginWithApplePressed();
}
