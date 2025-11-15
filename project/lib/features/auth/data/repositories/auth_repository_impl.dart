import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:project/core/error/failures.dart';
import 'package:project/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:project/features/auth/domain/entities/user_entity.dart';
import 'package:project/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    } on AuthException catch (e) {
      if (e.message.toLowerCase().contains('invalid login credentials')) {
        return const Left(InvalidCredentialsFailure());
      }
      return Left(AuthFailure(message: e.message));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final isSignedIn = await remoteDataSource.isSignedIn();
      return Right(isSignedIn);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final currentUser = await remoteDataSource.getCurrentUser();
      return Right(currentUser);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } catch (_) {
      return const Left(ServerFailure());
    }
  }
}
