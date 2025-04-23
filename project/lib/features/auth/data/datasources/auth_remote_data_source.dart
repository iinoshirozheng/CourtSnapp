import 'package:injectable/injectable.dart';
import 'package:project/features/auth/data/models/user_model.dart';

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
  // TODO: Add Firebase Auth dependency
  // final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: Implement with Firebase Auth
      // final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      //
      // return UserModel.fromFirebaseUser(userCredential.user!);

      // Mock implementation
      await Future.delayed(const Duration(seconds: 2));

      // Simulate login validation
      if (email == 'test@example.com' && password == 'Password123') {
        return UserModel(
          id: 'user-id-123',
          email: email,
          displayName: 'Test User',
        );
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      throw Exception('Authentication failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // TODO: Implement with Firebase Auth
      // await firebaseAuth.signOut();
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> isSignedIn() async {
    try {
      // TODO: Implement with Firebase Auth
      // return firebaseAuth.currentUser != null;
      return false;
    } catch (e) {
      throw Exception('Error checking auth state: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      // TODO: Implement with Firebase Auth
      // final user = firebaseAuth.currentUser;
      // if (user != null) {
      //   return UserModel.fromFirebaseUser(user);
      // }
      return null;
    } catch (e) {
      throw Exception('Error getting current user: ${e.toString()}');
    }
  }
}
