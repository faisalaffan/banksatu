import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';
import 'package:banksatu_mobile/core/router/app_router.dart';
import 'package:banksatu_mobile/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:banksatu_mobile/features/dashboard/models/transaction.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Dispatch LoadDashboard on startup
    context.read<DashboardBloc>().add(LoadDashboard());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  color: AppTheme.primaryBlue,
                  radius: 14,
                ),
              );
            }

            if (state is DashboardError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(CupertinoIcons.exclamationmark_circle, size: 48, color: AppTheme.errorRed),
                    const SizedBox(height: 16),
                    Text(
                      state.message,
                      style: const TextStyle(color: AppTheme.textLightGray),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    CupertinoButton(
                      onPressed: () => context.read<DashboardBloc>().add(LoadDashboard()),
                      color: AppTheme.primaryBlue,
                      borderRadius: BorderRadius.circular(12),
                      child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }

            if (state is DashboardLoaded) {
              return Material(
                type: MaterialType.transparency,
                child: CustomScrollView(
                slivers: [
                  // App Bar / Premium Greeting
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 16,
                      bottom: 8,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat Pagi,',
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Faisal Affan',
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    const NotificationIntelligenceRoute().push(
                                      context,
                                    ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryBlue.withOpacity(
                                      0.06,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Platform.isIOS
                                        ? CupertinoIcons.bell
                                        : Icons.notifications_none_outlined,
                                    color: AppTheme.primaryBlue,
                                    size: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => const ProfileRoute().push(context),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppTheme.primaryBlue,
                                        AppTheme.primaryBlueDark,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: AppTheme.premiumShadow,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'FA',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Total Balance Card (Frosted Glass Blue Gradient)
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppTheme.primaryBlue,
                              AppTheme.primaryBlueDark,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryBlue.withOpacity(0.3),
                              offset: const Offset(0, 12),
                              blurRadius: 24,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TOTAL SALDO AKTIF',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Platform.isIOS
                                            ? CupertinoIcons.checkmark_seal_fill
                                            : Icons.verified,
                                        color: Colors.greenAccent,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'BI-FAST Ready',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              _formatCurrency(state.balance),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildBalanceAction(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.paperplane_fill
                                      : Icons.send_rounded,
                                  label: 'Kirim',
                                  onTap: () =>
                                      const TransferRoute().push(context),
                                ),
                                _buildBalanceAction(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.viewfinder
                                      : Icons.qr_code_scanner_rounded,
                                  label: 'QRIS Pay',
                                  onTap: () =>
                                      const QRISScanRoute().push(context),
                                ),
                                _buildBalanceAction(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.plus_circle_fill
                                      : Icons.add_rounded,
                                  label: 'Isi Saldo',
                                  onTap: () => const ScheduledTransferRoute()
                                      .push(context),
                                ),
                                _buildBalanceAction(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.ellipsis
                                      : Icons.more_horiz_rounded,
                                  label: 'Lainnya',
                                  onTap: () =>
                                      const PayBillsRoute().push(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Natural Language Search Bar
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Platform.isIOS
                          ? Container(
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceCard,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFE3E8F9),
                                  width: 1,
                                ),
                                boxShadow: AppTheme.premiumShadow,
                              ),
                              child: CupertinoSearchTextField(
                                controller: _searchController,
                                onChanged: (val) {
                                  context.read<DashboardBloc>().add(
                                    SearchTransactions(val),
                                  );
                                },
                                placeholder:
                                    'Cari kata kunci: "F&B", "Gaji", "BCA", dll...',
                                style: GoogleFonts.inter(
                                  color: AppTheme.textDark,
                                  fontSize: 14,
                                ),
                                placeholderStyle: GoogleFonts.inter(
                                  color: AppTheme.textLightGray,
                                  fontSize: 14,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                prefixInsets: const EdgeInsets.only(
                                  left: 14,
                                  right: 6,
                                ),
                                suffixInsets: const EdgeInsets.only(right: 14),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: AppTheme.surfaceCard,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFFE3E8F9),
                                  width: 1,
                                ),
                                boxShadow: AppTheme.premiumShadow,
                              ),
                              child: TextField(
                                controller: _searchController,
                                onChanged: (val) {
                                  context.read<DashboardBloc>().add(
                                    SearchTransactions(val),
                                  );
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      'Cari kata kunci: "F&B", "Gaji", "BCA", dll...',
                                  hintStyle: GoogleFonts.inter(
                                    color: AppTheme.textLightGray,
                                    fontSize: 14,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: AppTheme.primaryBlue,
                                  ),
                                  suffixIcon: _searchController.text.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(
                                            Icons.clear,
                                            color: AppTheme.textLightGray,
                                          ),
                                          onPressed: () {
                                            _searchController.clear();
                                            context.read<DashboardBloc>().add(
                                              SearchTransactions(''),
                                            );
                                            setState(() {});
                                          },
                                        )
                                      : null,
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                    ),
                  ),

                  // Horizontal Feature Shortcuts
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Fitur Pintar',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 72,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                _buildFeatureChip(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.chart_bar_alt_fill
                                      : Icons.insights,
                                  label: 'AI Insights',
                                  color: AppTheme.shariaGreen,
                                  onTap: () =>
                                      const AIFinancialInsightsRoute().push(context),
                                ),
                                _buildFeatureChip(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.chart_pie_fill
                                      : Icons.query_stats,
                                  label: 'Intel',
                                  color: AppTheme.primaryBlue,
                                  onTap: () =>
                                      const TransactionIntelligenceRoute().push(context),
                                ),
                                _buildFeatureChip(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.search_circle_fill
                                      : Icons.manage_search,
                                  label: 'Cari AI',
                                  color: Colors.deepPurple,
                                  onTap: () =>
                                      const AIAssistantSearchRoute().push(context),
                                ),
                                _buildFeatureChip(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.square_grid_2x2_fill
                                      : Icons.widgets,
                                  label: 'Widget',
                                  color: Colors.orange,
                                  onTap: () =>
                                      const WidgetQuickActionsRoute().push(context),
                                ),
                                _buildFeatureChip(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.gift_fill
                                      : Icons.card_giftcard,
                                  label: 'Loyalty',
                                  color: Colors.pink,
                                  onTap: () => const LoyaltyRoute().push(context),
                                ),
                                _buildFeatureChip(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.antenna_radiowaves_left_right
                                      : Icons.monitor_heart,
                                  label: 'Status',
                                  color: Colors.teal,
                                  onTap: () =>
                                      const SystemStatusRoute().push(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Wealth & Services Quick Grid
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Keuangan & Investasi',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.share
                                      : Icons.folder_shared,
                                  label: 'Shared Wallet',
                                  onTap: () =>
                                      const SharedWalletRoute().push(context),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.money_dollar_circle
                                      : Icons.currency_exchange,
                                  label: 'Multi Mata Uang',
                                  onTap: () =>
                                      const MulticurrencyWalletRoute().push(context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.chart_bar_alt_fill
                                      : Icons.show_chart,
                                  label: 'Live FX',
                                  onTap: () => const LiveFxRateRoute().push(context),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.bag_fill
                                      : Icons.shopping_bag,
                                  label: 'Produk Finansial',
                                  onTap: () =>
                                      const FinancialProductsRoute().push(context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.graph_square
                                      : Icons.trending_up,
                                  label: 'Investasi',
                                  onTap: () => const InvestRoute().push(context),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.chart_pie_fill
                                      : Icons.pie_chart_outline,
                                  label: 'Portofolio',
                                  onTap: () => const PortfolioRoute().push(context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.lock_shield
                                      : Icons.lock_outline,
                                  label: 'Deposito',
                                  onTap: () => const TimeDepositRoute().push(context),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.arrow_2_circlepath
                                      : Icons.autorenew,
                                  label: 'Autosave Round-up',
                                  onTap: () => const RoundUpRoute().push(context),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.person_2_fill
                                      : Icons.people_outline,
                                  label: 'Kantong / Sub-Akun',
                                  onTap: () => const SubAccountManagementRoute().push(context),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.mail_solid
                                      : Icons.mail_outline,
                                  label: 'Pos Anggaran',
                                  onTap: () => const EnvelopeBudgetingRoute().push(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Lifestyle & Services
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Layanan Lainnya',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.cart_fill
                                      : Icons.storefront,
                                  label: 'Lifestyle',
                                  onTap: () =>
                                      const LifestyleMarketplaceRoute().push(context),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _buildServiceCard(
                                  icon: Platform.isIOS
                                      ? CupertinoIcons.bell_fill
                                      : Icons.notifications_active,
                                  label: 'Notifikasi',
                                  onTap: () =>
                                      const NotificationCenterRoute().push(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Transactions List Header
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 16,
                      bottom: 8,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.searchQuery.isEmpty
                                ? 'Riwayat Transaksi'
                                : 'Hasil Pencarian',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          Row(
                            children: [
                              if (state.searchQuery.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: Text(
                                    '${state.filteredTransactions.length} Ditemukan',
                                    style: GoogleFonts.inter(
                                      color: AppTheme.primaryBlue,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              GestureDetector(
                                onTap: () => const ExportReportRoute().push(context),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryBlue.withOpacity(0.06),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Platform.isIOS
                                        ? CupertinoIcons.square_arrow_down
                                        : Icons.download_rounded,
                                    color: AppTheme.primaryBlue,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Transactions Scrollable List
                  state.filteredTransactions.isEmpty
                      ? SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Platform.isIOS
                                      ? CupertinoIcons.search_circle
                                      : Icons.search_off,
                                  size: 64,
                                  color: AppTheme.textDisabled,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Transaksi tidak ditemukan',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.textLightGray,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final tx = state.filteredTransactions[index];
                            return _buildTransactionItem(context, tx);
                          }, childCount: state.filteredTransactions.length),
                        ),

                  // Bottom padding spacer to avoid persistent floating navigation bar clipping
                  const SliverToBoxAdapter(child: SizedBox(height: 120)),
                ],
              ),
            );
          }

            return const Center(child: Text('Terjadi kesalahan fatal.'));
          },
        ),
      );
    }

  Widget _buildBalanceAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        width: 72,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
          boxShadow: AppTheme.premiumShadow,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.primaryBlue, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Platform.isIOS ? CupertinoIcons.chevron_right : Icons.chevron_right,
              color: AppTheme.textLightGray,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, Transaction tx) {
    final isNegative = tx.amount < 0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Type-safe routing to Transaction Details using GoRouter Builder
            TransactionDetailRoute(id: tx.id).go(context);
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
              boxShadow: AppTheme.premiumShadow,
            ),
            child: Row(
              children: [
                // Stylized Category Icon Container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isNegative
                        ? AppTheme.primaryBlue.withOpacity(0.06)
                        : AppTheme.shariaGreen.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _getCategoryIcon(tx.category),
                    color: isNegative
                        ? AppTheme.primaryBlue
                        : AppTheme.shariaGreen,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                // Translated Human-Readable name & Acquirer String
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tx.merchantName,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tx.originalAcquirerString,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          color: AppTheme.textLightGray,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Amount (Salary Green / Spending Neutral)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isNegative ? "" : "+"}${_formatCurrency(tx.amount)}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isNegative
                            ? AppTheme.textDark
                            : AppTheme.shariaGreen,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(tx.timestamp),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: AppTheme.textLightGray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    final isIos = Platform.isIOS;
    switch (category.toLowerCase()) {
      case 'food & beverage':
        return isIos ? CupertinoIcons.heart : Icons.local_cafe_outlined;
      case 'transportation':
        return isIos ? CupertinoIcons.car : Icons.directions_transit_outlined;
      case 'salary':
        return isIos ? CupertinoIcons.briefcase : Icons.payments_outlined;
      case 'shopping':
        return isIos ? CupertinoIcons.bag : Icons.shopping_bag_outlined;
      case 'bills':
        return isIos ? CupertinoIcons.doc_text : Icons.receipt_long_outlined;
      case 'subscription':
        return isIos
            ? CupertinoIcons.arrow_2_circlepath
            : Icons.autorenew_outlined;
      default:
        return isIos
            ? CupertinoIcons.arrow_right_arrow_left
            : Icons.swap_horiz_rounded;
    }
  }

  String _formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }
}
