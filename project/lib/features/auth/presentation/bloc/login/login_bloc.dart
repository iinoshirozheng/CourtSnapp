import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:project/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

/// A BLoC that manages the login form and validation state
/// This is separate from AuthBloc which handles the actual authentication
@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;

  LoginBloc({required AuthBloc authBloc})
    : _authBloc = authBloc,
      super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPasswordVisibilityChanged>(_onPasswordVisibilityChanged);
    on<LoginWithCredentialsPressed>(_onLoginWithCredentialsPressed);
    on<LoginWithGooglePressed>(_onLoginWithGooglePressed);
    on<LoginWithFacebookPressed>(_onLoginWithFacebookPressed);
    on<LoginWithApplePressed>(_onLoginWithApplePressed);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = event.email;
    final isEmailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);

    emit(
      state.copyWith(
        email: email,
        isEmailValid: isEmailValid,
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = event.password;

    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasMinLength = password.length >= 8 && password.length <= 20;
    final isPasswordValid =
        hasUppercase && hasLetter && hasNumber && hasMinLength;

    emit(
      state.copyWith(
        password: password,
        hasUppercase: hasUppercase,
        hasLetter: hasLetter,
        hasNumber: hasNumber,
        hasMinLength: hasMinLength,
        isPasswordValid: isPasswordValid,
        status: FormzSubmissionStatus.initial,
        errorMessage: null,
      ),
    );
  }

  void _onPasswordVisibilityChanged(
    LoginPasswordVisibilityChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(showPasswordHints: event.isVisible));
  }

  void _onLoginWithCredentialsPressed(
    LoginWithCredentialsPressed event,
    Emitter<LoginState> emit,
  ) {
    if (state.isFormValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      // Dispatch authentication event to the AuthBloc
      _authBloc.add(
        SignInWithEmailPasswordEvent(
          email: state.email,
          password: state.password,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'Please fill in all fields correctly',
        ),
      );
    }
  }

  Future<void> _onLoginWithGooglePressed(
    LoginWithGooglePressed event,
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

  Future<void> _onLoginWithFacebookPressed(
    LoginWithFacebookPressed event,
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

  Future<void> _onLoginWithApplePressed(
    LoginWithApplePressed event,
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
}
