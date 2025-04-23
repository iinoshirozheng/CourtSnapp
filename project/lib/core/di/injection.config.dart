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

import '../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i107;
import '../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i153;
import '../../features/auth/domain/repositories/auth_repository.dart' as _i787;
import '../../features/auth/domain/usecases/sign_in_with_email_password_usecase.dart'
    as _i623;
import '../../features/auth/presentation/bloc/auth/auth_bloc.dart' as _i469;
import '../../features/auth/presentation/bloc/login/login_bloc.dart' as _i208;
import '../../features/auth/presentation/viewmodels/welcome_viewmodel.dart'
    as _i598;
import '../../shared/bloc/theme/theme_bloc.dart' as _i203;
import '../../shared/viewmodels/app_view_model_factory.dart' as _i303;
import '../navigation/app_router.dart' as _i630;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i598.WelcomeViewModel>(() => _i598.WelcomeViewModel());
    gh.factory<_i203.ThemeBloc>(() => _i203.ThemeBloc());
    gh.singleton<_i630.AppRouter>(() => _i630.AppRouter());
    gh.singleton<_i303.AppViewModelFactory>(() => _i303.AppViewModelFactory());
    gh.factory<_i107.AuthRemoteDataSource>(
      () => _i107.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i787.AuthRepository>(
      () => _i153.AuthRepositoryImpl(
        remoteDataSource: gh<_i107.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i623.SignInWithEmailPasswordUseCase>(
      () => _i623.SignInWithEmailPasswordUseCase(gh<_i787.AuthRepository>()),
    );
    gh.factory<_i469.AuthBloc>(
      () => _i469.AuthBloc(
        signInWithEmailPassword: gh<_i623.SignInWithEmailPasswordUseCase>(),
      ),
    );
    gh.factory<_i208.LoginBloc>(
      () => _i208.LoginBloc(authBloc: gh<_i469.AuthBloc>()),
    );
    return this;
  }
}
