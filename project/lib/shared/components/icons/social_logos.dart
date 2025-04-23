import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A Google logo component
class GoogleLogo extends StatelessWidget {
  /// Size of the logo
  final double size;

  /// Constructor
  const GoogleLogo({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/logos/google-logo.svg',
        width: size,
        height: size,
      ),
    );
  }
}

/// An Apple logo component
class AppleLogo extends StatelessWidget {
  /// Size of the logo
  final double size;

  /// Color of the logo (defaults to black)
  final Color color;

  /// Constructor
  const AppleLogo({super.key, this.size = 20, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/logos/apple-logo.svg',
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}

/// A Facebook logo component
class FacebookLogo extends StatelessWidget {
  /// Size of the logo
  final double size;

  /// Constructor
  const FacebookLogo({super.key, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        'assets/logos/facebook-logo.svg',
        width: size,
        height: size,
      ),
    );
  }
}
