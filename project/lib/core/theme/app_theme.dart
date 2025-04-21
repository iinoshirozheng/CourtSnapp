import 'package:flutter/material.dart';

/// 專業UI/UX設計的應用主題系統，基於網球場配色
class AppTheme {
  // 顏色系統 - 基於UI/UX設計師規範的網球場主題配色
  static const colorPrimary = Color(0xFF007F3B); // 草地綠 (UI規範主色)
  static const colorPrimaryLight = Color(0xFFB8E0B9); // 淺綠色
  static const colorPrimaryDark = Color(0xFF005A29); // 深綠色

  static const colorSecondary = Color(0xFFFFFFFF); // 球場線白色 (UI規範次色)
  static const colorSecondaryLight = Color(0xFFFAFAFA); // 淺白色
  static const colorSecondaryDark = Color(0xFFE0E0E0); // 深白色

  static const colorAccent = Color(0xFFFFD600); // 網球黃 (UI規範強調色)
  static const colorAccentLight = Color(0xFFFFE566); // 淺黃色
  static const colorAccentDark = Color(0xFFC7A500); // 深黃色

  static const colorNetGray = Color(0xFF666666); // 中性灰 (UI規範中性色)

  // 淺色主題中性色
  static const colorBackground = Color(0xFFFAFAFA); // 背景色
  static const colorSurface = Color(0xFFFFFFFF); // 表面色
  static const colorTextPrimary = Color(0xFF1A1A1A); // 主要文本
  static const colorTextSecondary = Color(0xFF5B5B5B); // 次要文本
  static const colorTextHint = Color(0xFF757575); // 提示文本
  static const colorTextLight = Color(0xFFFFFFFF); // 亮色文本

  // 深色主題中性色 - 按照UI/UX設計師規範
  static const colorDarkBackground = Color(0xFF121212); // 深色背景 (UI規範深色背景)
  static const colorDarkSurface = Color(0xFF1E1E1E); // 深色表面
  static const colorDarkTextPrimary = Color(0xFFFFD600); // 深色主要文本 (使用網球黃)
  static const colorDarkTextSecondary = Color(0xFFBDBDBD); // 深色次要文本
  static const colorDarkTextHint = Color(0xFF9E9E9E); // 深色提示文本
  static const colorDarkTextDark = Color(0xFF1A1A1A); // 深色上的深色文本

  // 縮放字體大小 - 基於UI/UX設計師規範的8pt網格系統
  static const double fontSizeH1 = 40.0; // H1
  static const double fontSizeH2 = 32.0; // H2
  static const double fontSizeH3 = 24.0; // H3
  static const double fontSizeH4 = 20.0; // H4
  static const double fontSizeH5 = 16.0; // H5
  static const double fontSizeBodyLarge = 16.0; // Body
  static const double fontSizeBodyMedium = 14.0; // Body
  static const double fontSizeCaption = 12.0; // Caption

  // 標準間距 - 基於8pt網格系統
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacing2xl = 48.0;

  // 標準圓角半徑 - 基於UI/UX設計師規範
  static const double radiusSmall = 12.0; // Small
  static const double radiusMedium = 16.0; // Medium
  static const double radiusLarge = 24.0; // Large

