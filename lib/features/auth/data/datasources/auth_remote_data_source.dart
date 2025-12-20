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

  /// Signs in user or registers them if account doesn't exist
  Future<UserModel> signInOrSignUp({
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
  Future<UserModel> signInOrSignUp({
    required String email,
    required String password,
  }) async {
    try {
      // Try to sign up first
      final signUpResponse = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      final user = signUpResponse.user;
      if (user != null) {
        return UserModel.fromSupabaseUser(user);
      }

      // If sign up success but no user (e.g. email confirmation required scenario), 
      // check if we can just sign in or if it's a specific flow.
      // But for this simplified flow, we assume if signUp succeeds we get a user.
      throw AuthException('Sign up was successful but user data is missing.');

    } on AuthException catch (e) {
      // If user already exists, try signing in
      if (e.message.toLowerCase().contains('already registered') ||
          e.message.toLowerCase().contains('user already exists')) {
        return signInWithEmailAndPassword(email: email, password: password);
      }
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
  Future<UserModel> signInOrSignUp({
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
    // Simulate creating a new user for other credentials
    return UserModel(
      id: 'new-user-${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: 'New User',
    );
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
