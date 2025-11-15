import 'package:injectable/injectable.dart';
import 'package:project/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  /// Signs in user with email and password
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Signs out the current user
  ///
  /// Throws a [ServerException] for all error codes
  Future<void> signOut();

  /// Checks if user is currently signed in
  ///
  /// Throws a [ServerException] for all error codes
  Future<bool> isSignedIn();

  /// Gets the current user if signed in
  ///
  /// Throws a [ServerException] for all error codes
  Future<UserModel?> getCurrentUser();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AuthRemoteDataSourceImpl(this._supabaseClient);

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw AuthException('User not found after sign in');
      }
      return UserModel.fromSupabaseUser(user);
    } on AuthException {
      rethrow;
    } catch (e) {
      throw Exception('Authentication failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } on AuthException {
      rethrow;
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      return _supabaseClient.auth.currentSession != null;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw Exception('Error checking auth state: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      if (user != null) {
        return UserModel.fromSupabaseUser(user);
      }
      return null;
    } on AuthException {
      rethrow;
    } catch (e) {
      throw Exception('Error getting current user: ${e.toString()}');
    }
  }
}

/// Lightweight mock implementation used when Supabase config is absent.
class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@example.com' && password == 'Password123') {
      return UserModel(
        id: 'user-id-123',
        email: email,
        displayName: 'Test User',
      );
    }
    throw AuthException('Invalid login credentials');
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<bool> isSignedIn() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return false;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return null;
  }
}
