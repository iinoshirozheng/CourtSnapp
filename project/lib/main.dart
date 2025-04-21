import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/core/navigation/app_router.dart';
import 'package:project/core/presentation/bloc/theme/theme_bloc.dart';
import 'package:project/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ThemeBloc>(create: (_) => getIt<ThemeBloc>())],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final themeMode =
              themeState is ThemeLight ? ThemeMode.light : ThemeMode.dark;

          return MaterialApp.router(
            title: 'Court Snapp',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            routerConfig: getIt<AppRouter>().router,
          );
        },
      ),
    );
  }
}
