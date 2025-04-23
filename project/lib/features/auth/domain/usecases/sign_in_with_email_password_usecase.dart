import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:project/core/error/failures.dart';
import 'package:project/core/usecases/usecase.dart';
import 'package:project/features/auth/domain/entities/user_entity.dart';
import 'package:project/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignInWithEmailPasswordUseCase
    implements UseCase<UserEntity, SignInParams> {
  final AuthRepository repository;

  SignInWithEmailPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return repository.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
