import 'package:flutter/material.dart';
import 'package:project/shared/components/buttons/social_login_button.dart';
import 'package:project/shared/components/icons/social_logos.dart';

/// Facebook login button component
class FacebookLoginButton extends StatelessWidget {
  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Constructor
  const FacebookLoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      icon: const FacebookLogo(color: Colors.white),
      text: 'Continue with Facebook',
      bgColor: const Color(0xFF1877F2), // Facebook blue
      textColor: Colors.white,
      borderColor: Colors.transparent,
      borderRadius: 12.0,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }
}

/// Google login button component
class GoogleLoginButton extends StatelessWidget {
  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Constructor
  const GoogleLoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      icon: const GoogleLogo(),
      text: 'Continue with Google',
      bgColor: Colors.white,
      textColor: Colors.black87,
      borderColor: const Color(0xFF5D4037).withValues(alpha: 0.5),
      borderRadius: 12.0,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }
}

/// Apple login button component
class AppleLoginButton extends StatelessWidget {
  /// Callback when button is pressed
  final VoidCallback onPressed;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Constructor
  const AppleLoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SocialLoginButton(
      icon: const AppleLogo(color: Colors.white),
      text: 'Continue with Apple',
      bgColor: Colors.black,
      textColor: Colors.white,
      borderColor: Colors.transparent,
      borderRadius: 12.0,
      onPressed: onPressed,
      isLoading: isLoading,
    );
  }
}
