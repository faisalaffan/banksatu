import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/widgets/custom_bottom_nav.dart';
import 'package:simulator/features/dashboard/presentation/dashboard_screen.dart';
import 'package:simulator/features/dashboard/presentation/transaction_detail_screen.dart';
import 'package:simulator/features/security/presentation/security_screen.dart';
import 'package:simulator/features/subscriptions/presentation/subscription_screen.dart';
import 'package:simulator/features/syariah/presentation/syariah_screen.dart';
import 'package:simulator/features/future_rails/presentation/future_rails_screen.dart';

part 'app_router.g.dart';

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<DashboardBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DashboardRoute>(
          path: '/',
          routes: [
            TypedGoRoute<TransactionDetailRoute>(
              path: 'transaction/:id',
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<SecurityBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SecurityRoute>(path: '/security'),
      ],
    ),
    TypedStatefulShellBranch<SubscriptionBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SubscriptionRoute>(path: '/subscriptions'),
      ],
    ),
    TypedStatefulShellBranch<SyariahBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<SyariahRoute>(path: '/syariah'),
      ],
    ),
    TypedStatefulShellBranch<FutureRailsBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<FutureRailsRoute>(path: '/future-rails'),
      ],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return CustomBottomNav(navigationShell: navigationShell);
  }
}

// Shell Branches
class DashboardBranch extends StatefulShellBranchData {
  const DashboardBranch();
}

class SecurityBranch extends StatefulShellBranchData {
  const SecurityBranch();
}

class SubscriptionBranch extends StatefulShellBranchData {
  const SubscriptionBranch();
}

class SyariahBranch extends StatefulShellBranchData {
  const SyariahBranch();
}

class FutureRailsBranch extends StatefulShellBranchData {
  const FutureRailsBranch();
}

// Declarative Page Routes
class DashboardRoute extends GoRouteData with $DashboardRoute {
  const DashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DashboardScreen();
}

class TransactionDetailRoute extends GoRouteData with $TransactionDetailRoute {
  final String id;
  const TransactionDetailRoute({required this.id});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      TransactionDetailScreen(transactionId: id);
}

class SecurityRoute extends GoRouteData with $SecurityRoute {
  const SecurityRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SecurityScreen();
}

class SubscriptionRoute extends GoRouteData with $SubscriptionRoute {
  const SubscriptionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SubscriptionScreen();
}

class SyariahRoute extends GoRouteData with $SyariahRoute {
  const SyariahRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SyariahScreen();
}

class FutureRailsRoute extends GoRouteData with $FutureRailsRoute {
  const FutureRailsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FutureRailsScreen();
}

// Global router config instance
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: $appRoutes,
);
