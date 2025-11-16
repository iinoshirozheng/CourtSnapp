import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/core/constants/app_config.dart';
import 'package:project/core/di/injection.dart';
import 'package:project/core/navigation/app_router.dart';
import 'package:project/shared/bloc/theme/theme_bloc.dart';
import 'package:project/core/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase only when config is provided (skip for local UI dev)
  if (AppConfig.hasSupabaseConfig) {
    await Supabase.initialize(
      url: AppConfig.supabaseUrl,
      anonKey: AppConfig.supabaseAnonKey,
    );
  }

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
            builder: (context, child) {
              return ResponsiveBuilder(
                breakpoints: const ScreenBreakpoints(
                  watch: 450,
                  tablet: 800,
                  desktop: 1200,
                ),
                builder: (context, sizingInformation) =>
                    child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
