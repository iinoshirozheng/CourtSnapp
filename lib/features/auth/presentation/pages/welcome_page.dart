// 檔案：project/features/auth/presentation/pages/welcome_page.dart

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:project/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:project/features/auth/presentation/pages/login_page_wrapper.dart';
import 'package:project/features/auth/presentation/theme/welcome_page_styles.dart';
import 'package:project/features/auth/presentation/widgets/animated_logo.dart';
import 'package:project/features/auth/presentation/widgets/court_logo.dart';
import 'package:project/shared/components/buttons/primary_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 應用的歡迎頁面 - 專業UI設計版 (整合了預先快取與 BLoC 預熱)
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.toggleTheme});

  /// 切換主題的回調函數
  final VoidCallback toggleTheme;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    // 第一幀渲染後開始預載資源與預熱 BLoC
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _precacheAssets();
      _prewarmBlocs();
    });
  }

  /// 方案 A：預先快取圖片與 SVG
  void _precacheAssets() {
    // 預載球場 Logo
    precacheImage(
      const AssetImage('assets/images/pickleball_court.png'),
      context,
    );

    // 預載並解析 LoginPage 需要的社群登入 SVG Logo
    final googleLogoLoader = SvgAssetLoader('assets/logos/google-logo.svg');
    svg.cache.putIfAbsent(
      googleLogoLoader.cacheKey(context),
      () => googleLogoLoader.loadBytes(context),
    );

    final facebookLogoLoader = SvgAssetLoader('assets/logos/facebook-logo.svg');
    svg.cache.putIfAbsent(
      facebookLogoLoader.cacheKey(context),
      () => facebookLogoLoader.loadBytes(context),
    );

    final appleLogoLoader = SvgAssetLoader('assets/logos/apple-logo.svg');
    svg.cache.putIfAbsent(
      appleLogoLoader.cacheKey(context),
      () => appleLogoLoader.loadBytes(context),
    );
  }

  /// 次要方案 A：預先初始化 Blocs
  void _prewarmBlocs() {
    try {
      if (getIt.isRegistered<LoginBloc>()) {
        getIt<LoginBloc>();
      }
      if (getIt.isRegistered<AuthBloc>()) {
        getIt<AuthBloc>();
      }
    } catch (e) {
      debugPrint("Error pre-warming Blocs: $e");
    }
  }

  void _showLoginModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) {
        final viewInsets = MediaQuery.of(modalContext).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: viewInsets),
          child: FractionallySizedBox(
            heightFactor: 0.9,
            alignment: Alignment.bottomCenter,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 520),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.2),
                      blurRadius: 16,
                      offset: Offset(0, -4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: LoginPageWrapper(toggleTheme: widget.toggleTheme),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginLink(BuildContext context) {
    const baseColor = Color(0xFF666666);
    const textStyle = TextStyle(
      fontSize: 16,
      color: baseColor,
      fontWeight: FontWeight.w400,
    );

    return GestureDetector(
      onTap: () => _showLoginModal(context),
      behavior: HitTestBehavior.translucent,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text.rich(
          TextSpan(
            text: 'Already have an account? ',
            children: [
              TextSpan(
                text: 'Login',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: WelcomePageStyles.brandColor,
                ),
              ),
            ],
            style: textStyle,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// 底部行動卡片與 CTA
  Widget _buildActionCard(BuildContext context) {
    const double buttonHeight = 52.0;
    const double borderRadius = 16.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 28,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.05),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'The ultimate court companion',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.25,
              color: Color(0xFF555555),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          RepaintBoundary(
            child: Container(
              width: double.infinity,
              height: buttonHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                boxShadow: [
                  BoxShadow(
                    color: WelcomePageStyles.brandColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: PrimaryButton(
                onPressed: () => _showLoginModal(context),
                text: 'GET STARTED',
                width: double.infinity,
                height: buttonHeight,
                borderRadius: borderRadius,
                color: WelcomePageStyles.brandColor,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double idealLogoSize = 360.0;
    const double fixedMaxWidth = 520.0;
    const double horizontalPadding = 24.0;
    const double verticalPadding = 24.0;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mediaQuery = MediaQuery.of(context);
            final safeBottom = mediaQuery.padding.bottom;
            final logoSize = math.min(
              idealLogoSize,
              math.min(constraints.maxWidth * 0.8, constraints.maxHeight * 0.4),
            );

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: fixedMaxWidth),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedLogo(
                            floatAmplitude: 8.0,
                            floatPeriod: 2.5,
                            rotationAmplitude: 0.02,
                            pulseAmplitude: 0.02,
                            pulsePeriod: 3.0,
                            child: SizedBox(
                              height: logoSize,
                              child: CourtLogo(height: logoSize),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'COURT SNAPP',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.5,
                                height: 1.1,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Swipe · Snap · Serve',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          _buildActionCard(context),
                          const SizedBox(height: 20),
                          _buildLoginLink(context),
                          SizedBox(height: 32 + safeBottom),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
