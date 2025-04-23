import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:project/core/error/failures.dart';
import 'package:project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:project/features/auth/domain/entities/user_entity.dart';
import 'package:project/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userModel);
    } catch (e) {
      if (e.toString().contains('Invalid credentials')) {
        return Left(InvalidCredentialsFailure());
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final isSignedIn = await remoteDataSource.isSignedIn();
      return Right(isSignedIn);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final currentUser = await remoteDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
