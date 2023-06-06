import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:qrapp/locator.config.dart';

final locator = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => init(locator);
