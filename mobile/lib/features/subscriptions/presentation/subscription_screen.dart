import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/core/widgets/adaptive_dialog.dart';
import 'package:simulator/features/subscriptions/bloc/subscription_bloc.dart';
import 'package:simulator/features/subscriptions/models/subscription.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(LoadSubscriptions());
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  String _formatShortDate(DateTime time) {
    return DateFormat('dd MMM yyyy').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Auto-Debit Manager'),
        actions: [
          IconButton(
            icon: Icon(
              Platform.isIOS ? CupertinoIcons.calendar_badge_plus : Icons.history_toggle_off_rounded,
              color: AppTheme.primaryBlue,
            ),
            tooltip: 'Tagihan Berulang',
            onPressed: () => const RecurringPaymentsRoute().push(context),
          ),
        ],
      ),
      body: BlocBuilder<SubscriptionBloc, SubscriptionState>(
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator(color: AppTheme.primaryBlue, radius: 14)
                  : const CircularProgressIndicator(color: AppTheme.primaryBlue),
            );
          }

          if (state is SubscriptionLoaded) {
            return CustomScrollView(
              slivers: [
                // Info Summary Card (Commitment Calculator)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0F2042), Color(0xFF304368)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: AppTheme.premiumShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Platform.isIOS ? CupertinoIcons.chart_bar : Icons.analytics_outlined,
                                color: Colors.white70,
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'TOTAL KOMITMEN BULANAN',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _formatCurrency(state.totalCommitment),
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Estimasi tagihan berulang dari auto-debit aktif.',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Section Title
                SliverPadding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 8),
                  sliver: SliverToBoxAdapter(
                    child: Text(
                      'Daftar Langganan & Tagihan Aktif',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                ),

                // Auto-Debit list items
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final sub = state.subscriptions[index];
                      return _buildSubscriptionItem(context, sub);
                    },
                    childCount: state.subscriptions.length,
                  ),
                ),

                // Bottom spacer to avoid navigation bar clipping
                const SliverToBoxAdapter(
                  child: SizedBox(height: 120),
                ),
              ],
            );
          }

          return const Center(child: Text('Terjadi kesalahan fatal.'));
        },
      ),
    );
  }

  Widget _buildSubscriptionItem(BuildContext context, Subscription sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
          boxShadow: AppTheme.premiumShadow,
        ),
        child: Row(
          children: [
            // Stylized Subscription Logo Representation
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getProviderColor(sub.providerName).withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                _getProviderIcon(sub.providerName),
                color: _getProviderColor(sub.providerName),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),

            // Provider Name & Next Billing Date details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sub.providerName,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: sub.isActive ? AppTheme.textDark : AppTheme.textLightGray,
                      decoration: sub.isActive ? null : TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8EEFF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          sub.billingType,
                          style: GoogleFonts.inter(
                            fontSize: 8,
                            color: AppTheme.primaryBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        sub.isActive
                            ? 'Debet: ${_formatShortDate(sub.nextBillingDate)}'
                            : 'Di-Batalkan',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: sub.isActive ? AppTheme.textLightGray : AppTheme.errorRed,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Fee Amount & Toggle Active Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatCurrency(sub.monthlyFee),
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: sub.isActive ? AppTheme.textDark : AppTheme.textDisabled,
                  ),
                ),
                const SizedBox(height: 4),
                Switch.adaptive(
                  value: sub.isActive,
                  onChanged: (val) {
                    if (!val) {
                      // Show confirmation dialog before cancellation
                      _showCancelConfirmation(context, sub);
                    } else {
                      context.read<SubscriptionBloc>().add(CancelSubscription(sub.id));
                    }
                  },
                  activeColor: AppTheme.primaryBlue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context, Subscription sub) {
    AdaptiveDialog.showAlert(
      context: context,
      title: 'Batalkan Auto-Debit?',
      content: 'Apakah Anda yakin ingin membatalkan auto-debit untuk ${sub.providerName}? Pembayaran berikutnya tidak akan didebet otomatis dari saldo BankSatu.',
      confirmLabel: 'Ya, Hentikan',
      cancelLabel: 'Kembali',
      confirmColor: AppTheme.errorRed,
      onConfirm: () {
        context.read<SubscriptionBloc>().add(CancelSubscription(sub.id));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Auto-debit untuk ${sub.providerName} berhasil dihentikan.',
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
            backgroundColor: AppTheme.errorRed,
          ),
        );
      },
    );
  }

  IconData _getProviderIcon(String name) {
    final n = name.toLowerCase();
    final isIos = Platform.isIOS;
    if (n.contains('netflix')) {
      return isIos ? CupertinoIcons.film : Icons.movie_outlined;
    } else if (n.contains('spotify')) {
      return isIos ? CupertinoIcons.music_note : Icons.music_note_outlined;
    } else if (n.contains('youtube')) {
      return isIos ? CupertinoIcons.play_rectangle : Icons.video_library_outlined;
    } else {
      return isIos ? CupertinoIcons.heart : Icons.health_and_safety_outlined;
    }
  }

  Color _getProviderColor(String name) {
    final n = name.toLowerCase();
    if (n.contains('netflix')) {
      return Colors.red;
    } else if (n.contains('spotify')) {
      return Colors.green;
    } else if (n.contains('youtube')) {
      return Colors.redAccent;
    } else {
      return Colors.blue;
    }
  }
}
