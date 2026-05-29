// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $appShellRouteData,
  $onboardingRoute,
  $oAuthLoginRoute,
  $kYCIdentityRoute,
  $kYCFaceRoute,
  $kYCSuccessRoute,
  $profileRoute,
  $transferRoute,
  $payBillsRoute,
  $pLNDetailRoute,
  $qRISScanRoute,
  $billSplitRoute,
  $scheduledTransferRoute,
  $investRoute,
  $portfolioRoute,
  $timeDepositRoute,
  $sharedVaultRoute,
  $roundUpRoute,
  $roundUpInstrumentsRoute,
  $aIAssistantRoute,
  $aIAssistantSearchRoute,
  $aIFinancialInsightsRoute,
  $transactionIntelligenceRoute,
  $notificationIntelligenceRoute,
  $widgetQuickActionsRoute,
];

RouteBase get $appShellRouteData => StatefulShellRouteData.$route(
  factory: $AppShellRouteDataExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/',
          factory: $DashboardRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'transaction/:id',
              factory: $TransactionDetailRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/security',
          factory: $SecurityRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/subscriptions',
          factory: $SubscriptionRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/syariah', factory: $SyariahRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/future-rails',
          factory: $FutureRailsRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $AppShellRouteDataExtension on AppShellRouteData {
  static AppShellRouteData _fromState(GoRouterState state) =>
      const AppShellRouteData();
}

mixin $DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $TransactionDetailRoute on GoRouteData {
  static TransactionDetailRoute _fromState(GoRouterState state) =>
      TransactionDetailRoute(id: state.pathParameters['id']!);

  TransactionDetailRoute get _self => this as TransactionDetailRoute;

  @override
  String get location =>
      GoRouteData.$location('/transaction/${Uri.encodeComponent(_self.id)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SecurityRoute on GoRouteData {
  static SecurityRoute _fromState(GoRouterState state) => const SecurityRoute();

  @override
  String get location => GoRouteData.$location('/security');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SubscriptionRoute on GoRouteData {
  static SubscriptionRoute _fromState(GoRouterState state) =>
      const SubscriptionRoute();

  @override
  String get location => GoRouteData.$location('/subscriptions');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $SyariahRoute on GoRouteData {
  static SyariahRoute _fromState(GoRouterState state) => const SyariahRoute();

  @override
  String get location => GoRouteData.$location('/syariah');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $FutureRailsRoute on GoRouteData {
  static FutureRailsRoute _fromState(GoRouterState state) =>
      const FutureRailsRoute();

  @override
  String get location => GoRouteData.$location('/future-rails');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onboardingRoute => GoRouteData.$route(
  path: '/onboarding',
  factory: $OnboardingRoute._fromState,
);

mixin $OnboardingRoute on GoRouteData {
  static OnboardingRoute _fromState(GoRouterState state) =>
      const OnboardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $oAuthLoginRoute =>
    GoRouteData.$route(path: '/login', factory: $OAuthLoginRoute._fromState);

mixin $OAuthLoginRoute on GoRouteData {
  static OAuthLoginRoute _fromState(GoRouterState state) =>
      const OAuthLoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $kYCIdentityRoute => GoRouteData.$route(
  path: '/kyc/identity',
  factory: $KYCIdentityRoute._fromState,
);

mixin $KYCIdentityRoute on GoRouteData {
  static KYCIdentityRoute _fromState(GoRouterState state) =>
      const KYCIdentityRoute();

  @override
  String get location => GoRouteData.$location('/kyc/identity');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $kYCFaceRoute =>
    GoRouteData.$route(path: '/kyc/face', factory: $KYCFaceRoute._fromState);

mixin $KYCFaceRoute on GoRouteData {
  static KYCFaceRoute _fromState(GoRouterState state) => const KYCFaceRoute();

  @override
  String get location => GoRouteData.$location('/kyc/face');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $kYCSuccessRoute => GoRouteData.$route(
  path: '/kyc/success',
  factory: $KYCSuccessRoute._fromState,
);

mixin $KYCSuccessRoute on GoRouteData {
  static KYCSuccessRoute _fromState(GoRouterState state) =>
      const KYCSuccessRoute();

  @override
  String get location => GoRouteData.$location('/kyc/success');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $profileRoute =>
    GoRouteData.$route(path: '/profile', factory: $ProfileRoute._fromState);

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $transferRoute => GoRouteData.$route(
  path: '/transactions/transfer',
  factory: $TransferRoute._fromState,
);

mixin $TransferRoute on GoRouteData {
  static TransferRoute _fromState(GoRouterState state) => const TransferRoute();

  @override
  String get location => GoRouteData.$location('/transactions/transfer');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $payBillsRoute => GoRouteData.$route(
  path: '/transactions/pay-bills',
  factory: $PayBillsRoute._fromState,
);

mixin $PayBillsRoute on GoRouteData {
  static PayBillsRoute _fromState(GoRouterState state) => const PayBillsRoute();

  @override
  String get location => GoRouteData.$location('/transactions/pay-bills');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pLNDetailRoute => GoRouteData.$route(
  path: '/transactions/pln-detail',
  factory: $PLNDetailRoute._fromState,
);

mixin $PLNDetailRoute on GoRouteData {
  static PLNDetailRoute _fromState(GoRouterState state) =>
      const PLNDetailRoute();

  @override
  String get location => GoRouteData.$location('/transactions/pln-detail');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qRISScanRoute => GoRouteData.$route(
  path: '/transactions/qris-scan',
  factory: $QRISScanRoute._fromState,
);

mixin $QRISScanRoute on GoRouteData {
  static QRISScanRoute _fromState(GoRouterState state) => const QRISScanRoute();

  @override
  String get location => GoRouteData.$location('/transactions/qris-scan');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $billSplitRoute => GoRouteData.$route(
  path: '/transactions/bill-split',
  factory: $BillSplitRoute._fromState,
);

mixin $BillSplitRoute on GoRouteData {
  static BillSplitRoute _fromState(GoRouterState state) =>
      const BillSplitRoute();

  @override
  String get location => GoRouteData.$location('/transactions/bill-split');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $scheduledTransferRoute => GoRouteData.$route(
  path: '/transactions/scheduled',
  factory: $ScheduledTransferRoute._fromState,
);

mixin $ScheduledTransferRoute on GoRouteData {
  static ScheduledTransferRoute _fromState(GoRouterState state) =>
      const ScheduledTransferRoute();

  @override
  String get location => GoRouteData.$location('/transactions/scheduled');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $investRoute => GoRouteData.$route(
  path: '/wealth/invest',
  factory: $InvestRoute._fromState,
);

mixin $InvestRoute on GoRouteData {
  static InvestRoute _fromState(GoRouterState state) => const InvestRoute();

  @override
  String get location => GoRouteData.$location('/wealth/invest');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $portfolioRoute => GoRouteData.$route(
  path: '/wealth/portfolio',
  factory: $PortfolioRoute._fromState,
);

mixin $PortfolioRoute on GoRouteData {
  static PortfolioRoute _fromState(GoRouterState state) =>
      const PortfolioRoute();

  @override
  String get location => GoRouteData.$location('/wealth/portfolio');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $timeDepositRoute => GoRouteData.$route(
  path: '/wealth/savings/time-deposit',
  factory: $TimeDepositRoute._fromState,
);

mixin $TimeDepositRoute on GoRouteData {
  static TimeDepositRoute _fromState(GoRouterState state) =>
      const TimeDepositRoute();

  @override
  String get location => GoRouteData.$location('/wealth/savings/time-deposit');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $sharedVaultRoute => GoRouteData.$route(
  path: '/wealth/savings/shared-vault',
  factory: $SharedVaultRoute._fromState,
);

mixin $SharedVaultRoute on GoRouteData {
  static SharedVaultRoute _fromState(GoRouterState state) =>
      const SharedVaultRoute();

  @override
  String get location => GoRouteData.$location('/wealth/savings/shared-vault');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $roundUpRoute => GoRouteData.$route(
  path: '/wealth/roundup',
  factory: $RoundUpRoute._fromState,
);

mixin $RoundUpRoute on GoRouteData {
  static RoundUpRoute _fromState(GoRouterState state) => const RoundUpRoute();

  @override
  String get location => GoRouteData.$location('/wealth/roundup');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $roundUpInstrumentsRoute => GoRouteData.$route(
  path: '/wealth/roundup/instruments',
  factory: $RoundUpInstrumentsRoute._fromState,
);

mixin $RoundUpInstrumentsRoute on GoRouteData {
  static RoundUpInstrumentsRoute _fromState(GoRouterState state) =>
      const RoundUpInstrumentsRoute();

  @override
  String get location => GoRouteData.$location('/wealth/roundup/instruments');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $aIAssistantRoute => GoRouteData.$route(
  path: '/analytics/chat',
  factory: $AIAssistantRoute._fromState,
);

mixin $AIAssistantRoute on GoRouteData {
  static AIAssistantRoute _fromState(GoRouterState state) =>
      const AIAssistantRoute();

  @override
  String get location => GoRouteData.$location('/analytics/chat');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $aIAssistantSearchRoute => GoRouteData.$route(
  path: '/analytics/search',
  factory: $AIAssistantSearchRoute._fromState,
);

mixin $AIAssistantSearchRoute on GoRouteData {
  static AIAssistantSearchRoute _fromState(GoRouterState state) =>
      const AIAssistantSearchRoute();

  @override
  String get location => GoRouteData.$location('/analytics/search');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $aIFinancialInsightsRoute => GoRouteData.$route(
  path: '/analytics/insights',
  factory: $AIFinancialInsightsRoute._fromState,
);

mixin $AIFinancialInsightsRoute on GoRouteData {
  static AIFinancialInsightsRoute _fromState(GoRouterState state) =>
      const AIFinancialInsightsRoute();

  @override
  String get location => GoRouteData.$location('/analytics/insights');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $transactionIntelligenceRoute => GoRouteData.$route(
  path: '/analytics/intelligence',
  factory: $TransactionIntelligenceRoute._fromState,
);

mixin $TransactionIntelligenceRoute on GoRouteData {
  static TransactionIntelligenceRoute _fromState(GoRouterState state) =>
      const TransactionIntelligenceRoute();

  @override
  String get location => GoRouteData.$location('/analytics/intelligence');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $notificationIntelligenceRoute => GoRouteData.$route(
  path: '/analytics/notification',
  factory: $NotificationIntelligenceRoute._fromState,
);

mixin $NotificationIntelligenceRoute on GoRouteData {
  static NotificationIntelligenceRoute _fromState(GoRouterState state) =>
      const NotificationIntelligenceRoute();

  @override
  String get location => GoRouteData.$location('/analytics/notification');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $widgetQuickActionsRoute => GoRouteData.$route(
  path: '/analytics/widgets',
  factory: $WidgetQuickActionsRoute._fromState,
);

mixin $WidgetQuickActionsRoute on GoRouteData {
  static WidgetQuickActionsRoute _fromState(GoRouterState state) =>
      const WidgetQuickActionsRoute();

  @override
  String get location => GoRouteData.$location('/analytics/widgets');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
