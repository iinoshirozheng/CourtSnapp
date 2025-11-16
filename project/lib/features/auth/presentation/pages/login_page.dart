import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/constants/app_colors.dart';
import 'package:project/core/constants/spacing_constants.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/shared/components/buttons/primary_button.dart';
import 'package:project/core/utils/animation_utils.dart';
import 'package:project/core/utils/form_validators.dart';
import 'package:project/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:project/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:project/features/auth/presentation/bloc/login/login_event.dart';
import 'package:project/features/auth/presentation/bloc/login/login_state.dart';
import 'package:project/features/auth/presentation/theme/welcome_page_styles.dart';
import 'package:project/features/auth/presentation/widgets/auth_email_field.dart';
import 'package:project/features/auth/presentation/widgets/auth_error_message.dart';
import 'package:project/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:project/features/auth/presentation/widgets/social_login_buttons.dart';

/// Login page for user authentication
class LoginPage extends StatefulWidget {
  /// Callback to toggle app theme
  final VoidCallback toggleTheme;

  /// Constructor
  const LoginPage({super.key, required this.toggleTheme});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State variables
  bool isEmailValid = false;
  bool isLoggingIn = false;
  bool showLoginError = false;
  PasswordValidationResult _passwordValidationResult =
      PasswordValidationResult.initial();

  // Focus management
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode loginButtonFocus = FocusNode();

  // Animation
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    final shakeAnimData = AnimationUtils.createShakeAnimation(this);
    _shakeController = shakeAnimData.controller;
    _shakeAnimation = shakeAnimData.animation;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    loginButtonFocus.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  bool get canSubmit =>
      isEmailValid && _passwordValidationResult.isValid && !isLoggingIn;

  void _handleLogin(BuildContext context) {
    if (!canSubmit) {
      _shakeController.forward();
      HapticFeedback.mediumImpact();
      setState(() {
        showLoginError = true;
      });
      return;
    }

    setState(() {
      isLoggingIn = true;
      showLoginError = false;
    });

    final loginBloc = context.read<LoginBloc>();
    loginBloc.add(LoginEmailChanged(emailController.text));
    loginBloc.add(LoginPasswordChanged(passwordController.text));
    loginBloc.add(const LoginWithCredentialsPressed());
  }

  @override
  Widget build(BuildContext context) {
    const double horizontalPadding = 32.0;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        BlocProvider<LoginBloc>(create: (context) => getIt<LoginBloc>()),
      ],
      child: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, LoginState state) {
          if (state.status == FormzSubmissionStatus.success) {
            setState(() {
              isLoggingIn = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login successful!')),
            );
          } else if (state.status == FormzSubmissionStatus.failure) {
            setState(() {
              isLoggingIn = false;
              showLoginError = true;
            });
            _shakeController.forward();
            HapticFeedback.mediumImpact();

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Login Error'),
                content: SelectableText.rich(
                  TextSpan(
                    text: state.errorMessage ?? 'Authentication failed',
                    style: TextStyle(color: AppColors.errorColor),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: MediaQuery.of(context).viewInsets.bottom +
                      SpacingConstants.spacing5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: SpacingConstants.spacing7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const SizedBox(
                                height: 44,
                                width: 44,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.black87,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            shape: const CircleBorder(),
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () {
                                // TODO: Show help information
                              },
                              child: const SizedBox(
                                height: 44,
                                width: 44,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Icon(
                                    Icons.help_outline,
                                    color: Colors.black45,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: SpacingConstants.spacing2,
                        bottom: SpacingConstants.spacing6,
                      ),
                      child: Text(
                        'Back to the Courts!',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                    ),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AuthEmailField(
                            controller: emailController,
                            focusNode: emailFocus,
                            onChanged: (value) {
                              setState(() {
                                isEmailValid =
                                    FormValidators.validateEmail(value);
                              });
                            },
                          ),
                          const SizedBox(
                            height: SpacingConstants.spacing4,
                          ),
                          AuthPasswordField(
                            controller: passwordController,
                            focusNode: passwordFocus,
                            onChanged: (value) {
                              setState(() {
                                _passwordValidationResult =
                                    FormValidators.validatePassword(value);
                              });
                            },
                          ),
                          const SizedBox(
                            height: SpacingConstants.spacing2,
                          ),
                          AuthErrorMessage(
                            errorMessage: showLoginError
                                ? 'Please check your email and password and try again.'
                                : null,
                          ),
                          const SizedBox(
                            height: SpacingConstants.spacing5,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: BlocBuilder<LoginBloc, LoginState>(
                              builder: (context, state) {
                                return SlideTransition(
                                  position: _shakeAnimation,
                                  child: PrimaryButton(
                                    onPressed: canSubmit
                                        ? () => _handleLogin(context)
                                        : null,
                                    text: isLoggingIn
                                        ? 'Signing in...'
                                        : 'Login',
                                    isLoading: isLoggingIn,
                                    height: 56,
                                    borderRadius: 16,
                                    color: WelcomePageStyles.brandColor,
                                  ),
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Forgot password flow
                              },
                              child: const Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SpacingConstants.spacing6),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SpacingConstants.spacing2,
                          ),
                          child: Text(
                            'or continue with',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: SpacingConstants.spacing4),
                    Column(
                      children: [
                        GoogleLoginButton(
                          onPressed: () {
                            // TODO: Google sign-in
                          },
                        ),
                        const SizedBox(
                          height: SpacingConstants.spacing2,
                        ),
                        FacebookLoginButton(
                          onPressed: () {
                            // TODO: Facebook sign-in
                          },
                        ),
                        const SizedBox(
                          height: SpacingConstants.spacing2,
                        ),
                        AppleLoginButton(
                          onPressed: () {
                            // TODO: Apple sign-in
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
