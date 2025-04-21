import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import '../../domain/models/email.dart';
import '../../domain/models/password.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginWithGoogleSubmitted>(_onLoginWithGoogleSubmitted);
    on<LoginWithFacebookSubmitted>(_onLoginWithFacebookSubmitted);
    on<LoginWithAppleSubmitted>(_onLoginWithAppleSubmitted);
    on<ResetLoginStatus>(_onResetLoginStatus);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isFormValid) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'Please fill in all fields correctly',
        ),
      );
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      // TODO: Implement actual authentication logic here

      // For now, we'll just simulate a delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful login
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoginWithGoogleSubmitted(
    LoginWithGoogleSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      // TODO: Implement Google authentication logic
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoginWithFacebookSubmitted(
    LoginWithFacebookSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      // TODO: Implement Facebook authentication logic
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoginWithAppleSubmitted(
    LoginWithAppleSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      // TODO: Implement Apple authentication logic
      await Future.delayed(const Duration(seconds: 2));
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onResetLoginStatus(ResetLoginStatus event, Emitter<LoginState> emit) {
    emit(
      state.copyWith(status: FormzSubmissionStatus.initial, errorMessage: null),
    );
  }
}
