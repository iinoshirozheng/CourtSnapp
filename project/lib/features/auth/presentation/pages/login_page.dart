import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/constants/app_colors.dart';
import 'package:project/core/constants/spacing_constants.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/core/widgets/primary_button.dart';
import 'package:project/core/utils/animation_utils.dart';
import 'package:project/core/utils/form_validators.dart';
import 'package:project/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:project/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:project/features/auth/presentation/bloc/login/login_event.dart';
import 'package:project/features/auth/presentation/bloc/login/login_state.dart';
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
  bool isPasswordValid = false;
  bool isLoggingIn = false;
  bool showLoginError = false;

  // Focus management
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode loginButtonFocus = FocusNode();

  // Animation
  final double _initialButtonScale = 1.0;
  double _buttonScale = 1.0;
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize shake animation
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

  bool get canSubmit => isEmailValid && isPasswordValid && !isLoggingIn;

  void _handleLogin(BuildContext context) {
    if (!canSubmit) {
      // Show error feedback
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

    // Update LoginBloc with email and password, then trigger login
    final loginBloc = context.read<LoginBloc>();
    loginBloc.add(LoginEmailChanged(emailController.text));
    loginBloc.add(LoginPasswordChanged(passwordController.text));
    loginBloc.add(const LoginWithCredentialsPressed());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        BlocProvider<LoginBloc>(create: (context) => getIt<LoginBloc>()),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (BuildContext context, LoginState state) {
              // Handle different status states
              if (state.status == FormzSubmissionStatus.success) {
                setState(() {
                  isLoggingIn = false;
                });
                // TODO: Navigate to home page
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login successful!')),
                );
              } else if (state.status == FormzSubmissionStatus.failure) {
                setState(() {
                  isLoggingIn = false;
                  showLoginError = true;
                });
                // Show error to user
                _shakeController.forward();
                HapticFeedback.mediumImpact();

                // Display error message in a dialog
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
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
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).viewInsets.bottom +
                              SpacingConstants.spacing5,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SpacingConstants.horizontalMargin,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Top toolbar
                                SizedBox(
                                  height: SpacingConstants.spacing7,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Back button
                                      Material(
                                        color: Colors.transparent,
                                        shape: const CircleBorder(),
                                        clipBehavior: Clip.antiAlias,
                                        child: InkWell(
                                          onTap: () => Navigator.pop(context),
                                          child: const SizedBox(
                                            height: 44,
                                            width: 44,
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black87,
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Help button
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
                                            child: Icon(
                                              Icons.help_outline,
                                              color: Colors.black45,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Title section
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: SpacingConstants.spacing5,
                                    bottom: SpacingConstants.spacing6,
                                  ),
                                  child: Text(
                                    'Welcome back!',
                                    style: GoogleFonts.poppins(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      letterSpacing: -0.5,
                                      height: 1.2,
                                    ),
                                  ),
                                ),

                                // Form area
                                Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Email field
                                      AuthEmailField(
                                        controller: emailController,
                                        focusNode: emailFocus,
                                        onChanged: (value) {
                                          setState(() {
                                            isEmailValid =
                                                FormValidators.validateEmail(
                                                  value,
                                                );
                                          });
                                        },
                                        onSubmitted: (_) {
                                          FocusScope.of(
                                            context,
                                          ).requestFocus(passwordFocus);
                                        },
                                      ),

                                      const SizedBox(
                                        height: SpacingConstants.spacing4,
                                      ),

                                      // Password field
                                      AuthPasswordField(
                                        controller: passwordController,
                                        focusNode: passwordFocus,
                                        onChanged: (value) {
                                          setState(() {
                                            final validation =
                                                FormValidators.validatePassword(
                                                  value,
                                                );
                                            isPasswordValid =
                                                validation.isValid;
                                          });
                                        },
                                        onSubmitted:
                                            (_) => _handleLogin(context),
                                      ),

                                      // Forgot password button
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: SpacingConstants.spacing4,
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              // TODO: Implement forgot password
                                            },
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                                  AppColors.brandColor,
                                              padding: EdgeInsets.zero,
                                              minimumSize: Size.zero,
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            child: Text(
                                              'Forgot Password?',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Space before login button
                                const SizedBox(
                                  height: SpacingConstants.spacing5,
                                ),

                                // Login button with animation
                                AnimatedBuilder(
                                  animation: _shakeAnimation,
                                  builder: (context, child) {
                                    return Transform.translate(
                                      offset:
                                          showLoginError
                                              ? _shakeAnimation.value
                                              : Offset.zero,
                                      child: child,
                                    );
                                  },
                                  child: GestureDetector(
                                    onTapDown: (_) {
                                      if (canSubmit) {
                                        setState(() => _buttonScale = 0.95);
                                      }
                                    },
                                    onTapUp: (_) {
                                      setState(
                                        () =>
                                            _buttonScale = _initialButtonScale,
                                      );
                                      _handleLogin(context);
                                    },
                                    onTapCancel: () {
                                      setState(
                                        () =>
                                            _buttonScale = _initialButtonScale,
                                      );
                                    },
                                    child: AnimatedScale(
                                      scale: _buttonScale,
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                      child: RepaintBoundary(
                                        child: Container(
                                          width: double.infinity,
                                          height: SpacingConstants.buttonHeight,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppColors.brandColor
                                                    .withValues(alpha: 0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                                spreadRadius: -2,
                                              ),
                                            ],
                                          ),
                                          child: PrimaryButton(
                                            text: 'Login',
                                            onPressed:
                                                canSubmit
                                                    ? () =>
                                                        _handleLogin(context)
                                                    : () {},
                                            isLoading: isLoggingIn,
                                            backgroundColor:
                                                AppColors.brandColor,
                                            borderRadius: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Error message
                                if (showLoginError)
                                  AuthErrorMessage(
                                    errorMessage:
                                        'Please check your email and password',
                                  ),

                                // Space before divider
                                const SizedBox(
                                  height: SpacingConstants.spacing6,
                                ),

                                // Divider with text
                                Row(
                                  children: [
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.withValues(
                                          alpha: 0.3,
                                        ),
                                        thickness: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: SpacingConstants.spacing4,
                                      ),
                                      child: Text(
                                        'Or continue with',
                                        style: GoogleFonts.poppins(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Divider(
                                        color: Colors.grey.withValues(
                                          alpha: 0.3,
                                        ),
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),

                                // Space before social buttons
                                const SizedBox(
                                  height: SpacingConstants.spacing5,
                                ),

                                // Social login buttons
                                Column(
                                  children: [
                                    FacebookLoginButton(
                                      onPressed: () {
                                        // TODO: Facebook login implementation
                                      },
                                    ),
                                    const SizedBox(
                                      height: SpacingConstants.spacing3,
                                    ),
                                    GoogleLoginButton(
                                      onPressed: () {
                                        // TODO: Google login implementation
                                      },
                                    ),
                                    const SizedBox(
                                      height: SpacingConstants.spacing3,
                                    ),
                                    AppleLoginButton(
                                      onPressed: () {
                                        // TODO: Apple login implementation
                                      },
                                    ),
                                  ],
                                ),

                                // Bottom spacing
                                const SizedBox(
                                  height: SpacingConstants.spacing5,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
