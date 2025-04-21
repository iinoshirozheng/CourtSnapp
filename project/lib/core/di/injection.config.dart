// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/presentation/bloc/login_bloc.dart' as _i469;
import '../../features/auth/presentation/viewmodels/welcome_viewmodel.dart'
    as _i598;
import '../navigation/app_router.dart' as _i630;
import '../presentation/bloc/theme/theme_bloc.dart' as _i0;
import '../presentation/viewmodels/app_view_model_factory.dart' as _i59;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i0.ThemeBloc>(() => _i0.ThemeBloc());
    gh.factory<_i598.WelcomeViewModel>(() => _i598.WelcomeViewModel());
    gh.factory<_i469.LoginBloc>(() => _i469.LoginBloc());
    gh.singleton<_i630.AppRouter>(() => _i630.AppRouter());
    gh.singleton<_i59.AppViewModelFactory>(() => _i59.AppViewModelFactory());
    return this;
  }
}
