import 'package:flutter/material.dart';

/// 網球場/羽球場 logo 組件
///
/// 嘗試加載資源圖片，若資源不可用則繪製一個網球場圖示作為備用
class CourtLogo extends StatelessWidget {
  const CourtLogo({super.key, this.height = 200, this.width});

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    // 檢測當前主題是否為深色模式
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // 根據當前主題選擇合適的圖片
    final imagePath = 'assets/images/pickleball_court.png';

    return Stack(
      children: [
        Image.asset(
          imagePath,
          height: height,
          width: width,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            // 顯示錯誤信息和備用的自定義繪製球場
            debugPrint('Error loading image: $error');
            debugPrint('Image path: $imagePath');
            debugPrint('StackTrace: $stackTrace');

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isDarkMode)
                  Text('無法加載深色模式圖片', style: TextStyle(color: Colors.white))
                else
                  Text('無法加載圖片'),
                SizedBox(
                  height: height,
                  width: width ?? height * 0.5,
                  child: CustomPaint(painter: CourtPainter()),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// 繪製網球場/羽球場的自定義畫筆
class CourtPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    // 顏色定義
    final courtColor =
        Paint()
          ..color = const Color(0xFFB8E0B9) // 綠色場地
          ..style = PaintingStyle.fill;

    final borderColor =
        Paint()
          ..color = const Color(0xFFF9BBCB) // 粉色邊框
          ..style = PaintingStyle.fill;

    final netColor =
        Paint()
          ..color = const Color(0xFFADD8E6) // 淺藍色網區
          ..style = PaintingStyle.fill;

    final linesColor =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    // 繪製粉色邊框
    final borderRect = Rect.fromLTWH(0, 0, width, height);
    canvas.drawRect(borderRect, borderColor);

    // 繪製綠色場地
    final courtWidth = width * 0.9;
    final courtHeight = height * 0.85;
    final courtX = (width - courtWidth) / 2;
    final courtY = (height - courtHeight) / 2;
    final courtRect = Rect.fromLTWH(courtX, courtY, courtWidth, courtHeight);
    canvas.drawRect(courtRect, courtColor);

    // 繪製藍色網區
    final netWidth = width * 0.1;
    final netX = (width - netWidth) / 2;
    final netRect = Rect.fromLTWH(netX, courtY, netWidth, courtHeight);
    canvas.drawRect(netRect, netColor);

    // 繪製網線
    final netLineStart = Offset(width / 2, courtY);
    final netLineEnd = Offset(width / 2, courtY + courtHeight);
    canvas.drawLine(netLineStart, netLineEnd, linesColor);

    // 繪製場地分隔線
    _drawDividerLine(
      canvas,
      courtX + courtWidth * 0.25,
      courtY,
      courtY + courtHeight,
      linesColor,
    );

    _drawDividerLine(
      canvas,
      courtX + courtWidth * 0.75,
      courtY,
      courtY + courtHeight,
      linesColor,
    );
  }

  /// 繪製場地分隔線的輔助方法
  void _drawDividerLine(
    Canvas canvas,
    double x,
    double startY,
    double endY,
    Paint paint,
  ) {
    final start = Offset(x, startY);
    final end = Offset(x, endY);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
