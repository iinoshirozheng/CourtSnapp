import 'package:flutter/material.dart';

/// 為圖標添加複合動畫效果的組件
///
/// 包含上下漂浮、輕微旋轉和縮放脈動效果
class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({
    super.key,
    required this.child,
    this.floatAmplitude = 6.0,
    this.floatPeriod = 1.5,
    this.rotationAmplitude = 0.012,
    this.pulseAmplitude = 0.025,
    this.pulsePeriod = 2.0,
  });

  final Widget child;
  final double floatAmplitude; // 上下漂浮幅度
  final double floatPeriod; // 漂浮週期（秒）
  final double rotationAmplitude; // 旋轉幅度（弧度）
  final double pulseAmplitude; // 縮放幅度
  final double pulsePeriod; // 縮放週期（秒）

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _pulseController;
  late final AnimationController _rotateController;

  late final Animation<double> _floatAnimation;
  late final Animation<double> _pulseAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    // 漂浮動畫
    _floatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.floatPeriod * 1000).toInt()),
    );

    _floatAnimation = Tween<double>(
      begin: -widget.floatAmplitude,
      end: widget.floatAmplitude,
    ).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // 脈動/縮放動畫
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.pulsePeriod * 1000).toInt()),
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0 - widget.pulseAmplitude,
      end: 1.0 + widget.pulseAmplitude,
    ).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // 旋轉動畫
    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    _rotateAnimation = Tween<double>(
      begin: -widget.rotationAmplitude,
      end: widget.rotationAmplitude,
    ).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    // 啟動所有動畫，設置不同相位
    _floatController.repeat(reverse: true);

    // 延遲啟動脈動，創建不同步效果
    Future.delayed(const Duration(milliseconds: 400), () {
      _pulseController.repeat(reverse: true);
    });

    _rotateController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _floatAnimation,
        _pulseAnimation,
        _rotateAnimation,
      ]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: Transform.scale(scale: _pulseAnimation.value, child: child),
          ),
        );
      },
      child: widget.child,
    );
  }
}
