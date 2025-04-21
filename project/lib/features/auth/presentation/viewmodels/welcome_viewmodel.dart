import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project/core/presentation/bloc/theme/theme_bloc.dart';
import 'package:project/core/presentation/viewmodels/base_view_model.dart';

@injectable
class WelcomeViewModel implements BaseViewModel {
  late BuildContext _context;
  bool _isButtonPressed = false;
  bool _isPageReady = false;
  late final Widget _loginPage;

  bool get isButtonPressed => _isButtonPressed;
  bool get isPageReady => _isPageReady;
  Widget get loginPage => _loginPage;

  @override
  void initialize(BuildContext context) {
    _context = context;
  }

  @override
  void dispose() {
    // Clean up any resources if needed
  }

  void toggleTheme() {
    _context.read<ThemeBloc>().add(const ThemeEvent.toggled());
  }

  void setButtonPressed(bool value) {
    _isButtonPressed = value;
  }

  void setPageReady(bool value) {
    _isPageReady = value;
  }

  void setLoginPage(Widget page) {
    _loginPage = page;
  }

  Future<void> navigateToLogin(
    BuildContext context,
    Function(Widget) routeBuilder,
  ) async {
    if (_isPageReady) {
      await Navigator.of(context).push(routeBuilder(_loginPage));
      return;
    }
  }
}
