import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/widgets/custom_bottom_nav.dart';
import 'package:simulator/features/dashboard/presentation/dashboard_screen.dart';
import 'package:simulator/features/dashboard/presentation/transaction_detail_screen.dart';
import 'package:simulator/features/security/presentation/security_screen.dart';
import 'package:simulator/features/subscriptions/presentation/subscription_screen.dart';
import 'package:simulator/features/syariah/presentation/syariah_screen.dart';
import 'package:simulator/features/future_rails/presentation/future_rails_screen.dart';
import 'package:simulator/features/onboarding/presentation/onboarding_screen.dart';
import 'package:simulator/features/onboarding/presentation/kyc_identity_screen.dart';
import 'package:simulator/features/onboarding/presentation/kyc_face_screen.dart';
import 'package:simulator/features/onboarding/presentation/kyc_success_screen.dart';
import 'package:simulator/features/auth/presentation/oauth_login_screen.dart';
import 'package:simulator/features/auth/presentation/login_screen.dart';
import 'package:simulator/features/profile/presentation/profile_screen.dart';
import 'package:simulator/features/transactions/presentation/transfer_screen.dart';
import 'package:simulator/features/transactions/presentation/pay_bills_screen.dart';
import 'package:simulator/features/transactions/presentation/pln_detail_screen.dart';
import 'package:simulator/features/transactions/presentation/qris_scan_screen.dart';
import 'package:simulator/features/transactions/presentation/bill_split_screen.dart';
import 'package:simulator/features/transactions/presentation/scheduled_transfer_screen.dart';
import 'package:simulator/features/wealth/presentation/invest_screen.dart';
import 'package:simulator/features/wealth/presentation/portfolio_screen.dart';
import 'package:simulator/features/wealth/presentation/time_deposit_screen.dart';
import 'package:simulator/features/wealth/presentation/shared_vault_screen.dart';
import 'package:simulator/features/wealth/presentation/roundup_screen.dart';
import 'package:simulator/features/wealth/presentation/roundup_instruments_screen.dart';
import 'package:simulator/features/analytics/presentation/ai_assistant_screen.dart';
import 'package:simulator/features/analytics/presentation/ai_assistant_search_screen.dart';
import 'package:simulator/features/analytics/presentation/ai_financial_insights_screen.dart';
import 'package:simulator/features/analytics/presentation/transaction_intelligence_screen.dart';
import 'package:simulator/features/analytics/presentation/notification_intelligence_screen.dart';
import 'package:simulator/features/analytics/presentation/widget_quick_actions_screen.dart';
import 'package:simulator/features/sme/presentation/sme_dashboard_screen.dart';
import 'package:simulator/features/sme/presentation/sme_new_invoice_screen.dart';
import 'package:simulator/features/sme/presentation/programmable_money_detail_screen.dart';
import 'package:simulator/features/sme/presentation/programmable_money_verify_screen.dart';
import 'package:simulator/features/sme/presentation/programmable_money_rejected_screen.dart';
import 'package:simulator/features/accessibility/presentation/accessibility_settings_screen.dart';
import 'package:simulator/features/accessibility/presentation/theme_customizer_screen.dart';
import 'package:simulator/features/accessibility/presentation/biometrics_setup_screen.dart';
import 'package:simulator/features/accessibility/presentation/language_selector_screen.dart';
import 'package:simulator/features/accessibility/presentation/security_logs_screen.dart';
import 'package:simulator/features/dashboard/presentation/loyalty_screen.dart';
import 'package:simulator/features/dashboard/presentation/system_status_screen.dart';
import 'package:simulator/features/wealth/presentation/multicurrency_wallet_screen.dart';
import 'package:simulator/features/wealth/presentation/live_fx_rate_screen.dart';
import 'package:simulator/features/wealth/presentation/financial_products_screen.dart';
import 'package:simulator/features/security/presentation/card_limit_settings_screen.dart';
import 'package:simulator/features/wealth/presentation/shared_wallet_screen.dart';
import 'package:simulator/features/profile/presentation/customer_service_screen.dart';
import 'package:simulator/features/dashboard/presentation/lifestyle_marketplace_screen.dart';
import 'package:simulator/features/dashboard/presentation/notification_center_screen.dart';
import 'package:simulator/features/security/presentation/digital_heir_screen.dart';
import 'package:simulator/features/security/presentation/dispute_manager_screen.dart';
import 'package:simulator/features/security/presentation/virtual_card_screen.dart';
import 'package:simulator/features/security/presentation/credit_card_screen.dart';
import 'package:simulator/features/security/presentation/personal_api_screen.dart';
import 'package:simulator/features/transactions/presentation/bulk_transfer_screen.dart';
import 'package:simulator/features/security/presentation/device_management_screen.dart';
import 'package:simulator/features/dashboard/presentation/sub_account_management_screen.dart';
import 'package:simulator/features/transactions/presentation/payment_link_screen.dart';
import 'package:simulator/features/transactions/presentation/request_money_screen.dart';
import 'package:simulator/features/security/presentation/travel_mode_screen.dart';
import 'package:simulator/features/dashboard/presentation/envelope_budgeting_screen.dart';
import 'package:simulator/features/subscriptions/presentation/recurring_payments_screen.dart';
import 'package:simulator/features/dashboard/presentation/export_report_screen.dart';
import 'package:simulator/features/analytics/presentation/financial_health_screen.dart';
import 'package:simulator/features/analytics/presentation/tax_report_screen.dart';
import 'package:simulator/features/analytics/presentation/predictive_cashflow_screen.dart';
import 'package:simulator/features/analytics/presentation/geolocation_map_screen.dart';
import 'package:simulator/features/wealth/presentation/group_savings_screen.dart';
import 'package:simulator/features/sme/presentation/approval_workflow_screen.dart';
import 'package:simulator/features/transactions/presentation/contact_history_screen.dart';
import 'package:simulator/features/accessibility/presentation/voice_banking_screen.dart';
import 'package:simulator/features/accessibility/presentation/elder_mode_screen.dart';
import 'package:simulator/features/security/presentation/duress_pin_screen.dart';

