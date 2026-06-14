import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class ExportReportScreen extends StatefulWidget {
  const ExportReportScreen({Key? key}) : super(key: key);

  @override
  State<ExportReportScreen> createState() => _ExportReportScreenState();
}

class _ExportReportScreenState extends State<ExportReportScreen> {
  String _selectedPeriod = 'Bulan Ini';
  String _selectedFormat = 'PDF';
  bool _isExporting = false;
  double _exportProgress = 0.0;

  void _startExport() {
    setState(() {
      _isExporting = true;
      _exportProgress = 0.0;
    });

    // Simulate progress updates
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return false;
      setState(() {
        _exportProgress += 0.08;
      });
      if (_exportProgress >= 1.0) {
        setState(() {
          _exportProgress = 1.0;
          _isExporting = false;
        });
        _showSuccessDialog();
        return false;
      }
      return true;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Unduhan Selesai'),
              content: Text('Laporan transaksi periode $_selectedPeriod berhasil disimpan sebagai file $_selectedFormat.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Buka File'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  child: const Text('Tutup'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Unduhan Selesai'),
              content: Text('Laporan transaksi periode $_selectedPeriod berhasil disimpan sebagai file $_selectedFormat.'),
              actions: [
                TextButton(
                  child: const Text('Buka File'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Tutup'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Ekspor Laporan Transaksi',
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
              'Konfigurasi Ekspor',
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
                  DropdownButtonFormField<String>(
                    value: _selectedPeriod,
                    items: ['Bulan Ini', 'Bulan Lalu', '3 Bulan Terakhir', 'Custom Range']
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedPeriod = val!),
                    decoration: const InputDecoration(labelText: 'Pilih Periode', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('PDF'),
                          value: 'PDF',
                          groupValue: _selectedFormat,
                          activeColor: AppTheme.primaryBlue,
                          onChanged: (val) => setState(() => _selectedFormat = val!),
                        ),
                      ),
                      Expanded(
                        child: RadioListTile<String>(
                          title: const Text('CSV'),
                          value: 'CSV',
                          groupValue: _selectedFormat,
                          activeColor: AppTheme.primaryBlue,
                          onChanged: (val) => setState(() => _selectedFormat = val!),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  if (_isExporting) ...[
                    Text(
                      'Mengekspor berkas... ${(_exportProgress * 100).toInt()}%',
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: _exportProgress,
                      backgroundColor: const Color(0xFFF1F3FF),
                      color: AppTheme.primaryBlue,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ] else
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: _startExport,
                        icon: const Icon(Icons.download),
                        label: Text('Unduh Laporan', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
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
          ],
        ),
      ),
    );
  }
}
