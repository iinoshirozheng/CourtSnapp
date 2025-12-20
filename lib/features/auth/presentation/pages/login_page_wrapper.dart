import 'package:flutter/material.dart';
import 'package:project/features/auth/presentation/pages/login_page.dart';

class LoginPageWrapper extends StatelessWidget {
  final VoidCallback toggleTheme;

  const LoginPageWrapper({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return LoginPage(toggleTheme: toggleTheme);
  }
}
