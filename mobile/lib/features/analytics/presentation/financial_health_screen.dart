import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class FinancialHealthScreen extends StatelessWidget {
  const FinancialHealthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int score = 78; // excellent rating

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Financial Health Score',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark),
        ),
        leading: IconButton(
          icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE8EEFF)),
                boxShadow: AppTheme.premiumShadow,
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: score / 100,
                            strokeWidth: 10,
                            backgroundColor: const Color(0xFFF1F3FF),
                            color: AppTheme.shariaGreen,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              score.toString(),
                              style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w900, color: AppTheme.textDark),
                            ),
                            Text(
                              'Sehat',
                              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.shariaGreen),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Skor Anda Lebih Baik dari 84% Pengguna Lain',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLightGray, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Parameter Analisis',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
              ),
            ),
            const SizedBox(height: 12),
            _buildMetricTile(
              'Rasio Menabung (Savings Rate)',
              '35% dari pendapatan disisihkan',
              'Sangat Baik',
              AppTheme.shariaGreen,
            ),
            _buildMetricTile(
              'Dana Darurat (Emergency Fund)',
              '3.5 bulan biaya hidup aman',
              'Perlu Ditingkatkan',
              Colors.orange,
            ),
            _buildMetricTile(
              'Rasio Utang (Debt-to-Income)',
              'Tagihan bulanan hanya 12% dari pemasukan',
              'Sangat Sehat',
              AppTheme.shariaGreen,
            ),
            const SizedBox(height: 28),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Saran AI Financial Planner',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.04),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.wb_incandescent_outlined, color: AppTheme.primaryBlue, size: 22),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rekomendasi Alokasi Dana Darurat',
                          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Untuk menyempurnakan skor Anda menuju level optimal, tingkatkan tabungan dana darurat Anda hingga setara dengan 6 bulan pengeluaran bulanan melalui fitur Autosave Round-up.',
                          style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile(String title, String subtitle, String status, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EEFF)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                const SizedBox(height: 2),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.08), borderRadius: BorderRadius.circular(6)),
            child: Text(
              status,
              style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: color),
            ),
          ),
        ],
      ),
    );
  }
}
