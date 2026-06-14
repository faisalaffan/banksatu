import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:banksatu_mobile/core/config/app_config.dart';
import 'package:banksatu_mobile/core/di/service_locator.dart';
import 'package:banksatu_mobile/core/router/app_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';
import 'package:banksatu_mobile/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:banksatu_mobile/features/security/bloc/security_bloc.dart';
import 'package:banksatu_mobile/features/subscriptions/bloc/subscription_bloc.dart';
import 'package:banksatu_mobile/features/syariah/bloc/syariah_bloc.dart';
import 'package:banksatu_mobile/features/future_rails/bloc/future_rails_bloc.dart';
import 'package:banksatu_mobile/core/widgets/sandbox_banner.dart';
import 'package:banksatu_mobile/features/auth/presentation/session_timeout_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init config — override via --dart-define di build command
  AppConfig.init(AppConfig.development());

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
        builder: (context, child) {
          final originalPadding = MediaQuery.of(context).padding;
          return SessionTimeoutManager(
            child: Container(
              color:
                  Colors.white, // Prevents blackouts behind system status bar
              child: Column(
                children: [
                  const SafeArea(bottom: false, child: SandboxBanner()),
                  Expanded(
                    child: MediaQuery(
                      data: MediaQuery.of(
                        context,
                      ).copyWith(padding: originalPadding.copyWith(top: 0)),
                      child: child!,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
