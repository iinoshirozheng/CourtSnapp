import 'package:flutter/material.dart';

/// Base interface for all view models in the MVVM architecture
abstract class BaseViewModel {
  /// Initialize the view model with a context
  void initialize(BuildContext context);

  /// Cleanup resources when the view model is no longer needed
  void dispose();
}