  // 標準陰影
  static List<BoxShadow> get shadowSmall => [
    BoxShadow(
      color: Colors.black.withAlpha(13), // ~0.05 opacity
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> get shadowMedium => [
    BoxShadow(
      color: Colors.black.withAlpha(20), // ~0.08 opacity
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get shadowLarge => [
    BoxShadow(
      color: Colors.black.withAlpha(38), // ~0.15 opacity
      blurRadius: 16,
      spreadRadius: 1,
      offset: const Offset(0, 8),
    ),
  ];

  /// 淺色主題（預設）
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      primaryColor: colorPrimary,
      colorScheme: ColorScheme.light(
        primary: colorPrimary,
        primaryContainer: colorPrimaryLight,
        secondary: colorSecondary,
        secondaryContainer: colorSecondaryLight,
        surface: colorSurface,
        error: Colors.red.shade700,
        tertiary: colorAccent,
      ),
      scaffoldBackgroundColor: colorBackground,

      // 文本主題
      textTheme: TextTheme(
        // 標題樣式
        headlineLarge: TextStyle(
          fontSize: fontSizeH1,
          fontWeight: FontWeight.w700,
          color: colorTextPrimary,
          letterSpacing: 0.2,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: fontSizeH2,
          fontWeight: FontWeight.w700,
          color: colorTextPrimary,
          letterSpacing: 0.15,
          height: 1.25,
        ),
        headlineSmall: TextStyle(
          fontSize: fontSizeH3,
          fontWeight: FontWeight.w700,
          color: colorTextPrimary,
          letterSpacing: 0.1,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: fontSizeH4,
          fontWeight: FontWeight.w500,
          color: colorTextPrimary,
          letterSpacing: 0.1,
          height: 1.3,
        ),
        titleMedium: TextStyle(
          fontSize: fontSizeH5,
          fontWeight: FontWeight.w500,
          color: colorTextPrimary,
          letterSpacing: 0.1,
          height: 1.3,
        ),

        // 內文樣式
        bodyLarge: TextStyle(
          fontSize: fontSizeBodyLarge,
          fontWeight: FontWeight.w400,
          color: colorTextPrimary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: fontSizeBodyMedium,
          fontWeight: FontWeight.w400,
          color: colorTextSecondary,
          height: 1.6,
        ),
        bodySmall: TextStyle(
          fontSize: fontSizeCaption,
          fontWeight: FontWeight.w400,
          color: colorTextHint,
          height: 1.4,
        ),

        // 標籤和按鈕文本
        labelLarge: TextStyle(
          fontSize: fontSizeBodyMedium,
          fontWeight: FontWeight.w500,
          color: colorTextPrimary,
          letterSpacing: 0.1,
        ),
      ),

      // 應用欄主題
      appBarTheme: AppBarTheme(
        backgroundColor: colorSurface,
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.black.withAlpha(13), // ~0.05 opacity
        titleTextStyle: TextStyle(
          color: colorTextPrimary,
          fontSize: fontSizeH4,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(color: colorTextPrimary),
      ),

      // 卡片主題
      cardTheme: CardTheme(
        color: colorSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        shadowColor: Colors.black.withAlpha(26), // ~0.1 opacity
        margin: const EdgeInsets.all(spacingSm),
      ),

      // 按鈕主題
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorPrimary,
          foregroundColor: colorTextLight,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: spacingMd,
            horizontal: spacingLg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBodyMedium,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorPrimary,
          side: BorderSide(color: colorPrimary),
          padding: const EdgeInsets.symmetric(
            vertical: spacingMd,
            horizontal: spacingLg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBodyMedium,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorPrimary,
          padding: const EdgeInsets.symmetric(
            vertical: spacingSm,
            horizontal: spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBodyMedium,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // 輸入框主題
      inputDecorationTheme: InputDecorationTheme(
        fillColor: colorSurface,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: spacingMd,
          horizontal: spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorPrimaryLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        hintStyle: TextStyle(
          color: colorTextHint,
          fontSize: fontSizeBodyMedium,
        ),
        labelStyle: TextStyle(
          color: colorTextSecondary,
          fontSize: fontSizeBodyMedium,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: TextStyle(
          color: colorPrimary,
          fontSize: fontSizeBodyMedium,
          fontWeight: FontWeight.w500,
        ),
      ),

      // 底部導航欄主題
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorSurface,
        selectedItemColor: colorPrimary,
        unselectedItemColor: colorTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showUnselectedLabels: true,
      ),
    );
  }

  /// 深色主題 - 基於UI/UX設計師規範
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: colorAccent, // 在暗模式下使用網球黃作為主色
      colorScheme: ColorScheme.dark(
        primary: colorAccent, // 網球黃作為主色
        primaryContainer: colorAccentLight,
        secondary: colorSecondary,
        secondaryContainer: colorSecondaryDark,
        surface: colorDarkSurface,
        error: Colors.red.shade700,
        tertiary: colorPrimary, // 草地綠作為第三色
      ),
      scaffoldBackgroundColor: colorDarkBackground,

      // 文本主題
      textTheme: TextTheme(
        // 標題樣式
        headlineLarge: TextStyle(
          fontSize: fontSizeH1,
          fontWeight: FontWeight.w700,
          color: colorDarkTextPrimary,
          letterSpacing: 0.2,
          height: 1.2,
        ),
        headlineMedium: TextStyle(
          fontSize: fontSizeH2,
          fontWeight: FontWeight.w700,
          color: colorDarkTextPrimary,
          letterSpacing: 0.15,
          height: 1.25,
        ),
        headlineSmall: TextStyle(
          fontSize: fontSizeH3,
          fontWeight: FontWeight.w700,
          color: colorDarkTextPrimary,
          letterSpacing: 0.1,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: fontSizeH4,
          fontWeight: FontWeight.w500,
          color: colorDarkTextPrimary,
          letterSpacing: 0.1,
          height: 1.3,
        ),
        titleMedium: TextStyle(
          fontSize: fontSizeH5,
          fontWeight: FontWeight.w500,
          color: colorDarkTextPrimary,
          letterSpacing: 0.1,
          height: 1.3,
        ),

        // 內文樣式
        bodyLarge: TextStyle(
          fontSize: fontSizeBodyLarge,
          fontWeight: FontWeight.w400,
          color: colorDarkTextSecondary,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontSize: fontSizeBodyMedium,
          fontWeight: FontWeight.w400,
          color: colorDarkTextSecondary,
          height: 1.6,
        ),
        bodySmall: TextStyle(
          fontSize: fontSizeCaption,
          fontWeight: FontWeight.w400,
          color: colorDarkTextHint,
          height: 1.4,
        ),

        // 標籤和按鈕文本
        labelLarge: TextStyle(
          fontSize: fontSizeBodyMedium,
          fontWeight: FontWeight.w500,
          color: colorDarkTextPrimary,
          letterSpacing: 0.1,
        ),
      ),

      // 應用欄主題
      appBarTheme: AppBarTheme(
        backgroundColor: colorDarkSurface,
        elevation: 0,
        centerTitle: true,
        shadowColor: Colors.black.withAlpha(40),
        titleTextStyle: TextStyle(
          color: colorDarkTextPrimary,
          fontSize: fontSizeH4,
          fontWeight: FontWeight.w500,
        ),
        iconTheme: IconThemeData(color: colorDarkTextPrimary),
      ),

      // 卡片主題
      cardTheme: CardTheme(
        color: colorDarkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        shadowColor: Colors.black.withAlpha(40),
        margin: const EdgeInsets.all(spacingSm),
      ),

      // 按鈕主題
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorAccent, // 網球黃作為按鈕背景
          foregroundColor: colorDarkTextDark, // 深色文本
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: spacingMd,
            horizontal: spacingLg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBodyMedium,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorAccent, // 網球黃作為文本顏色
          side: BorderSide(color: colorAccent), // 網球黃作為邊框
          padding: const EdgeInsets.symmetric(
            vertical: spacingMd,
            horizontal: spacingLg,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBodyMedium,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorAccent, // 網球黃作為文本顏色
          padding: const EdgeInsets.symmetric(
            vertical: spacingSm,
            horizontal: spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusSmall),
          ),
          textStyle: const TextStyle(
            fontSize: fontSizeBodyMedium,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),

      // 輸入框主題
      inputDecorationTheme: InputDecorationTheme(
        fillColor: colorDarkSurface,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: spacingMd,
          horizontal: spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorAccentDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: colorAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        hintStyle: TextStyle(
          color: colorDarkTextHint,
          fontSize: fontSizeBodyMedium,
        ),
        labelStyle: TextStyle(
          color: colorDarkTextSecondary,
          fontSize: fontSizeBodyMedium,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: TextStyle(
          color: colorAccent,
          fontSize: fontSizeBodyMedium,
          fontWeight: FontWeight.w500,
        ),
      ),

      // 底部導航欄主題
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorDarkSurface,
        selectedItemColor: colorAccent, // 網球黃作為選中項目顏色
        unselectedItemColor: colorDarkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        showUnselectedLabels: true,
      ),
    );
  }
}
