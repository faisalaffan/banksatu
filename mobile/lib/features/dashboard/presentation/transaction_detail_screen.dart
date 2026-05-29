import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:simulator/features/dashboard/models/transaction.dart';

class TransactionDetailScreen extends StatelessWidget {
  final String transactionId;

  const TransactionDetailScreen({
    Key? key,
    required this.transactionId,
  }) : super(key: key);

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  String _formatFullDate(DateTime time) {
    return DateFormat('dd MMMM yyyy, HH:mm').format(time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detail Transaksi'),
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.left_chevron : Icons.arrow_back_ios_new,
            size: Platform.isIOS ? 22 : 18,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is! DashboardLoaded) {
            return Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator(color: AppTheme.primaryBlue, radius: 14)
                  : const CircularProgressIndicator(),
            );
          }

          final tx = state.transactions.firstWhere(
            (t) => t.id == transactionId,
            orElse: () => state.transactions.first,
          );

          final isNegative = tx.amount < 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Premium Transaction Status Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceCard,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                    boxShadow: AppTheme.premiumShadow,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: tx.isSuccess
                              ? Colors.green.withOpacity(0.08)
                              : AppTheme.errorRed.withOpacity(0.08),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          tx.isSuccess
                              ? (Platform.isIOS ? CupertinoIcons.check_mark_circled_solid : Icons.check_circle)
                              : (Platform.isIOS ? CupertinoIcons.exclamationmark_circle_fill : Icons.error_rounded),
                          color: tx.isSuccess ? AppTheme.shariaGreen : AppTheme.errorRed,
                          size: 32,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        tx.merchantName,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatFullDate(tx.timestamp),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.textLightGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Divider(color: Color(0xFFE8EEFF)),
                      ),
                      Text(
                        'NOMINAL TRANSAKSI',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textLightGray,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatCurrency(tx.amount),
                        style: GoogleFonts.inter(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: isNegative ? AppTheme.textDark : AppTheme.shariaGreen,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Geolocation Map Card (Stylized Vector Custom Paint)
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                    boxShadow: AppTheme.premiumShadow,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: [
                        // Custom Vector Map Background Drawing
                        CustomPaint(
                          size: Size.infinite,
                          painter: MapVectorPainter(),
                        ),
                        // Soft vignette
                        Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [Colors.transparent, Colors.black.withOpacity(0.1)],
                              radius: 1.2,
                            ),
                          ),
                        ),
                        // Dynamic Target Pin
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryBlue,
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: AppTheme.floatingShadow,
                                ),
                                child: Text(
                                  'Lokasi Merchant',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Icon(
                                Platform.isIOS ? CupertinoIcons.location_solid : Icons.location_pin,
                                color: AppTheme.primaryBlue,
                                size: 36,
                              ),
                            ],
                          ),
                        ),
                        // Geolocation metadata overlays
                        Positioned(
                          left: 12,
                          bottom: 12,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'GPS: ${tx.latitude.toStringAsFixed(4)}°, ${tx.longitude.toStringAsFixed(4)}°',
                              style: GoogleFonts.jetBrainsMono(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Fee Breakdown Card
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
                      Text(
                        'RINCIAN BIAYA TRANSPARAN',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textLightGray,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...tx.feeBreakdown.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                entry.key,
                                style: GoogleFonts.inter(
                                  color: AppTheme.textLightGray,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                _formatCurrency(entry.value),
                                style: GoogleFonts.inter(
                                  color: AppTheme.textDark,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(color: Color(0xFFE8EEFF)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.inter(
                              color: AppTheme.textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            _formatCurrency(tx.amount.abs()),
                            style: GoogleFonts.inter(
                              color: AppTheme.primaryBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // In-App Dispute Call to Action (Kategori 10)
                ElevatedButton(
                  onPressed: () => _showDisputeModal(context, tx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.errorRed,
                    surfaceTintColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Color(0xFFFFDAD6), width: 1.5),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Platform.isIOS ? CupertinoIcons.exclamationmark_shield : Icons.gpp_maybe_outlined,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Ajukan Dispute Transaksi',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showDisputeModal(BuildContext context, Transaction tx) {
    if (Platform.isIOS) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            title: Text(
              'Laporkan Masalah In-App',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
            message: Text(
              'Kami akan melacak laporan Anda secara real-time langsung dari aplikasi. Tidak perlu melakukan panggilan telepon luar.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                onPressed: () => _submitDispute(context, tx, 'double_debit'),
                child: Text(
                  'Saya Mengalami Double-debit',
                  style: GoogleFonts.inter(fontSize: 15, color: CupertinoColors.activeBlue),
                ),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () => _submitDispute(context, tx, 'fraud'),
                child: Text(
                  'Ini Bukan Transaksi Saya',
                  style: GoogleFonts.inter(fontSize: 15),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () => _submitDispute(context, tx, 'wrong_amount'),
                child: Text(
                  'Nominal Salah / Berbeda',
                  style: GoogleFonts.inter(fontSize: 15, color: CupertinoColors.activeBlue),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Kembali',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            child: Container(
              color: AppTheme.surfaceCard,
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppTheme.textDisabled,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Icon(Icons.shield_outlined, color: AppTheme.errorRed, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'Laporkan Masalah In-App',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Kami akan melacak laporan Anda secara real-time langsung dari aplikasi. Tidak perlu melakukan panggilan telepon telepon luar.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppTheme.textLightGray,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDisputeOption(
                    icon: Icons.double_arrow_rounded,
                    title: 'Saya Mengalami Double-debit',
                    subtitle: 'Saldo berkurang dua kali untuk transaksi ini.',
                    onTap: () => _submitDispute(context, tx, 'double_debit'),
                  ),
                  const SizedBox(height: 12),
                  _buildDisputeOption(
                    icon: Icons.no_accounts_outlined,
                    title: 'Ini Bukan Transaksi Saya',
                    subtitle: 'Laporkan kemungkinan fraud kartu atau device.',
                    onTap: () => _submitDispute(context, tx, 'fraud'),
                  ),
                  const SizedBox(height: 12),
                  _buildDisputeOption(
                    icon: Icons.money_off_rounded,
                    title: 'Nominal Salah / Berbeda',
                    subtitle: 'Harga merchant tidak sesuai dengan resi.',
                    onTap: () => _submitDispute(context, tx, 'wrong_amount'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void _submitDispute(BuildContext context, Transaction tx, String reason) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Dispute Berhasil Diajukan! Tiket #${tx.id.toUpperCase()} sedang kami proses (SLA: 2 Jam).',
          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppTheme.shariaGreen,
      ),
    );
  }

  Widget _buildDisputeOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppTheme.primaryBlue, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.textLightGray,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 12, color: AppTheme.textLightGray),
          ],
        ),
      ),
    );
  }
}

// Vector Map Drawing for premium native look
class MapVectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = const Color(0xFFE5EEFF);
    canvas.drawRect(Offset.zero & size, bgPaint);

    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final roadBorderPaint = Paint()
      ..color = const Color(0xFFC3C6D6).withOpacity(0.5)
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw main diagonal road
    final path = Path()
      ..moveTo(-20, size.height * 0.2)
      ..lineTo(size.width * 0.4, size.height * 0.5)
      ..lineTo(size.width + 20, size.height * 0.9);

    canvas.drawPath(path, roadBorderPaint);
    canvas.drawPath(path, roadPaint);

    // Draw intersecting vertical road
    final path2 = Path()
      ..moveTo(size.width * 0.6, -20)
      ..lineTo(size.width * 0.5, size.height * 0.4)
      ..lineTo(size.width * 0.2, size.height + 20);

    canvas.drawPath(path2, roadBorderPaint);
    canvas.drawPath(path2, roadPaint);

    // Draw stylized greenery/parks
    final parkPaint = Paint()..color = const Color(0xFFD0F2E1).withOpacity(0.8);
    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.8), 40, parkPaint);
    canvas.drawCircle(Offset(size.width * 0.85, size.height * 0.25), 50, parkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
