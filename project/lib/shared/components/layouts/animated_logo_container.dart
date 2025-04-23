import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedLogoContainer extends StatefulWidget {
  final Widget child;
  final double floatAmplitude;
  final double floatPeriod;
  final double rotationAmplitude;
  final double pulseAmplitude;
  final double pulsePeriod;

  const AnimatedLogoContainer({
    super.key,
    required this.child,
    this.floatAmplitude = 8.0,
    this.floatPeriod = 2.5,
    this.rotationAmplitude = 0.02,
    this.pulseAmplitude = 0.02,
    this.pulsePeriod = 3.0,
  });

  @override
  State<AnimatedLogoContainer> createState() => _AnimatedLogoContainerState();
}

class _AnimatedLogoContainerState extends State<AnimatedLogoContainer>
    with TickerProviderStateMixin {
  late final AnimationController _floatController;
  late final AnimationController _rotationController;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    // Float animation (vertical movement)
    _floatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.floatPeriod * 1000).toInt()),
    )..repeat(reverse: true);

    // Rotation animation (slight tilting)
    _rotationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: ((widget.floatPeriod * 1.3) * 1000).toInt(),
      ),
    )..repeat(reverse: true);

    // Pulse animation (scaling)
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.pulsePeriod * 1000).toInt()),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _floatController,
        _rotationController,
        _pulseController,
      ]),
      builder: (context, child) {
        // Calculate current animated values
        final floatValue =
            sin(_floatController.value * 3.14159) * widget.floatAmplitude;
        final rotationValue =
            sin(_rotationController.value * 3.14159) * widget.rotationAmplitude;
        final pulseValue =
            1.0 + sin(_pulseController.value * 3.14159) * widget.pulseAmplitude;

        return Transform.translate(
          offset: Offset(0, floatValue),
          child: Transform.rotate(
            angle: rotationValue,
            child: Transform.scale(scale: pulseValue, child: widget.child),
          ),
        );
      },
    );
  }
}
