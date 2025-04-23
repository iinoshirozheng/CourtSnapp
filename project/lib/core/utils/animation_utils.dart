import 'package:flutter/material.dart';

/// Utility class for animation-related functions and constants
class AnimationUtils {
  /// Creates a shake animation controller and animation
  ///
  /// @param vsync The TickerProvider to use for the animation
  /// @return A tuple containing the AnimationController and Animation
  static ShakeAnimationData createShakeAnimation(TickerProvider vsync) {
    final controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: vsync,
    );

    final animation = Tween<Offset>(
        begin: const Offset(0, 0),
        end: const Offset(0.05, 0),
      ).chain(CurveTween(curve: Curves.elasticIn)).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
      });

    return ShakeAnimationData(controller, animation);
  }

  // Private constructor to prevent instantiation
  const AnimationUtils._();
}

/// Data class containing shake animation controller and animation
class ShakeAnimationData {
  /// The AnimationController for the shake effect
  final AnimationController controller;

  /// The resulting Animation<Offset> for the shake effect
  final Animation<Offset> animation;

  /// Constructor
  ShakeAnimationData(this.controller, this.animation);
}
