import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:project/core/error/failures.dart';
import 'package:project/features/auth/domain/entities/user_entity.dart';
import 'package:project/features/auth/domain/usecases/sign_in_with_email_password_usecase.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailPasswordUseCase signInWithEmailPassword;

  AuthBloc({required this.signInWithEmailPassword}) : super(AuthInitial()) {
    on<SignInWithEmailPasswordEvent>(_onSignInWithEmailPassword);
    on<SignOutEvent>(_onSignOut);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
  }

  Future<void> _onSignInWithEmailPassword(
    SignInWithEmailPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final params = SignInParams(email: event.email, password: event.password);

    final result = await signInWithEmailPassword(params);

    emit(
      result.fold(
        (failure) => AuthError(message: _mapFailureToMessage(failure)),
        (user) => AuthAuthenticated(user),
      ),
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    // TODO: implement sign out
    emit(AuthUnauthenticated());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    // TODO: implement check auth status
    emit(AuthUnauthenticated());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case InvalidCredentialsFailure _:
        return 'Invalid email or password';
      case NetworkFailure _:
        return 'Network error. Please check your connection';
      case ServerFailure _:
        return 'Server error. Please try again later';
      default:
        return 'An unexpected error occurred';
    }
  }
}
