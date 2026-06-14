import 'package:get_it/get_it.dart';
import 'package:banksatu_mobile/core/config/app_config.dart';
import 'package:banksatu_mobile/core/network/api_client.dart';
import 'package:banksatu_mobile/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:banksatu_mobile/data/repositories/transaction_repository_impl.dart';
import 'package:banksatu_mobile/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:banksatu_mobile/features/security/bloc/security_bloc.dart';
import 'package:banksatu_mobile/features/subscriptions/bloc/subscription_bloc.dart';
import 'package:banksatu_mobile/features/syariah/bloc/syariah_bloc.dart';
import 'package:banksatu_mobile/features/future_rails/bloc/future_rails_bloc.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Network
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(baseUrl: AppConfig.instance.apiBaseUrl),
  );

  // Data sources
  sl.registerLazySingleton<TransactionRemoteDatasource>(
    () => TransactionRemoteDatasourceImpl(),
  );

  // Repositories
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl()),
  );

  // BLoCs — factory karena BLoC harus instance baru per usage
  sl.registerFactory<DashboardBloc>(() => DashboardBloc(repository: sl()));
  sl.registerFactory<SecurityBloc>(() => SecurityBloc());
  sl.registerFactory<SubscriptionBloc>(() => SubscriptionBloc());
  sl.registerFactory<SyariahBloc>(() => SyariahBloc());
  sl.registerFactory<FutureRailsBloc>(() => FutureRailsBloc());
}
