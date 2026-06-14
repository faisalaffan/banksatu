import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class TaxReportScreen extends StatefulWidget {
  const TaxReportScreen({Key? key}) : super(key: key);

  @override
  State<TaxReportScreen> createState() => _TaxReportScreenState();
}

class _TaxReportScreenState extends State<TaxReportScreen> {
  bool _isExporting = false;

  void _exportTaxForm() {
    setState(() {
      _isExporting = true;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
        showDialog(
          context: context,
          builder: (context) => Platform.isIOS
              ? CupertinoAlertDialog(
                  title: const Text('Unduh Berhasil'),
                  content: const Text('Rekap Lampiran Harta & Pendapatan SPT tahunan berhasil disimpan ke berkas lokal.'),
                  actions: [
                    CupertinoDialogAction(child: const Text('OK'), onPressed: () => Navigator.pop(context)),
                  ],
                )
              : AlertDialog(
                  title: const Text('Unduh Berhasil'),
                  content: const Text('Rekap Lampiran Harta & Pendapatan SPT tahunan berhasil disimpan ke berkas lokal.'),
                  actions: [
                    TextButton(child: const Text('OK'), onPressed: () => Navigator.pop(context)),
                  ],
                ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Rekap Pajak (SPT)',
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
              'Harta & Saldo Akhir Tahun (31 Des)',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8EEFF)),
                boxShadow: AppTheme.premiumShadow,
              ),
              child: Column(
                children: [
                  _buildTaxRow('Tabungan BankSatu', 'Rp 25.800.000'),
                  const Divider(height: 20),
                  _buildTaxRow('Portofolio Reksa Dana', 'Rp 32.500.000'),
                  const Divider(height: 20),
                  _buildTaxRow('Tabungan Emas Syariah', 'Rp 10.350.000'),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Harta Terlapor:', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                      Text('Rp 68.650.000', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w900, color: AppTheme.primaryBlue)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Penghasilan & Bagi Hasil (Net)',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE8EEFF)),
                boxShadow: AppTheme.premiumShadow,
              ),
              child: Column(
                children: [
                  _buildTaxRow('Bagi Hasil Deposito Mudharabah', 'Rp 1.450.000'),
                  const Divider(height: 20),
                  _buildTaxRow('Imbal Hasil Reksa Dana Pasar Uang', 'Rp 2.150.000'),
                  const Divider(height: 20),
                  _buildTaxRow('Pajak PPh Final Terpotong (20%)', '- Rp 290.000', isNegative: true),
                ],
              ),
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isExporting ? null : _exportTaxForm,
                icon: _isExporting
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.picture_as_pdf),
                label: Text(
                  _isExporting ? 'Mengekspor berkas...' : 'Unduh Form Lampiran SPT',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxRow(String title, String val, {bool isNegative = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLightGray, fontWeight: FontWeight.w600)),
        Text(val, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: isNegative ? AppTheme.errorRed : AppTheme.textDark)),
      ],
    );
  }
}
