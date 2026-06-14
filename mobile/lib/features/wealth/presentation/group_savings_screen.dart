import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class GroupSavingsScreen extends StatefulWidget {
  const GroupSavingsScreen({Key? key}) : super(key: key);

  @override
  State<GroupSavingsScreen> createState() => _GroupSavingsScreenState();
}

class _GroupSavingsScreenState extends State<GroupSavingsScreen> {
  final double _targetAmount = 25000000.0;
  double _collectedAmount = 14500000.0;

  final List<Map<String, dynamic>> _contributors = [
    {'name': 'You (Faisal)', 'amount': 6000000.0, 'avatar': 'FA', 'role': 'Inisiator'},
    {'name': 'Adinda Larasati', 'amount': 4500000.0, 'avatar': 'AL', 'role': 'Anggota'},
    {'name': 'Budi Pratama', 'amount': 4000000.0, 'avatar': 'BP', 'role': 'Anggota'},
  ];

  void _contributeUang() {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Setor Dana Patungan'),
        content: TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Nominal Setoran (Rp)', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(child: const Text('Batal'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Setor'),
            onPressed: () {
              final val = double.tryParse(amountController.text) ?? 0.0;
              if (val > 0) {
                setState(() {
                  _collectedAmount += val;
                  _contributors[0]['amount'] += val;
                });
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double percent = (_collectedAmount / _targetAmount).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Tabungan Bersama (Group Goal)',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Dana Liburan Akhir Tahun',
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: AppTheme.shariaGreen.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'Aktif',
                          style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold, color: AppTheme.shariaGreen),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: percent,
                    backgroundColor: const Color(0xFFF1F3FF),
                    color: AppTheme.primaryBlue,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Terkumpul Rp ${_collectedAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                        style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                      ),
                      Text(
                        'Target Rp ${_targetAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Rincian Kontribusi Anggota',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _contributors.length,
              itemBuilder: (context, index) {
                final c = _contributors[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE8EEFF)),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppTheme.primaryBlue,
                        child: Text(c['avatar'], style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c['name'], style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                            Text(c['role'], style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray)),
                          ],
                        ),
                      ),
                      Text(
                        'Rp ${c['amount'].toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF1F3FF))),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _contributeUang,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              ),
              child: Text('Setor Dana Patungan', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
