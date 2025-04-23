import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeToggled extends ThemeEvent {}

class ThemeInitialized extends ThemeEvent {}

// Theme States
abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeLight extends ThemeState {}

class ThemeDark extends ThemeState {}

// Theme Bloc
@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themePreferenceKey = 'theme_preference';

  ThemeBloc() : super(ThemeLight()) {
    on<ThemeToggled>(_onThemeToggled);
    on<ThemeInitialized>(_onThemeInitialized);

    // Initialize theme
    add(ThemeInitialized());
  }

  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (state is ThemeLight) {
      emit(ThemeDark());
      await prefs.setBool(_themePreferenceKey, true);
    } else {
      emit(ThemeLight());
      await prefs.setBool(_themePreferenceKey, false);
    }
  }

  Future<void> _onThemeInitialized(
    ThemeInitialized event,
    Emitter<ThemeState> emit,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool(_themePreferenceKey) ?? false;

    if (isDark) {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }
}
