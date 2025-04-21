class AppConstants {
  // App Information
  static const String appName = 'Court Snapp';
  static const String appTagline = 'Swipe · Snap · Serve';
  static const String appDescription = 'The ultimate court companion';

  // Routes
  static const String welcomeRoute = '/';
  static const String loginRoute = '/login';

  // Assets
  static const String courtImagePath = 'assets/images/pickleball_court.png';

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Animation Constants
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Error Messages
  static const String genericError = 'Something went wrong. Please try again.';

  const AppConstants._();
}
