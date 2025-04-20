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

  // 品牌色彩系統 - 基於網球場配色
  static const Color pinkColor = Color(0xFFF9BBCB); // 粉紅色（邊界）
  static const Color lightGreenColor = Color(0xFFB8E0B9); // 淺綠色（球場）
  static const Color greenColor = Color(0xFF8AD28B); // 綠色（球場）
  static const Color lightBlueColor = Color(0xFF77CEF9); // 淺藍色（網區）
  static const Color blueColor = Color(0xFF5BBAED); // 藍色（網區）

  // 按鈕主色 - 粉紫色調（呼應網球場粉色與藍紫色的融合）
  static const Color brandColor = Color(0xFFB06AB3); // 粉紫色調

  // 按鈕寬度
  static double getButtonWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600 ? 320.0 : screenWidth * 0.84;
  }

  // 品牌漸變顏色 - 從粉紅色過渡到粉紫色再到淺綠色，與網球場配色呼應
  static const List<Color> titleGradientColors = [
    pinkColor, // 粉紅色（球場邊界）起點
    Color(0xFFD486C6), // 粉紫過渡色
    brandColor, // 品牌主色（粉紫）
    Color(0xFF7E9CE3), // 紫藍過渡色
    lightBlueColor, // 淺藍色（網區）
    Color(0xFF9BD392), // 藍綠過渡色
    lightGreenColor, // 淺綠色（球場）終點
    pinkColor, // 回到起點，實現循環
  ];
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
