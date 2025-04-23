import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:project/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:project/features/auth/presentation/pages/login_page.dart';

class LoginPageWrapper extends StatelessWidget {
  final VoidCallback toggleTheme;

  const LoginPageWrapper({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => getIt<AuthBloc>()),
        BlocProvider<LoginBloc>(create: (context) => getIt<LoginBloc>()),
      ],
      child: LoginPage(toggleTheme: toggleTheme),
    );
  }
}
