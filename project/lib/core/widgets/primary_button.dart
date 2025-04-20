import 'package:flutter/material.dart';

/// 通用主要按鈕組件
///
/// 支持純色按鈕或帶漸層文字的按鈕
/// 提供加載狀態顯示
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 8,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.gradient,
  });

  /// 按鈕文字
  final String text;

  /// 點擊回調
  final VoidCallback onPressed;

  /// 是否顯示加載指示器
  final bool isLoading;

  /// 按鈕寬度
  final double width;

  /// 按鈕高度
  final double height;

  /// 邊框圓角半徑
  final double borderRadius;

  /// 背景顏色，默認為黑色
  final Color? backgroundColor;

  /// 文字顏色，默認為白色
  final Color? textColor;

  /// 文字大小
  final double? fontSize;

  /// 文字漸層，如果提供則會應用在文字上
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.black,
          foregroundColor: textColor ?? Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          disabledBackgroundColor: Colors.grey,
          elevation: 4,
          shadowColor: Colors.black.withAlpha(100),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  /// 根據狀態構建按鈕內容
  Widget _buildButtonContent() {
    if (isLoading) {
      return const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
      );
    }

    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (bounds) => gradient!.createShader(bounds),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize ?? 16,
            color: Colors.white,
          ),
        ),
      );
    }

    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize ?? 16),
    );
  }
}
