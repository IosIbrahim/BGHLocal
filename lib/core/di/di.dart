import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/data/auth_api.dart';
import '../../feature/auth/data/repository/auth_repository_impl.dart';
import '../../feature/auth/domain/repository/auth_repository.dart';
import '../../feature/auth/domain/usecase/login_usecase.dart';
import '../../feature/auth/presentation/cubit/login_cubit.dart';
import '../network/network.dart';
import '../network/network.dart';
import '../storage/storage.dart';
import '../storage/secure_token_storage.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // Shared Preferences
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // App Preferences
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  // Secure Token Storage
  instance.registerLazySingleton<SecureTokenStorage>(() => SecureTokenStorage());

  // Network Info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // Dio Factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance(), instance()));

  // Dio instance
  final dio = await instance<DioFactory>().getDio();

  // Auth API
  instance.registerLazySingleton<AuthApi>(() => AuthApi(dio));

  // Repository
  instance.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      instance(),
      instance(),
      instance(),
      instance(),
    ),
  );

  // Use Cases
  instance.registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));

  // Cubits / Blocs
  instance.registerFactory<LoginCubit>(() => LoginCubit(instance()));
}
