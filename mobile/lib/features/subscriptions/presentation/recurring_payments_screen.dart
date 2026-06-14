import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class RecurringPaymentsScreen extends StatefulWidget {
  const RecurringPaymentsScreen({Key? key}) : super(key: key);

  @override
  State<RecurringPaymentsScreen> createState() => _RecurringPaymentsScreenState();
}

class _RecurringPaymentsScreenState extends State<RecurringPaymentsScreen> {
  final List<Map<String, dynamic>> _payments = [
    {
      'title': 'Tagihan Listrik PLN Pascabayar',
      'category': 'Utilitas Harian',
      'amount': 450000.0,
      'nextBilling': '20 Jun 2026',
      'icon': Icons.lightbulb_outline,
    },
    {
      'title': 'Langganan WiFi Indihome',
      'category': 'Internet & TV',
      'amount': 380000.0,
      'nextBilling': '25 Jun 2026',
      'icon': Icons.wifi,
    },
    {
      'title': 'Iuran Asuransi BPJS Kesehatan',
      'category': 'Asuransi & Proteksi',
      'amount': 150000.0,
      'nextBilling': '01 Jul 2026',
      'icon': Icons.health_and_safety_outlined,
    },
  ];

  void _cancelAutoDebit(int index) {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Batalkan Auto-debit?'),
              content: Text('Sistem tidak akan melakukan autodebit otomatis untuk ${_payments[index]['title']} pada bulan berikutnya.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Kembali'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Batalkan'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _payments.removeAt(index);
                    });
                  },
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Batalkan Auto-debit?'),
              content: Text('Sistem tidak akan melakukan autodebit otomatis untuk ${_payments[index]['title']} pada bulan berikutnya.'),
              actions: [
                TextButton(
                  child: const Text('Kembali'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Batalkan', style: TextStyle(color: AppTheme.errorRed)),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _payments.removeAt(index);
                    });
                  },
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
          'Recurring Payments',
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
              'Pembayaran Auto-debit Aktif',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 6),
            Text(
              'Daftar pembayaran bulanan Anda yang otomatis ditarik dari saldo rekening utama.',
              style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLightGray, height: 1.4),
            ),
            const SizedBox(height: 24),
            _payments.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Icon(Icons.check_circle_outline, size: 64, color: AppTheme.textDisabled),
                          const SizedBox(height: 12),
                          Text('Tidak ada pembayaran autodebit aktif.', style: GoogleFonts.inter(color: AppTheme.textLightGray)),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _payments.length,
                    itemBuilder: (context, index) {
                      final p = _payments[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE8EEFF)),
                          boxShadow: AppTheme.premiumShadow,
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.06),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(p['icon'], color: AppTheme.primaryBlue, size: 22),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p['title'],
                                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    p['category'],
                                    style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Jatuh Tempo: ${p['nextBilling']}',
                                    style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Rp ${p['amount'].toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w900, color: AppTheme.textDark),
                                ),
                                const SizedBox(height: 4),
                                TextButton(
                                  onPressed: () => _cancelAutoDebit(index),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    foregroundColor: AppTheme.errorRed,
                                  ),
                                  child: const Text('Batalkan', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
