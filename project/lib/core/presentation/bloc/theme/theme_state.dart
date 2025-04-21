part of 'theme_bloc.dart';

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.light() = ThemeLight;
  const factory ThemeState.dark() = ThemeDark;
}
