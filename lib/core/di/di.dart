import 'package:dr_baksh_dashboard/feature/operating/domain/usecase/get_operation_dashboard_usecase.dart';
import 'package:dr_baksh_dashboard/feature/outpatient/domain/usecase/get_outpatient_dashboard_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/data/auth_api.dart';
import '../../feature/home/data/home_api.dart';
import '../../feature/home/data/repository/home_repository_impl.dart';
import '../../feature/home/domain/repository/home_repository.dart';
import '../../feature/home/domain/usecase/get_er_patients_count_usecase.dart';
import '../../feature/home/domain/usecase/get_inpatients_count_usecase.dart';
import '../../feature/home/presentation/cubit/home_counts_cubit.dart';
import '../../feature/auth/data/repository/auth_repository_impl.dart';
import '../../feature/auth/domain/repository/auth_repository.dart';
import '../../feature/auth/domain/usecase/login_usecase.dart';
import '../../feature/auth/presentation/cubit/login_cubit.dart';
import '../../feature/filter/data/filter_api.dart';
import '../../feature/filter/data/repository/filter_repository_impl.dart';
import '../../feature/filter/domain/repository/filter_repository.dart';
import '../../feature/filter/domain/usecase/get_main_data_usecase.dart';
import '../../feature/filter/presentation/cubit/filter_cubit.dart';
import '../../feature/home/presentation/cubit/bottom_nav_cubit.dart';
import '../../feature/inpatient_statistics/data/inpatient_api.dart';
import '../../feature/inpatient_statistics/data/repository/inpatient_repository_impl.dart';
import '../../feature/inpatient_statistics/domain/repository/inpatient_repository.dart';
import '../../feature/inpatient_statistics/domain/usecase/get_bed_count_usecase.dart';
import '../../feature/inpatient_statistics/domain/usecase/get_current_bed_status_usecase.dart';
import '../../feature/inpatient_statistics/domain/usecase/get_kpi_value_usecase.dart';
import '../../feature/inpatient_statistics/domain/usecase/get_units_occupancy_usecase.dart';
import '../../feature/inpatient_statistics/presentation/bloc/inpatient_bloc.dart';
import '../../feature/emergency/data/emergency_api.dart';
import '../../feature/emergency/data/repository/emergency_repository_impl.dart';
import '../../feature/emergency/domain/repository/emergency_repository.dart';
import '../../feature/emergency/domain/usecase/get_emergency_nationality_usecase.dart';
import '../../feature/emergency/domain/usecase/get_emergency_overview_usecase.dart';
import '../../feature/emergency/domain/usecase/get_emergency_payment_types_usecase.dart';
import '../../feature/emergency/presentation/bloc/emergency_bloc.dart';
import '../../feature/hr/data/hr_api.dart';
import '../../feature/hr/data/repository/hr_repository_impl.dart';
import '../../feature/hr/domain/repository/hr_repository.dart';
import '../../feature/hr/domain/usecase/get_hr_kpi_usecase.dart';
import '../../feature/hr/presentation/bloc/hr_bloc.dart';
import '../../feature/operating/data/operationApi/operating_api.dart';
import '../../feature/operating/data/repository/operating_repository_impl.dart';
import '../../feature/operating/domain/repository/operating_repository.dart';
import '../../feature/operating/presentation/bloc/operating_bloc.dart';
import '../../feature/outpatient/data/outPatientApi/outpatient_api.dart';
import '../../feature/outpatient/data/repository/outpatient_repository_impl.dart';
import '../../feature/outpatient/domain/repository/outpatient_repository.dart';
import '../../feature/outpatient/presentation/bloc/outpatient_bloc.dart';
import '../../feature/revenue/data/revenue_api.dart';
import '../../feature/revenue/data/repository/revenue_repository_impl.dart';
import '../../feature/revenue/domain/repository/revenue_repository.dart';
import '../../feature/revenue/domain/usecase/get_revenue_kpi_usecase.dart';
import '../../feature/revenue/presentation/bloc/revenue_bloc.dart';
import '../dashboard/dashboard_filter_store.dart';
import '../network/network.dart';
import '../storage/storage.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  // Shared Preferences
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // Secure Token Storage
  instance
      .registerLazySingleton<SecureTokenStorage>(() => SecureTokenStorage());

  // App Preferences
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(instance(), instance()));

  // Network Info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // Dio Factory
  instance.registerLazySingleton<DioFactory>(
      () => DioFactory(instance(), instance()));

  // Dio instance
  final dio = await instance<DioFactory>().getDio();

  // Auth API
  instance.registerLazySingleton<AuthApi>(() => AuthApi(dio));

  // Auth repository + use-case
  instance.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(instance(), instance(), instance()),
  );
  instance.registerLazySingleton<LoginUseCase>(() => LoginUseCase(instance()));

  // Auth / home cubits
  instance.registerFactory<LoginCubit>(() => LoginCubit(instance()));
  instance.registerFactory<BottomNavCubit>(() => BottomNavCubit());

  // ─── Home counts ────────────────────────────────────────────────────────────
  instance.registerLazySingleton<HomeApi>(() => HomeApi(dio));
  instance.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<GetErPatientsCountUseCase>(
      () => GetErPatientsCountUseCase(instance()));
  instance.registerLazySingleton<GetInPatientsCountUseCase>(
      () => GetInPatientsCountUseCase(instance()));
  // Pulls HR/Revenue's own use cases so the home cards show the same figures as
  // those dashboards' headline counters.
  instance.registerFactory<HomeCountsCubit>(
      () => HomeCountsCubit(instance(), instance(), instance(), instance()));

  // ─── Dashboard filter (shared across every dashboard) ───────────────────
  instance.registerLazySingleton<DashboardFilterStore>(
      () => DashboardFilterStore());
  instance.registerLazySingleton<FilterApi>(() => FilterApi(dio));
  instance.registerLazySingleton<FilterRepository>(
      () => FilterRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<GetMainDataUseCase>(
      () => GetMainDataUseCase(instance()));
  instance.registerFactory<FilterCubit>(
      () => FilterCubit(instance(), instance()));

  // ─── Emergency dashboard ────────────────────────────────────────────────
  instance.registerLazySingleton<EmergencyApi>(() => EmergencyApi(dio));
  instance.registerLazySingleton<EmergencyRepository>(
      () => EmergencyRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<GetEmergencyOverviewUseCase>(
      () => GetEmergencyOverviewUseCase(instance()));
  instance.registerLazySingleton<GetEmergencyPaymentTypesUseCase>(
      () => GetEmergencyPaymentTypesUseCase(instance()));
  instance.registerLazySingleton<GetEmergencyNationalityUseCase>(
      () => GetEmergencyNationalityUseCase(instance()));
  instance.registerFactory<EmergencyBloc>(
      () => EmergencyBloc(instance(), instance(), instance()));

  // ─── Outpatient dashboard ───────────────────────────────────────────────
  instance.registerLazySingleton<OutpatientApi>(() => OutpatientApi(dio));
  instance.registerLazySingleton<OutpatientRepository>(
      () => OutpatientRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<GetOutpatientDashboardUseCase>(
          () => GetOutpatientDashboardUseCase(instance()));

  instance.registerFactory<OutpatientBloc>(
      () => OutpatientBloc(instance()));

  // ─── HR dashboard ───────────────────────────────────────────────────────
  instance.registerLazySingleton<HrApi>(() => HrApi(dio));
  instance.registerLazySingleton<HrRepository>(
      () => HrRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<GetHrKpiUseCase>(
      () => GetHrKpiUseCase(instance()));
  instance.registerFactory<HrBloc>(() => HrBloc(instance()));

  // ─── Operating dashboard ────────────────────────────────────────────────
  instance.registerLazySingleton<OperatingApi>(() => OperatingApi(dio));
  instance.registerLazySingleton<OperatingRepository>(
      () => OperatingRepositoryImpl(instance(),instance()));
  instance.registerLazySingleton<GetOperationDashboardUseCase>(
          () => GetOperationDashboardUseCase(instance()));
  instance.registerFactory<OperatingBloc>(
      () => OperatingBloc(instance()));

  // ─── Revenue dashboard ──────────────────────────────────────────────────
  instance.registerLazySingleton<RevenueApi>(() => RevenueApi(dio));
  instance.registerLazySingleton<RevenueRepository>(
      () => RevenueRepositoryImpl(instance(), instance()));
  instance.registerLazySingleton<GetRevenueKpiUseCase>(
      () => GetRevenueKpiUseCase(instance()));
  instance.registerFactory<RevenueBloc>(() => RevenueBloc(instance()));

  // ─── Inpatient dashboard ────────────────────────────────────────────────
  instance.registerLazySingleton<InpatientApi>(() => InpatientApi(dio));
  instance.registerLazySingleton<InpatientRepository>(
    () => InpatientRepositoryImpl(instance(), instance()),
  );
  instance.registerLazySingleton<GetBedCountUseCase>(
      () => GetBedCountUseCase(instance()));
  instance.registerLazySingleton<GetCurrentBedStatusUseCase>(
      () => GetCurrentBedStatusUseCase(instance()));
  instance.registerLazySingleton<GetUnitsOccupancyUseCase>(
      () => GetUnitsOccupancyUseCase(instance()));
  instance.registerLazySingleton<GetKpiValueUseCase>(
      () => GetKpiValueUseCase(instance()));
  instance.registerFactory<InpatientBloc>(() => InpatientBloc(
        instance(),
        instance(),
        instance(),
        instance(),
      ));
}
