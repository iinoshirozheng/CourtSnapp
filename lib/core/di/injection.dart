import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:project/core/constants/app_config.dart';
import 'package:project/core/di/injection_container.dart' as di;
import 'package:project/features/auth/data/datasources/auth_remote_data_source.dart';

import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  getIt.init();
  await di.init(); // Initialize our manual dependencies

  // Fallback to mock auth when Supabase config is not provided
  if (!AppConfig.hasSupabaseConfig) {
    getIt
      ..unregister<AuthRemoteDataSource>()
      ..registerLazySingleton<AuthRemoteDataSource>(
        AuthRemoteDataSourceMock.new,
      );
  }
}
