import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object> get props => [message];
}

// Auth specific failures
class AuthFailure extends Failure {
  const AuthFailure({super.message});
}

class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure()
    : super(message: 'Invalid email or password');
}

class NetworkFailure extends Failure {
  const NetworkFailure()
    : super(message: 'Network error. Please check your connection');
}

class ServerFailure extends Failure {
  const ServerFailure()
    : super(message: 'Server error. Please try again later');
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super(message: 'An unknown error occurred');
}
