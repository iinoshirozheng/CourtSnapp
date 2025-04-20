import 'package:flutter/material.dart';
import 'package:project/features/auth/presentation/widgets/court_logo.dart';
import 'package:project/features/auth/presentation/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/core/theme/welcome_page_styles.dart';
import 'package:project/features/auth/presentation/widgets/animated_logo.dart';

/// 應用的歡迎頁面 - 專業UI設計版
class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.toggleTheme});

  /// 切換主題的回調函數
  final VoidCallback toggleTheme;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    // 獲取屏幕尺寸
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    // 計算響應式尺寸
    final horizontalPadding = screenWidth * 0.08; // 8% of screen width
    final buttonHeight = screenHeight * 0.06; // 6% of screen height
    final buttonWidth = screenWidth * 0.84; // 84% of screen width
    final logoSize = screenWidth * 0.65; // 65% of screen width
    final borderRadius = screenHeight * 0.015; // 1.5% of screen height

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header (flex: 0) - Logo區域
            SizedBox(height: screenHeight * 0.03), // 3% of screen height
            // Body (flex: 1) - 主要內容區域，置中對齊
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Illustration
                      AnimatedLogo(
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

                      SizedBox(
                        height: screenHeight * 0.06,
                      ), // 6% of screen height
                      // Title
                      Text(
                        'COURT SNAPP',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize:
                                screenHeight * 0.04, // 4% of screen height
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

                      SizedBox(
                        height: screenHeight * 0.02,
                      ), // 2% of screen height
                      // Subtitle
                      Text(
                        'Swipe · Snap · Serve',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize:
                                screenHeight * 0.02, // 2% of screen height
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: screenHeight * 0.03,
                      ), // 3% of screen height
                      // Tagline
                      Text(
                        'The ultimate court companion',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize:
                                screenHeight * 0.017, // 1.7% of screen height
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.25,
                            color: const Color(0xFF555555),
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Footer (flex: 0) - 按鈕區域
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.06), // 6% of screen height
                  // CTA Button - Book a Court
                  Container(
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
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint('Book a court button pressed');
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    LoginPage(toggleTheme: widget.toggleTheme),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              var begin = const Offset(0.0, 1.0);
                              var end = Offset.zero;
                              var curve = Curves.easeOutQuint;
                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(
                              milliseconds: 500,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: WelcomePageStyles.brandColor,
                        foregroundColor: Colors.white,
                        minimumSize: Size(buttonWidth, buttonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        elevation: 0,
                        textStyle: TextStyle(
                          fontSize: screenHeight * 0.02, // 2% of screen height
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child: const Text('Book a Court'),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03), // 3% of screen height
                  // Secondary Link - Browse courts
                  GestureDetector(
                    onTap: () {
                      debugPrint('Browse courts pressed');
                      // TODO: 導航到瀏覽球場頁面
                    },
                    behavior: HitTestBehavior.translucent, // 擴大點擊範圍
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015, // 1.5% of screen height
                      ),
                      child: Text(
                        'Browse courts',
                        style: TextStyle(
                          fontSize:
                              screenHeight * 0.017, // 1.7% of screen height
                          color: const Color(0xFF666666), // 品牌灰 #666
                          fontWeight: FontWeight.w400, // Regular
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),

                  SizedBox(
                    height:
                        safeAreaBottom > 0
                            ? safeAreaBottom
                            : screenHeight * 0.025,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
