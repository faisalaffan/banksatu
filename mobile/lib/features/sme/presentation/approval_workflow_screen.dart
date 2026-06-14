import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class ApprovalWorkflowScreen extends StatefulWidget {
  const ApprovalWorkflowScreen({Key? key}) : super(key: key);

  @override
  State<ApprovalWorkflowScreen> createState() => _ApprovalWorkflowScreenState();
}

class _ApprovalWorkflowScreenState extends State<ApprovalWorkflowScreen> {
  final List<Map<String, dynamic>> _queue = [
    {
      'id': 'tx_9920',
      'title': 'Pembelian Kertas & Atk Toko',
      'requester': 'Rudi (Kasir)',
      'amount': 450000.0,
      'date': 'Hari ini, 10:15',
    },
    {
      'id': 'tx_9921',
      'title': 'Sewa Vendor Logistik Bulanan',
      'requester': 'Siti (Operasional)',
      'amount': 7500000.0,
      'date': 'Kemarin, 16:40',
    },
  ];

  void _approve(int index) {
    setState(() {
      _queue.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaksi disetujui dan segera diproses!')),
    );
  }

  void _reject(int index) {
    setState(() {
      _queue.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaksi ditolak.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Approval Workflow',
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
              'Menunggu Persetujuan Anda',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 6),
            Text(
              'Otorisasi transaksi bisnis di atas limit yang diajukan oleh staf/kasir Anda.',
              style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLightGray, height: 1.4),
            ),
            const SizedBox(height: 24),
            _queue.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Icon(Icons.done_all, size: 64, color: AppTheme.textDisabled),
                          const SizedBox(height: 12),
                          Text('Semua pengajuan transaksi telah diproses.', style: GoogleFonts.inter(color: AppTheme.textLightGray)),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _queue.length,
                    itemBuilder: (context, index) {
                      final q = _queue[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFE8EEFF)),
                          boxShadow: AppTheme.premiumShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: AppTheme.primaryBlue.withOpacity(0.08), borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    q['id'],
                                    style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.bold, color: AppTheme.primaryBlue),
                                  ),
                                ),
                                Text(q['date'], style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              q['title'],
                              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Diajukan oleh: ${q['requester']}',
                              style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Rp ${q['amount'].toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900, color: AppTheme.primaryBlue),
                            ),
                            const Divider(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton(
                                  onPressed: () => _reject(index),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppTheme.errorRed,
                                    side: const BorderSide(color: Color(0xFFF1F3FF)),
                                  ),
                                  child: const Text('Tolak'),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () => _approve(index),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.shariaGreen,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('Setujui'),
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
