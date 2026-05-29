import 'package:get_it/get_it.dart';
import 'package:simulator/core/network/api_client.dart';
import 'package:simulator/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:simulator/features/security/bloc/security_bloc.dart';
import 'package:simulator/features/subscriptions/bloc/subscription_bloc.dart';
import 'package:simulator/features/syariah/bloc/syariah_bloc.dart';
import 'package:simulator/features/future_rails/bloc/future_rails_bloc.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Network
  sl.registerLazySingleton<ApiClient>(() => ApiClient());

  // BLoCs — factory karena BLoC harus instance baru per usage
  sl.registerFactory<DashboardBloc>(() => DashboardBloc());
  sl.registerFactory<SecurityBloc>(() => SecurityBloc());
  sl.registerFactory<SubscriptionBloc>(() => SubscriptionBloc());
  sl.registerFactory<SyariahBloc>(() => SyariahBloc());
  sl.registerFactory<FutureRailsBloc>(() => FutureRailsBloc());
}
