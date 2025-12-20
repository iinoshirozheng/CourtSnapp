import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/core/constants/asset_constants.dart';

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
        AssetConstants.googleLogo,
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
        AssetConstants.appleLogo,
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

  /// Color of the logo (defaults to blue)
  final Color color;

  /// Constructor
  const FacebookLogo({
    super.key,
    this.size = 20,
    this.color = const Color(0xFF1877F2),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        AssetConstants.facebookLogo,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
