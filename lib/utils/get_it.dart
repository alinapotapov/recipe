import 'package:get_it/get_it.dart';
import 'package:recipe_app/data/services/auth_service.dart';

final getIt = GetIt.instance;

void setup() {
  GetIt.I.registerLazySingleton<AuthService>(() => AuthService());
}