part 'app_router.g.dart';

@TypedStatefulShellRoute<AppShellRouteData>(
  branches: <TypedStatefulShellBranch<StatefulShellBranchData>>[
    TypedStatefulShellBranch<DashboardBranch>(
      routes: <TypedRoute<RouteData>>[
        TypedGoRoute<DashboardRoute>(
          path: '/',
          routes: [
            TypedGoRoute<TransactionDetailRoute>(path: 'transaction/:id'),
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

// Phase 1 Global Page Routes
@TypedGoRoute<OnboardingRoute>(path: '/onboarding')
class OnboardingRoute extends GoRouteData with $OnboardingRoute {
  const OnboardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OnboardingScreen();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with $LoginRoute {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoginScreen();
}

@TypedGoRoute<OAuthLoginRoute>(path: '/oauth/authorize')
class OAuthLoginRoute extends GoRouteData with $OAuthLoginRoute {
  const OAuthLoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const OAuthLoginScreen();
}

@TypedGoRoute<KYCIdentityRoute>(path: '/kyc/identity')
class KYCIdentityRoute extends GoRouteData with $KYCIdentityRoute {
  const KYCIdentityRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const KYCIdentityScreen();
}

@TypedGoRoute<KYCFaceRoute>(path: '/kyc/face')
class KYCFaceRoute extends GoRouteData with $KYCFaceRoute {
  const KYCFaceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const KYCFaceScreen();
}

@TypedGoRoute<KYCSuccessRoute>(path: '/kyc/success')
class KYCSuccessRoute extends GoRouteData with $KYCSuccessRoute {
  const KYCSuccessRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const KYCSuccessScreen();
}

@TypedGoRoute<ProfileRoute>(path: '/profile')
class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

// Phase 2 Transaction Page Routes
@TypedGoRoute<TransferRoute>(path: '/transactions/transfer')
class TransferRoute extends GoRouteData with $TransferRoute {
  const TransferRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TransferScreen();
}

@TypedGoRoute<PayBillsRoute>(path: '/transactions/pay-bills')
class PayBillsRoute extends GoRouteData with $PayBillsRoute {
  const PayBillsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PayBillsScreen();
}

@TypedGoRoute<PLNDetailRoute>(path: '/transactions/pln-detail')
class PLNDetailRoute extends GoRouteData with $PLNDetailRoute {
  const PLNDetailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PLNDetailScreen();
}

@TypedGoRoute<QRISScanRoute>(path: '/transactions/qris-scan')
class QRISScanRoute extends GoRouteData with $QRISScanRoute {
  const QRISScanRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const QRISScanScreen();
}

@TypedGoRoute<BillSplitRoute>(path: '/transactions/bill-split')
class BillSplitRoute extends GoRouteData with $BillSplitRoute {
  const BillSplitRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BillSplitScreen();
}

@TypedGoRoute<ScheduledTransferRoute>(path: '/transactions/scheduled')
class ScheduledTransferRoute extends GoRouteData with $ScheduledTransferRoute {
  const ScheduledTransferRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ScheduledTransferScreen();
}

// Phase 3 Wealth & Savings Page Routes
@TypedGoRoute<InvestRoute>(path: '/wealth/invest')
class InvestRoute extends GoRouteData with $InvestRoute {
  const InvestRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InvestScreen();
}

@TypedGoRoute<PortfolioRoute>(path: '/wealth/portfolio')
class PortfolioRoute extends GoRouteData with $PortfolioRoute {
  const PortfolioRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PortfolioScreen();
}

@TypedGoRoute<TimeDepositRoute>(path: '/wealth/savings/time-deposit')
class TimeDepositRoute extends GoRouteData with $TimeDepositRoute {
  const TimeDepositRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TimeDepositScreen();
}

@TypedGoRoute<SharedVaultRoute>(path: '/wealth/savings/shared-vault')
class SharedVaultRoute extends GoRouteData with $SharedVaultRoute {
  const SharedVaultRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SharedVaultScreen();
}

@TypedGoRoute<RoundUpRoute>(path: '/wealth/roundup')
class RoundUpRoute extends GoRouteData with $RoundUpRoute {
  const RoundUpRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RoundUpScreen();
}

@TypedGoRoute<RoundUpInstrumentsRoute>(path: '/wealth/roundup/instruments')
class RoundUpInstrumentsRoute extends GoRouteData
    with $RoundUpInstrumentsRoute {
  const RoundUpInstrumentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const RoundUpInstrumentsScreen();
}

// Phase 4 AI & Analytics Page Routes
@TypedGoRoute<AIAssistantRoute>(path: '/analytics/chat')
class AIAssistantRoute extends GoRouteData with $AIAssistantRoute {
  const AIAssistantRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AIAssistantScreen();
}

@TypedGoRoute<AIAssistantSearchRoute>(path: '/analytics/search')
class AIAssistantSearchRoute extends GoRouteData with $AIAssistantSearchRoute {
  const AIAssistantSearchRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AIAssistantSearchScreen();
}

@TypedGoRoute<AIFinancialInsightsRoute>(path: '/analytics/insights')
class AIFinancialInsightsRoute extends GoRouteData
    with $AIFinancialInsightsRoute {
  const AIFinancialInsightsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AIFinancialInsightsScreen();
}

@TypedGoRoute<TransactionIntelligenceRoute>(path: '/analytics/intelligence')
class TransactionIntelligenceRoute extends GoRouteData
    with $TransactionIntelligenceRoute {
  const TransactionIntelligenceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TransactionIntelligenceScreen();
}

@TypedGoRoute<NotificationIntelligenceRoute>(path: '/analytics/notification')
class NotificationIntelligenceRoute extends GoRouteData
    with $NotificationIntelligenceRoute {
  const NotificationIntelligenceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationIntelligenceScreen();
}

@TypedGoRoute<WidgetQuickActionsRoute>(path: '/analytics/widgets')
class WidgetQuickActionsRoute extends GoRouteData
    with $WidgetQuickActionsRoute {
  const WidgetQuickActionsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const WidgetQuickActionsScreen();
}

// Phase 5 SME & Invoicing Page Routes
@TypedGoRoute<SMEDashboardRoute>(path: '/sme/dashboard')
class SMEDashboardRoute extends GoRouteData with $SMEDashboardRoute {
  const SMEDashboardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SMEDashboardScreen();
}

@TypedGoRoute<SMENewInvoiceRoute>(path: '/sme/invoices/new')
class SMENewInvoiceRoute extends GoRouteData with $SMENewInvoiceRoute {
  const SMENewInvoiceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SMENewInvoiceScreen();
}

@TypedGoRoute<ProgrammableMoneyDetailRoute>(
  path: '/sme/programmable-money/detail',
)
class ProgrammableMoneyDetailRoute extends GoRouteData
    with $ProgrammableMoneyDetailRoute {
  const ProgrammableMoneyDetailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProgrammableMoneyDetailScreen();
}

@TypedGoRoute<ProgrammableMoneyVerifyRoute>(
  path: '/sme/programmable-money/verify',
)
class ProgrammableMoneyVerifyRoute extends GoRouteData
    with $ProgrammableMoneyVerifyRoute {
  const ProgrammableMoneyVerifyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProgrammableMoneyVerifyScreen();
}

@TypedGoRoute<ProgrammableMoneyRejectedRoute>(
  path: '/sme/programmable-money/rejected',
)
class ProgrammableMoneyRejectedRoute extends GoRouteData
    with $ProgrammableMoneyRejectedRoute {
  const ProgrammableMoneyRejectedRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProgrammableMoneyRejectedScreen();
}

// Phase 6 Accessibility & Customization Page Routes
@TypedGoRoute<AccessibilitySettingsRoute>(path: '/settings/accessibility')
class AccessibilitySettingsRoute extends GoRouteData
    with $AccessibilitySettingsRoute {
  const AccessibilitySettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AccessibilitySettingsScreen();
}

@TypedGoRoute<ThemeCustomizerRoute>(path: '/settings/themes')
class ThemeCustomizerRoute extends GoRouteData with $ThemeCustomizerRoute {
  const ThemeCustomizerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ThemeCustomizerScreen();
}

@TypedGoRoute<BiometricsSetupRoute>(path: '/settings/biometrics')
class BiometricsSetupRoute extends GoRouteData with $BiometricsSetupRoute {
  const BiometricsSetupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const BiometricsSetupScreen();
}

@TypedGoRoute<LanguageSelectorRoute>(path: '/settings/languages')
class LanguageSelectorRoute extends GoRouteData with $LanguageSelectorRoute {
  const LanguageSelectorRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LanguageSelectorScreen();
}

@TypedGoRoute<SecurityLogsRoute>(path: '/settings/security-logs')
class SecurityLogsRoute extends GoRouteData with $SecurityLogsRoute {
  const SecurityLogsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SecurityLogsScreen();
}

// 15 New Routes
@TypedGoRoute<LoyaltyRoute>(path: '/dashboard/loyalty')
class LoyaltyRoute extends GoRouteData with $LoyaltyRoute {
  const LoyaltyRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LoyaltyScreen();
}

@TypedGoRoute<SystemStatusRoute>(path: '/dashboard/system-status')
class SystemStatusRoute extends GoRouteData with $SystemStatusRoute {
  const SystemStatusRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SystemStatusScreen();
}

@TypedGoRoute<MulticurrencyWalletRoute>(path: '/wealth/multicurrency')
class MulticurrencyWalletRoute extends GoRouteData
    with $MulticurrencyWalletRoute {
  const MulticurrencyWalletRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MulticurrencyWalletScreen();
}

@TypedGoRoute<LiveFxRateRoute>(path: '/wealth/live-fx')
class LiveFxRateRoute extends GoRouteData with $LiveFxRateRoute {
  const LiveFxRateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LiveFxRateScreen();
}

@TypedGoRoute<FinancialProductsRoute>(path: '/wealth/products')
class FinancialProductsRoute extends GoRouteData with $FinancialProductsRoute {
  const FinancialProductsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const FinancialProductsScreen();
}

@TypedGoRoute<CardLimitSettingsRoute>(path: '/security/card-limit')
class CardLimitSettingsRoute extends GoRouteData with $CardLimitSettingsRoute {
  const CardLimitSettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CardLimitSettingsScreen();
}

@TypedGoRoute<SharedWalletRoute>(path: '/wealth/shared-wallet')
class SharedWalletRoute extends GoRouteData with $SharedWalletRoute {
  const SharedWalletRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SharedWalletScreen();
}

@TypedGoRoute<CustomerServiceRoute>(path: '/profile/customer-service')
class CustomerServiceRoute extends GoRouteData with $CustomerServiceRoute {
  const CustomerServiceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CustomerServiceScreen();
}

@TypedGoRoute<LifestyleMarketplaceRoute>(path: '/dashboard/lifestyle')
class LifestyleMarketplaceRoute extends GoRouteData
    with $LifestyleMarketplaceRoute {
  const LifestyleMarketplaceRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const LifestyleMarketplaceScreen();
}

@TypedGoRoute<NotificationCenterRoute>(path: '/dashboard/notifications')
class NotificationCenterRoute extends GoRouteData
    with $NotificationCenterRoute {
  const NotificationCenterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const NotificationCenterScreen();
}

@TypedGoRoute<DigitalHeirRoute>(path: '/security/digital-heir')
class DigitalHeirRoute extends GoRouteData with $DigitalHeirRoute {
  const DigitalHeirRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DigitalHeirScreen();
}

@TypedGoRoute<DisputeManagerRoute>(path: '/security/dispute-manager')
class DisputeManagerRoute extends GoRouteData with $DisputeManagerRoute {
  const DisputeManagerRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DisputeManagerScreen();
}

@TypedGoRoute<VirtualCardRoute>(path: '/security/virtual-card')
class VirtualCardRoute extends GoRouteData with $VirtualCardRoute {
  const VirtualCardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const VirtualCardScreen();
}

@TypedGoRoute<CreditCardRoute>(path: '/security/credit-card')
class CreditCardRoute extends GoRouteData with $CreditCardRoute {
  const CreditCardRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CreditCardScreen();
}

@TypedGoRoute<PersonalApiRoute>(path: '/security/personal-api')
class PersonalApiRoute extends GoRouteData with $PersonalApiRoute {
  const PersonalApiRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PersonalApiScreen();
}

// 19 PRD Routes
@TypedGoRoute<BulkTransferRoute>(path: '/transactions/bulk-transfer')
class BulkTransferRoute extends GoRouteData with $BulkTransferRoute {
  const BulkTransferRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const BulkTransferScreen();
}

@TypedGoRoute<DeviceManagementRoute>(path: '/security/device-management')
class DeviceManagementRoute extends GoRouteData with $DeviceManagementRoute {
  const DeviceManagementRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const DeviceManagementScreen();
}

@TypedGoRoute<SubAccountManagementRoute>(path: '/dashboard/sub-accounts')
class SubAccountManagementRoute extends GoRouteData with $SubAccountManagementRoute {
  const SubAccountManagementRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const SubAccountManagementScreen();
}

@TypedGoRoute<PaymentLinkRoute>(path: '/transactions/payment-link')
class PaymentLinkRoute extends GoRouteData with $PaymentLinkRoute {
  const PaymentLinkRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const PaymentLinkScreen();
}

@TypedGoRoute<RequestMoneyRoute>(path: '/transactions/request-money')
class RequestMoneyRoute extends GoRouteData with $RequestMoneyRoute {
  const RequestMoneyRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const RequestMoneyScreen();
}

@TypedGoRoute<TravelModeRoute>(path: '/security/travel-mode')
class TravelModeRoute extends GoRouteData with $TravelModeRoute {
  const TravelModeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const TravelModeScreen();
}

@TypedGoRoute<EnvelopeBudgetingRoute>(path: '/dashboard/envelope-budgeting')
class EnvelopeBudgetingRoute extends GoRouteData with $EnvelopeBudgetingRoute {
  const EnvelopeBudgetingRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const EnvelopeBudgetingScreen();
}

@TypedGoRoute<RecurringPaymentsRoute>(path: '/subscriptions/recurring-payments')
class RecurringPaymentsRoute extends GoRouteData with $RecurringPaymentsRoute {
  const RecurringPaymentsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const RecurringPaymentsScreen();
}

@TypedGoRoute<ExportReportRoute>(path: '/dashboard/export-report')
class ExportReportRoute extends GoRouteData with $ExportReportRoute {
  const ExportReportRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ExportReportScreen();
}

@TypedGoRoute<FinancialHealthRoute>(path: '/analytics/financial-health')
class FinancialHealthRoute extends GoRouteData with $FinancialHealthRoute {
  const FinancialHealthRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const FinancialHealthScreen();
}

@TypedGoRoute<TaxReportRoute>(path: '/analytics/tax-report')
class TaxReportRoute extends GoRouteData with $TaxReportRoute {
  const TaxReportRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const TaxReportScreen();
}

@TypedGoRoute<PredictiveCashflowRoute>(path: '/analytics/predictive-cashflow')
class PredictiveCashflowRoute extends GoRouteData with $PredictiveCashflowRoute {
  const PredictiveCashflowRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const PredictiveCashflowScreen();
}

@TypedGoRoute<GeolocationMapRoute>(path: '/analytics/geolocation-map')
class GeolocationMapRoute extends GoRouteData with $GeolocationMapRoute {
  const GeolocationMapRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const GeolocationMapScreen();
}

@TypedGoRoute<GroupSavingsRoute>(path: '/wealth/group-savings')
class GroupSavingsRoute extends GoRouteData with $GroupSavingsRoute {
  const GroupSavingsRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const GroupSavingsScreen();
}

@TypedGoRoute<ApprovalWorkflowRoute>(path: '/sme/approval-workflow')
class ApprovalWorkflowRoute extends GoRouteData with $ApprovalWorkflowRoute {
  const ApprovalWorkflowRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ApprovalWorkflowScreen();
}

@TypedGoRoute<ContactHistoryRoute>(path: '/transactions/contact-history')
class ContactHistoryRoute extends GoRouteData with $ContactHistoryRoute {
  const ContactHistoryRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ContactHistoryScreen();
}

@TypedGoRoute<VoiceBankingRoute>(path: '/settings/voice-banking')
class VoiceBankingRoute extends GoRouteData with $VoiceBankingRoute {
  const VoiceBankingRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const VoiceBankingScreen();
}

@TypedGoRoute<ElderModeRoute>(path: '/settings/elder-mode')
class ElderModeRoute extends GoRouteData with $ElderModeRoute {
  const ElderModeRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const ElderModeScreen();
}

@TypedGoRoute<DuressPinRoute>(path: '/security/duress-pin')
class DuressPinRoute extends GoRouteData with $DuressPinRoute {
  const DuressPinRoute();
  @override
  Widget build(BuildContext context, GoRouterState state) => const DuressPinScreen();
}

// Global router config instance
final GoRouter appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: $appRoutes,
);
