import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simulator/core/di/service_locator.dart';
import 'package:simulator/core/router/app_router.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:simulator/features/security/bloc/security_bloc.dart';
import 'package:simulator/features/subscriptions/bloc/subscription_bloc.dart';
import 'package:simulator/features/syariah/bloc/syariah_bloc.dart';
import 'package:simulator/features/future_rails/bloc/future_rails_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (_) => sl<DashboardBloc>()..add(LoadDashboard()),
        ),
        BlocProvider<SecurityBloc>(
          create: (_) => sl<SecurityBloc>()..add(LoadSecurity()),
        ),
        BlocProvider<SubscriptionBloc>(
          create: (_) => sl<SubscriptionBloc>()..add(LoadSubscriptions()),
        ),
        BlocProvider<SyariahBloc>(
          create: (_) => sl<SyariahBloc>()..add(LoadSyariah()),
        ),
        BlocProvider<FutureRailsBloc>(
          create: (_) => sl<FutureRailsBloc>()..add(LoadFutureRails()),
        ),
      ],
      child: MaterialApp.router(
        title: 'BankSatu',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
