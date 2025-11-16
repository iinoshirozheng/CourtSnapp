import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:project/features/auth/presentation/widgets/court_logo.dart';
import 'package:project/features/auth/presentation/pages/login_page_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/features/auth/presentation/theme/welcome_page_styles.dart';
import 'package:project/features/auth/presentation/widgets/animated_logo.dart';
import 'package:project/shared/components/buttons/primary_button.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// 應用的歡迎頁面 - 專業UI設計版
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

    // 在下一幀預加載圖片
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(
        const AssetImage('assets/images/pickleball_court.png'),
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mediaQuery = MediaQuery.of(context);
            final screenHeight = constraints.maxHeight;
            final safeAreaBottom = mediaQuery.padding.bottom;
            final breakpoints = ResponsiveBreakpoints.of(context);
            final isDesktop = breakpoints.largerThan(TABLET);
            final isTablet = breakpoints.largerThan(MOBILE) && !isDesktop;

            // 用設計稿最大高度限制縮放，避免在高螢幕過度拉伸
            const designMaxHeight = 900.0;
            final dimensionHeight = math.min(screenHeight, designMaxHeight);

            final horizontalPadding = isDesktop
                ? 40.0
                : isTablet
                    ? 28.0
                    : 20.0;
            final maxWidth = isDesktop
                ? 1200.0
                : isTablet
                    ? 900.0
                    : 640.0;
            final buttonHeight = isDesktop
                ? 60.0
                : isTablet
                    ? 56.0
                    : 52.0;

            final availableWidth = math.min(maxWidth, constraints.maxWidth);
            final buttonWidth = availableWidth - (horizontalPadding * 2);
            final logoSize = availableWidth * 0.65;
            final borderRadius = dimensionHeight * 0.015;
            final enableScroll = false;

            final content = ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                maxWidth: maxWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: dimensionHeight * 0.03),
                    AnimatedLogo(
                      floatAmplitude: dimensionHeight * 0.008,
                      floatPeriod: 2.5,
                      rotationAmplitude: 0.02,
                      pulseAmplitude: 0.02,
                      pulsePeriod: 3.0,
                      child: CourtLogo(height: logoSize),
                    ),
                    SizedBox(height: dimensionHeight * 0.06),
                    Text(
                      'COURT SNAPP',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: dimensionHeight * 0.04,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                          color:
                              Theme.of(context).textTheme.headlineLarge?.color,
                          height: 1.1,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: dimensionHeight * 0.02),
                    Text(
                      'Swipe · Snap · Serve',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: dimensionHeight * 0.02,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                          color:
                              Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: dimensionHeight * 0.03),
                    Text(
                      'The ultimate court companion',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: dimensionHeight * 0.017,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.25,
                          color: const Color(0xFF555555),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: dimensionHeight * 0.06),
                    RepaintBoundary(
                      child: Container(
                        width: buttonWidth,
                        height: buttonHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: WelcomePageStyles.brandColor.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: PrimaryButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                final viewInsets =
                                    MediaQuery.of(context).viewInsets.bottom;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: viewInsets),
                                  child: FractionallySizedBox(
                                    heightFactor: 0.9,
                                    alignment: Alignment.bottomCenter,
                                    child: Center(
                                      child: Container(
                                        constraints: const BoxConstraints(
                                          maxWidth: 520,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(24),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(
                                                0,
                                                0,
                                                0,
                                                0.2,
                                              ),
                                              blurRadius: 16,
                                              offset: Offset(0, -4),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(24),
                                          ),
                                          child: LoginPageWrapper(
                                            toggleTheme: widget.toggleTheme,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                        },
                        text: 'Book a Court',
                        width: buttonWidth,
                        height: buttonHeight,
                        borderRadius: borderRadius,
                        color: WelcomePageStyles.brandColor,
                        fontSize: dimensionHeight * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(height: dimensionHeight * 0.03),
                  GestureDetector(
                      onTap: () {
                        debugPrint('Browse courts pressed');
                      },
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: dimensionHeight * 0.015,
                        ),
                        child: Text(
                          'Browse courts',
                          style: TextStyle(
                            fontSize: dimensionHeight * 0.017,
                            color: const Color(0xFF666666),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: safeAreaBottom > 0
                          ? safeAreaBottom
                          : dimensionHeight * 0.025,
                    ),
                  ],
                ),
              ),
            );

            return Center(
              child: enableScroll
                  ? SingleChildScrollView(child: content)
                  : content,
            );
          },
        ),
      ),
    );
  }
}
