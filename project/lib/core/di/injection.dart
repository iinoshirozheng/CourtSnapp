import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:project/core/di/injection_container.dart' as di;

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
}
