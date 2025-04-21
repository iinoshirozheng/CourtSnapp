import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/constants/app_constants.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/core/presentation/bloc/theme/theme_bloc.dart';
import 'package:project/core/presentation/components/buttons/primary_button.dart';
import 'package:project/core/presentation/components/buttons/secondary_button.dart';
import 'package:project/core/presentation/components/layouts/animated_logo_container.dart';
import 'package:project/core/presentation/viewmodels/app_view_model_factory.dart';
import 'package:project/core/theme/app_styles.dart';
import 'package:project/features/auth/presentation/pages/login_page.dart';
import 'package:project/features/auth/presentation/viewmodels/welcome_viewmodel.dart';
import 'package:project/features/auth/presentation/widgets/court_logo.dart';

class WelcomePageRefactored extends StatefulWidget {
  const WelcomePageRefactored({super.key});

  @override
  State<WelcomePageRefactored> createState() => _WelcomePageRefactoredState();
}

class _WelcomePageRefactoredState extends State<WelcomePageRefactored> {
  late WelcomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    // Initialize view model in the next frame to ensure BuildContext is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Get view model from factory
      _viewModel = getIt<AppViewModelFactory>().getViewModel<WelcomeViewModel>(
        context,
      );

      // Pre-load login page
      final loginPage = LoginPage(
        toggleTheme:
            () => context.read<ThemeBloc>().add(const ThemeEvent.toggled()),
      );

      _viewModel.setLoginPage(loginPage);
      _viewModel.setPageReady(true);

      // Precache images
      precacheImage(const AssetImage(AppConstants.courtImagePath), context);

      // Trigger rebuild with new state
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose view model when no longer needed
    getIt<AppViewModelFactory>().disposeViewModel<WelcomeViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive sizes
    final horizontalPadding = screenWidth * 0.08; // 8% of screen width
    final buttonHeight = screenHeight * 0.06; // 6% of screen height
    final buttonWidth = screenWidth * 0.84; // 84% of screen width
    final logoSize = screenWidth * 0.65; // 65% of screen width

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header spacing
            SizedBox(height: screenHeight * 0.03),

            // Main content area
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo with animations
                      AnimatedLogoContainer(
                        floatAmplitude: screenHeight * 0.008,
                        floatPeriod: 2.5,
                        rotationAmplitude: 0.02,
                        pulseAmplitude: 0.02,
                        pulsePeriod: 3.0,
                        child: Hero(
                          tag: 'court_logo',
                          child: CourtLogo(height: logoSize),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.06),

                      // App title
                      Text(
                        AppConstants.appName,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: screenHeight * 0.04,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.5,
                            color:
                                Theme.of(
                                  context,
                                ).textTheme.headlineLarge?.color,
                            height: 1.1,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Tagline
                      Text(
                        AppConstants.appTagline,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: screenHeight * 0.02,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      // Description
                      Text(
                        AppConstants.appDescription,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: screenHeight * 0.017,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                            color: AppStyles.textSecondary,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer with buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.06),

                  // Primary action button
                  PrimaryButton(
                    text: 'Book a Court',
                    width: buttonWidth,
                    height: buttonHeight,
                    backgroundColor: AppStyles.brandPrimary,
                    shadow: AppStyles.primaryShadow,
                    isLoading: _viewModel.isButtonPressed,
                    onPressed: () {
                      if (!(_viewModel.isPageReady)) return;

                      setState(() {
                        _viewModel.setButtonPressed(true);
                      });

                      _viewModel
                          .navigateToLogin(
                            context,
                            (page) =>
                                _SmoothSlideUpPageRoute(builder: (_) => page),
                          )
                          .then((_) {
                            if (mounted) {
                              setState(() {
                                _viewModel.setButtonPressed(false);
                              });
                            }
                          });
                    },
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Secondary action
                  SecondaryButton(
                    text: 'Browse Courts',
                    width: buttonWidth,
                    textColor: AppStyles.brandPrimary,
                    onPressed: () {
                      debugPrint('Browse courts pressed');
                    },
                  ),

                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom page route for smooth transitions
class _SmoothSlideUpPageRoute<T> extends PageRouteBuilder<T> {
  final WidgetBuilder builder;

  _SmoothSlideUpPageRoute({required this.builder})
    : super(
        pageBuilder:
            (context, animation, secondaryAnimation) => builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.1);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: AppConstants.longAnimationDuration,
      );
}
