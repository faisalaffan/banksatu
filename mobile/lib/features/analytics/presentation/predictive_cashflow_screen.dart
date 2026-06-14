import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class PredictiveCashflowScreen extends StatelessWidget {
  const PredictiveCashflowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Projections data 4 weeks ahead
    final List<double> projections = [25.8, 18.2, 12.5, 42.0];
    final List<String> weeks = ['Minggu 1', 'Minggu 2', 'Minggu 3', 'Minggu 4'];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Predictive Cashflow',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Proyeksi Saldo 30 Hari Ke Depan',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 16),
            Container(
              height: 180,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8EEFF)),
                boxShadow: AppTheme.premiumShadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(projections.length, (index) {
                  final val = projections[index];
                  final height = (val / 50.0) * 110.0;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Rp ${val.toStringAsFixed(1)}jt',
                        style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 30,
                        height: height.clamp(5.0, 110.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              val > 15 ? AppTheme.primaryBlue : AppTheme.errorRed,
                              val > 15 ? AppTheme.primaryBlue.withOpacity(0.6) : AppTheme.errorRed.withOpacity(0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        weeks[index],
                        style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray, fontWeight: FontWeight.w600),
                      ),
                    ],
                  );
                }),
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Agenda Finansial Mendatang',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 12),
            _buildTimelineItem(
              'Pembayaran Tagihan Listrik PLN',
              'Auto-debit terjadwal pada Minggu 2',
              '- Rp 450.000',
              Colors.red,
            ),
            _buildTimelineItem(
              'Potensi Defisit Saldo Harian',
              'Prediksi saldo terendah pada Minggu 3 sebelum gajian',
              'Peringatan AI',
              Colors.orange,
            ),
            _buildTimelineItem(
              'Penerimaan Gaji (Salary Deposit)',
              'Pemasukan rutin terdeteksi awal Minggu 4',
              '+ Rp 30.000.000',
              AppTheme.shariaGreen,
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.06),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.withOpacity(0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Peringatan Defisit Aset',
                          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Berdasarkan histori transaksi, saldo Anda pada minggu ke-3 diprediksi mendekati batas minimum pengeluaran. AI menyarankan penundaan belanja kategori hiburan hingga deposit gaji masuk.',
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

  Widget _buildTimelineItem(String title, String desc, String value, Color color) {
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
                Text(desc, style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray)),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }
}
