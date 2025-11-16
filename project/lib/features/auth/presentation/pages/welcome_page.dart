import 'dart:math' as math; // 保留給 AnimatedLogo 使用

import 'package:flutter/material.dart';
import 'package:project/features/auth/presentation/widgets/court_logo.dart';
import 'package:project/features/auth/presentation/pages/login_page_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/features/auth/presentation/theme/welcome_page_styles.dart';
import 'package:project/features/auth/presentation/widgets/animated_logo.dart';
import 'package:project/shared/components/buttons/primary_button.dart';
// import 'package:responsive_framework/responsive_framework.dart'; // 不再需要

/// 應用的歡迎頁面 - 專業UI設計版 (修改為固定寬度佈局)
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
    // --- 變更點：定義固定的大小 ---
    // 透過固定最大寬度並讓 Logo 依可用高度縮放
    const double fixedMaxWidth = 520.0; // 內容的最大寬度
    const double idealLogoSize = 300.0; // Logo 的理想最大高度
    const double buttonHeight = 52.0; // 按鈕的固定高度 (使用原先的行動版尺寸)
    const double borderRadius = 16.0;
    const double horizontalPadding = 24.0; // 兩側的固定內距
    const double verticalPadding = 24.0; // 頂部和底部的內距

    return Scaffold(
      body: SafeArea(
        // --- 變更點：使用 Center 來居中所有內容 ---
        child: Center(
          // --- 變更點：移除了 SingleChildScrollView ---
          // --- 變更點：加入 Padding ---
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            // --- 變更點：使用 ConstrainedBox 設定最大寬度 ---
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: fixedMaxWidth),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 頂部間距 (可選，如果 verticalPadding 已足夠，可移除)
                  // const SizedBox(height: 24),
                  Flexible(
                    child: AnimatedLogo(
                      floatAmplitude: 8.0,
                      floatPeriod: 2.5,
                      rotationAmplitude: 0.02,
                      pulseAmplitude: 0.02,
                      pulsePeriod: 3.0,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double effectiveLogoSize = math.min(
                            idealLogoSize,
                            constraints.maxHeight,
                          );

                          if (effectiveLogoSize <= 0) {
                            return const SizedBox.shrink();
                          }

                          return CourtLogo(height: effectiveLogoSize);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
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
                  const SizedBox(height: 16),
                  Text(
                    'Swipe · Snap · Serve',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 48),
                  RepaintBoundary(
                    child: Container(
                      // --- 變更點：寬度設為無限，它會自動填滿 ConstrainedBox 的寬度 ---
                      width: double.infinity,
                      height: buttonHeight, // 使用固定 buttonHeight
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
                              final viewInsets = MediaQuery.of(
                                context,
                              ).viewInsets.bottom;
                              return Padding(
                                padding: EdgeInsets.only(bottom: viewInsets),
                                child: FractionallySizedBox(
                                  heightFactor: 0.9,
                                  alignment: Alignment.bottomCenter,
                                  child: Center(
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 520, // 這與我們的 fixedMaxWidth 一致
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(0, 0, 0, 0.2),
                                            blurRadius: 16,
                                            offset: Offset(0, -4),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
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
                        // --- 變更點：寬度設為無限 ---
                        width: double.infinity,
                        height: buttonHeight, // 使用固定 buttonHeight
                        borderRadius: borderRadius,
                        color: WelcomePageStyles.brandColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      debugPrint('Browse courts pressed');
                    },
                    behavior: HitTestBehavior.translucent,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Browse courts',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
