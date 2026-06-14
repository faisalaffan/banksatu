import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class KYCSuccessScreen extends StatelessWidget {
  const KYCSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Fully completed Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Premium Glowing Green Checkmark Circle
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.shariaGreenLight,
                            AppTheme.shariaGreen,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.shariaGreen.withOpacity(0.3),
                            blurRadius: 32,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Congratulatory Copy
                    Text(
                      'Identitas Terverifikasi!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppTheme.primaryBlue,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Selamat! Akun BankSatu Anda telah aktif dan diverifikasi oleh sistem. Anda sekarang siap menjelajahi seluruh fitur perbankan digital premium kami.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: AppTheme.textLightGray,
                          fontSize: 14,
                          height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Benefit Icons Grid (Visual assurance of activated perks)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: AppTheme.premiumShadow,
                        border: Border.all(color: const Color(0xFFE8EEFF)),
                      ),
                      child: Column(
                        children: [
                          _buildPerkRow(
                            Platform.isIOS ? CupertinoIcons.shield_fill : Icons.verified_user,
                            'Perlindungan Akun Maksimal',
                            'Koneksi terenkripsi penuh & proteksi biometrik.',
                          ),
                          const Divider(height: 24, color: Color(0xFFF1F3FF)),
                          _buildPerkRow(
                            Platform.isIOS ? CupertinoIcons.bolt_fill : Icons.offline_bolt,
                            'Transfer & Transaksi Instan',
                            'Nikmati transfer gratis biaya admin dan QRIS instan.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Mulai Menjelajah Button (Navigates to Dashboard)
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to root (Dashboard) using GoRouter
                    GoRouter.of(context).go('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Mulai Menjelajah',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerkRow(IconData icon, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppTheme.primaryBlue,
          size: 20,
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
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: AppTheme.textLightGray,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
