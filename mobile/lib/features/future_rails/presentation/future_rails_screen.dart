import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';
import 'package:banksatu_mobile/core/widgets/adaptive_dialog.dart';
import 'package:banksatu_mobile/features/future_rails/bloc/future_rails_bloc.dart';

class FutureRailsScreen extends StatefulWidget {
  const FutureRailsScreen({Key? key}) : super(key: key);

  @override
  State<FutureRailsScreen> createState() => _FutureRailsScreenState();
}

class _FutureRailsScreenState extends State<FutureRailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FutureRailsBloc>().add(LoadFutureRails());
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Platform.isIOS ? CupertinoIcons.bolt_fill : Icons.offline_bolt,
              color: Colors.teal,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Future Rails & CBDC',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: BlocConsumer<FutureRailsBloc, FutureRailsState>(
        listener: (context, state) {
          if (state is FutureRailsLoaded && state.transactionStatusMessage != null) {
            // Show alert dialog for programmable block warnings or success messages
            _showStatusDialog(context, state.transactionStatusMessage!, state.isTransactionSuccessful);
            context.read<FutureRailsBloc>().add(ResetTransactionState());
          }
        },
        builder: (context, state) {
          if (state is FutureRailsLoading) {
            return Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator(color: Colors.teal, radius: 14)
                  : const CircularProgressIndicator(color: Colors.teal),
            );
          }

          if (state is FutureRailsLoaded) {
            final d = state.data;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Digital Rupiah (CBDC) Wallet Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.teal, Color(0xFF0F3A30)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.teal.withOpacity(0.25),
                          offset: const Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Platform.isIOS ? CupertinoIcons.star_fill : Icons.stars,
                                  color: Colors.yellowAccent,
                                  size: 18,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'RUPIAH DIGITAL (CBDC)',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                'Issued by BI',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _formatCurrency(d.cbdcBalance),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<FutureRailsBloc>().add(MintCbdcTokens(250000.00)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            minimumSize: const Size.fromHeight(44),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            'Cetak (Mint) Rp 250.000 Baru',
                            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Crypto Custody Wallet (USDT & USDC)
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          title: 'KUSTODI ASET KRIPTO (OJK SANDBOX)',
                          subtitle: 'Penyimpanan aman stabil koin USDT/USDC teraudit.',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            _buildCryptoAssetRow(
                              symbol: 'USDT',
                              balance: d.cryptoAssets['USDT'] ?? 0.00,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 24),
                            _buildCryptoAssetRow(
                              symbol: 'USDC',
                              balance: d.cryptoAssets['USDC'] ?? 0.00,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cadangkan Secure Keys',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    d.isSecureCustodyBackupDone
                                        ? 'Selesai dicadangkan secara lokal.'
                                        : 'Kunci pemulihan Anda belum dicadangkan.',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: d.isSecureCustodyBackupDone
                                          ? AppTheme.shariaGreen
                                          : AppTheme.textLightGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: d.isSecureCustodyBackupDone
                                  ? null
                                  : () => context.read<FutureRailsBloc>().add(BackupCustodyKeys()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: AppTheme.background,
                                disabledForegroundColor: AppTheme.textLightGray,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              child: Text(
                                d.isSecureCustodyBackupDone ? 'Selesai' : 'Backup',
                                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Uang Terprogram (Programmable Money) Simulator
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          title: 'UANG TERPROGRAM (PROGRAMMABLE MONEY)',
                          subtitle: 'Simulasi pembatasan belanja dana bantuan bersyarat secara otomatis.',
                        ),
                        const SizedBox(height: 20),

                        // Bansos Card
                        _buildProgrammableCard(
                          title: 'DANA BANTUAN SOSIAL (BANSOS)',
                          balance: d.bansosBalance,
                          lockedCategory: d.bansosLockedCategory,
                          onSpendCorrect: () => context.read<FutureRailsBloc>().add(
                                SpendBansosAid(amount: 150000.00, category: 'Sembako & Kebutuhan Pokok'),
                              ),
                          onSpendWrong: () => context.read<FutureRailsBloc>().add(
                                SpendBansosAid(amount: 150000.00, category: 'Hiburan & Bioskop'),
                              ),
                          labelCorrect: 'Beli Sembako (Rp 150k)',
                          labelWrong: 'Beli Tiket Bioskop (Rp 150k)',
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),

                        // Education Card
                        _buildProgrammableCard(
                          title: 'DANA BANTUAN PENDIDIKAN',
                          balance: d.educationBalance,
                          lockedCategory: d.educationLockedCategory,
                          onSpendCorrect: () => context.read<FutureRailsBloc>().add(
                                SpendBansosAid(amount: 500000.00, category: 'Biaya Sekolah / Kuliah'),
                              ),
                          onSpendWrong: () => context.read<FutureRailsBloc>().add(
                                SpendBansosAid(amount: 500000.00, category: 'Gadget & Gaming'),
                              ),
                          labelCorrect: 'Bayar SPP (Rp 500k)',
                          labelWrong: 'Beli Game Console (Rp 500k)',
                        ),
                      ],
                    ),
                  ),

                  // Bottom padding spacer
                  const SizedBox(height: 120),
                ],
              ),
            );
          }

          return const Center(child: Text('Terjadi kesalahan fatal.'));
        },
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppTheme.textLightGray,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppTheme.textLightGray,
          ),
        ),
      ],
    );
  }

  Widget _buildCryptoAssetRow({
    required String symbol,
    required double balance,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8EEFF)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Platform.isIOS ? CupertinoIcons.creditcard_fill : Icons.account_balance_wallet,
                color: color,
                size: 18,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  symbol,
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                ),
                const SizedBox(height: 4),
                Text(
                  balance.toStringAsFixed(2),
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgrammableCard({
    required String title,
    required double balance,
    required String lockedCategory,
    required VoidCallback onSpendCorrect,
    required VoidCallback onSpendWrong,
    required String labelCorrect,
    required String labelWrong,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
                letterSpacing: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.errorRed.withOpacity(0.08),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Icon(
                    Platform.isIOS ? CupertinoIcons.lock_fill : Icons.lock,
                    color: AppTheme.errorRed,
                    size: 10,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Locked Category',
                    style: GoogleFonts.inter(
                      fontSize: 8,
                      color: AppTheme.errorRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatCurrency(balance),
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: AppTheme.textDark,
              ),
            ),
            Text(
              lockedCategory,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppTheme.textLightGray,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onSpendCorrect,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.shariaGreen,
                  side: const BorderSide(color: Color(0xFFD0F2E1), width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  labelCorrect,
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: OutlinedButton(
                onPressed: onSpendWrong,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.errorRed,
                  side: const BorderSide(color: Color(0xFFFFDAD6), width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  labelWrong,
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showStatusDialog(BuildContext context, String message, bool isSuccess) {
    AdaptiveDialog.showAlert(
      context: context,
      title: isSuccess ? 'Transaksi Sukses' : 'Transaksi Blokir',
      content: message,
      confirmLabel: 'Oke',
      cancelLabel: '', // Empty cancelLabel hides the cancel button on AdaptiveDialog
      confirmColor: isSuccess ? AppTheme.shariaGreen : AppTheme.errorRed,
      onConfirm: () {},
    );
  }
}
