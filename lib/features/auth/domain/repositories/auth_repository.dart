import 'package:dartz/dartz.dart';
import 'package:project/core/error/failures.dart';
import 'package:project/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Signs in user with email and password
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs out the current user
  Future<Either<Failure, void>> signOut();

  /// Checks if user is currently signed in
  Future<Either<Failure, bool>> isSignedIn();

  /// Gets the current user if signed in
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
