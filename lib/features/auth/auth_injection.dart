import 'package:anemia_hemeglobin_app/features/auth/data/repositories/auth_repository.dart';
import 'package:anemia_hemeglobin_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupAuthDependencies() {
  getIt.registerSingleton<AuthRepository>(AuthRepository());
  getIt.registerFactory(() => AuthCubit(getIt<AuthRepository>()));
}