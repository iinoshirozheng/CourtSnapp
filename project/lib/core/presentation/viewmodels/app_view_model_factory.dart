import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/core/presentation/viewmodels/base_view_model.dart';

/// Factory for creating and managing view models
@singleton
class AppViewModelFactory {
  /// Map to store and reuse view models
  final Map<Type, BaseViewModel> _viewModels = {};

  /// Get or create a view model of type T
  T getViewModel<T extends BaseViewModel>(BuildContext context) {
    // Return cached view model if it exists
    if (_viewModels.containsKey(T)) {
      return _viewModels[T] as T;
    }

    // Create new view model if it doesn't exist
    final viewModel = getIt<T>();
    viewModel.initialize(context);
    _viewModels[T] = viewModel;

    return viewModel;
  }

  /// Remove a view model from the cache and dispose it
  void disposeViewModel<T extends BaseViewModel>() {
    if (_viewModels.containsKey(T)) {
      _viewModels[T]?.dispose();
      _viewModels.remove(T);
    }
  }

  /// Clear all view models
  void disposeAll() {
    for (final viewModel in _viewModels.values) {
      viewModel.dispose();
    }
    _viewModels.clear();
  }
}
