import 'package:flutter/material.dart';

/// 歡迎頁面的樣式參數
class WelcomePageStyles {
  // 防止實例化
  WelcomePageStyles._();

  // 計算相對尺寸 - 使用8pt網格系統
  static double getUnit(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.01; // 基礎單位

  // 間距
  static double getSmallSpace(BuildContext context) => getUnit(context); // 8pt
  static double getMediumSpace(BuildContext context) =>
      getUnit(context) * 3; // 24pt
  static double getLargeSpace(BuildContext context) =>
      getUnit(context) * 6; // 48pt
  static double getHorizontalPadding(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.08; // 適當減少以提供更多內容空間

  // 字體大小
  static double getHeadingFontSize(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.042; // H1
  static double getSubtitleFontSize(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.021; // H3
  static double getBodyFontSize(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.018; // Body
  static double getSmallBodyFontSize(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.0175; // 調整小號正文

  // 字間距
  static double getLetterSpacingValue(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.001;

  // 品牌色彩系統 - 基於UI規範配色
  static const Color primaryColor = Color(0xFF007F3B); // 草地綠 (主色)
  static const Color secondaryColor = Color(0xFFFFFFFF); // 球場線白色 (次要色)
  static const Color accentColor = Color(0xFFFFD600); // 網球黃 (強調色)
  static const Color netGrayColor = Color(0xFF666666); // 中性灰

  // 保留原有網球場相關顏色用於過渡
  static const Color pinkColor = Color(0xFFF9BBCB); // 粉紅色（邊界）
  static const Color lightGreenColor = Color(0xFFB8E0B9); // 淺綠色（球場）
  static const Color greenColor = Color(0xFF8AD28B); // 綠色（球場）
  static const Color lightBlueColor = Color(0xFF77CEF9); // 淺藍色（網區）
  static const Color blueColor = Color(0xFF5BBAED); // 藍色（網區）

  // 暗色主題色彩 - 根據UI規範
  static const Color darkBackground = Color(0xFF121212); // 暗色背景
  static const Color darkSurfaceColor = Color(0xFF1E1E1E); // 暗色表面
  static const Color darkDividerColor = Color(0xFF2C2C2C); // 暗色分隔線

  // 按鈕主色 - 使用品牌主色
  static const Color brandColor = primaryColor; // 使用草地綠作為品牌色

  // 按鈕寬度
  static double getButtonWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600 ? 320.0 : screenWidth * 0.84;
  }

  // 品牌漸變顏色 - 使用主色和次色
  static const List<Color> titleGradientColors = [
    primaryColor, // 草地綠
    Color(0xFF00A850), // 淺綠色（過渡色）
  ];

  // 暗色主題漸變顏色
  static const List<Color> darkTitleGradientColors = [
    accentColor, // 網球黃
    Color(0xFFFFE566), // 淺黃色（過渡色）
  ];

  // 根據主題獲取漸變顏色
  static List<Color> getTitleGradientColors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTitleGradientColors
        : titleGradientColors;
  }

  // 根據主題獲取背景顏色
  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground
        : secondaryColor; // 亮色主題使用白色背景
  }

  // 根據主題獲取表面顏色
  static Color getSurfaceColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurfaceColor
        : Colors.grey[50]!;
  }

  // 根據主題獲取分隔線顏色
  static Color getDividerColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkDividerColor
        : Colors.grey.withValues(alpha: .3);
  }

  // 根據主題獲取文本顏色
  static Color getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? accentColor // 暗色主題使用網球黃作為文本
        : primaryColor; // 亮色主題使用草地綠
  }

  // 根據主題獲取次要文本顏色
  static Color getSecondaryTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[400]!
        : netGrayColor;
  }

  // 根據主題獲取按鈕顏色
  static Color getButtonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? accentColor // 暗色主題使用網球黃作為按鈕
        : primaryColor; // 亮色主題使用草地綠
  }

  // 獲取按鈕文本顏色
  static Color getButtonTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBackground // 暗色主題按鈕文本使用深色背景色
        : secondaryColor; // 亮色主題按鈕文本使用白色
  }

  // 獲取陰影
  static List<BoxShadow> getShadow(BuildContext context) {
    return [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.1),
        offset: const Offset(0, 4),
        blurRadius: 12,
        spreadRadius: 0,
      ),
    ];
  }
}

/// 登錄頁面的樣式參數
/// @deprecated Use WelcomePageStyles instead
class LoginPageStyles {
  // 防止實例化
  LoginPageStyles._();

  /// @deprecated Use WelcomePageStyles.getUnit instead
  static double getUnit(BuildContext context) =>
      WelcomePageStyles.getUnit(context);

  /// @deprecated Use WelcomePageStyles.getSmallSpace instead
  static double getSmallSpace(BuildContext context) =>
      WelcomePageStyles.getSmallSpace(context);

  /// @deprecated Use WelcomePageStyles.getMediumSpace instead
  static double getMediumSpace(BuildContext context) =>
      WelcomePageStyles.getMediumSpace(context);

  /// @deprecated Use WelcomePageStyles.getLargeSpace instead
  static double getLargeSpace(BuildContext context) =>
      WelcomePageStyles.getLargeSpace(context);

  /// @deprecated Use WelcomePageStyles.getHorizontalPadding instead
  static double getHorizontalPadding(BuildContext context) =>
      WelcomePageStyles.getHorizontalPadding(context);

  /// @deprecated Use WelcomePageStyles.getHeadingFontSize instead
  static double getHeadingFontSize(BuildContext context) =>
      WelcomePageStyles.getHeadingFontSize(context);

  /// @deprecated Use WelcomePageStyles.getSubtitleFontSize instead
  static double getSubtitleFontSize(BuildContext context) =>
      WelcomePageStyles.getSubtitleFontSize(context);

  /// @deprecated Use WelcomePageStyles.getBodyFontSize instead
  static double getBodyFontSize(BuildContext context) =>
      WelcomePageStyles.getBodyFontSize(context);

  /// @deprecated Use WelcomePageStyles.getSmallBodyFontSize instead
  static double getSmallBodyFontSize(BuildContext context) =>
      WelcomePageStyles.getSmallBodyFontSize(context);

  /// @deprecated Use WelcomePageStyles.getLetterSpacingValue instead
  static double getLetterSpacingValue(BuildContext context) =>
      WelcomePageStyles.getLetterSpacingValue(context);

  // 品牌色彩系統 - 基於網球場配色 - Use WelcomePageStyles instead
  static const Color pinkColor = WelcomePageStyles.pinkColor;
  static const Color lightGreenColor = WelcomePageStyles.lightGreenColor;
  static const Color greenColor = WelcomePageStyles.greenColor;
  static const Color lightBlueColor = WelcomePageStyles.lightBlueColor;
  static const Color blueColor = WelcomePageStyles.blueColor;

  // 按鈕主色 - Use WelcomePageStyles.brandColor instead
  static const Color brandColor = WelcomePageStyles.brandColor;

  /// @deprecated Use WelcomePageStyles.getButtonWidth instead
  static double getButtonWidth(BuildContext context) =>
      WelcomePageStyles.getButtonWidth(context);

  // 品牌漸變顏色 - Use WelcomePageStyles.titleGradientColors instead
  static const List<Color> titleGradientColors =
      WelcomePageStyles.titleGradientColors;
}
