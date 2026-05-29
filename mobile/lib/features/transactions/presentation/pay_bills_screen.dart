import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/core/router/app_router.dart';

class PayBillsScreen extends StatelessWidget {
  const PayBillsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Bayar Tagihan',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Header
            Text(
              'Pilih Kategori Tagihan',
              style: GoogleFonts.inter(
                color: AppTheme.textDark,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Pembayaran utilitas bulanan aman, praktis, dan otomatis.',
              style: GoogleFonts.inter(
                color: AppTheme.textLightGray,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),

            // Bento Grid of Billers
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildBentoItem(
                  context,
                  icon: Platform.isIOS ? CupertinoIcons.bolt_fill : Icons.bolt,
                  title: 'Listrik PLN',
                  subtitle: 'Token & Tagihan',
                  color: const Color(0xFFFFF9E6),
                  iconColor: Colors.amber,
                  onTap: () => const PLNDetailRoute().push(context),
                ),
                _buildBentoItem(
                  context,
                  icon: Platform.isIOS ? CupertinoIcons.drop_fill : Icons.water_drop,
                  title: 'Air PDAM',
                  subtitle: 'Tagihan Utilitas',
                  color: const Color(0xFFE6F3FF),
                  iconColor: Colors.blue,
                  onTap: () => _showComingSoon(context, 'Air PDAM'),
                ),
                _buildBentoItem(
                  context,
                  icon: Platform.isIOS ? CupertinoIcons.phone_fill : Icons.phone_android,
                  title: 'Pulsa & Data',
                  subtitle: 'Top Up Instan',
                  color: const Color(0xFFF1F3FF),
                  iconColor: AppTheme.primaryBlue,
                  onTap: () => _showComingSoon(context, 'Pulsa & Data'),
                ),
                _buildBentoItem(
                  context,
                  icon: Platform.isIOS ? CupertinoIcons.heart_fill : Icons.favorite,
                  title: 'BPJS Kesehatan',
                  subtitle: 'Iuran Bulanan',
                  color: const Color(0xFFE6F7ED),
                  iconColor: AppTheme.shariaGreen,
                  onTap: () => _showComingSoon(context, 'BPJS Kesehatan'),
                ),
                _buildBentoItem(
                  context,
                  icon: Platform.isIOS ? CupertinoIcons.tv_fill : Icons.tv,
                  title: 'Internet & TV',
                  subtitle: 'Kabel & Wi-Fi',
                  color: const Color(0xFFFBF1FF),
                  iconColor: Colors.purple,
                  onTap: () => _showComingSoon(context, 'Internet & TV'),
                ),
                _buildBentoItem(
                  context,
                  icon: Platform.isIOS ? CupertinoIcons.creditcard_fill : Icons.credit_card,
                  title: 'Kartu Kredit',
                  subtitle: 'Bayar Tagihan',
                  color: const Color(0xFFFFF1F1),
                  iconColor: AppTheme.errorRed,
                  onTap: () => _showComingSoon(context, 'Kartu Kredit'),
                ),
              ],
            ),
            const SizedBox(height: 36),

            // Recent Bill payments list
            Text(
              'Tagihan Terakhir',
              style: GoogleFonts.inter(
                color: AppTheme.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecentBillCard(
              Platform.isIOS ? CupertinoIcons.bolt_fill : Icons.bolt,
              'PLN Pascabayar - Faisal Affan',
              'ID: 532104928392 • Rp 450.000',
              'Sudah Dibayar - 12 Mei',
            ),
            const SizedBox(height: 12),
            _buildRecentBillCard(
              Platform.isIOS ? CupertinoIcons.phone_fill : Icons.phone_android,
              'Telkomsel Halo - Faisal Affan',
              'No: 08111222333 • Rp 150.000',
              'Sudah Dibayar - 05 Mei',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBentoItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: AppTheme.premiumShadow,
          border: Border.all(color: const Color(0xFFE8EEFF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: AppTheme.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: AppTheme.textLightGray,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentBillCard(
    IconData icon,
    String title,
    String subtitle,
    String status,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EEFF)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryBlue,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: AppTheme.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: AppTheme.textLightGray,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: GoogleFonts.inter(
              color: AppTheme.shariaGreen,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context, String biller) {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: Text('Pembayaran $biller'),
              content: const Text(
                  'Fitur pembayaran tagihan ini akan segera hadir pada update berikutnya.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )
          : AlertDialog(
              title: Text('Pembayaran $biller'),
              content: const Text(
                  'Fitur pembayaran tagihan ini akan segera hadir pada update berikutnya.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
    );
  }
}
