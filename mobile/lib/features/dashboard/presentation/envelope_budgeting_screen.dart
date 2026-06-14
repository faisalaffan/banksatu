import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class EnvelopeBudgetingScreen extends StatefulWidget {
  const EnvelopeBudgetingScreen({Key? key}) : super(key: key);

  @override
  State<EnvelopeBudgetingScreen> createState() => _EnvelopeBudgetingScreenState();
}

class _EnvelopeBudgetingScreenState extends State<EnvelopeBudgetingScreen> {
  final List<Map<String, dynamic>> _envelopes = [
    {
      'name': 'Makanan & Minuman',
      'allocated': 3000000.0,
      'spent': 1850000.0,
      'hardStop': true,
      'color': Colors.orange
    },
    {
      'name': 'Transportasi Harian',
      'allocated': 1000000.0,
      'spent': 450000.0,
      'hardStop': false,
      'color': Colors.blue
    },
    {
      'name': 'Hiburan & Liburan',
      'allocated': 2000000.0,
      'spent': 1980000.0,
      'hardStop': true,
      'color': Colors.purple
    },
  ];

  void _createNewEnvelope() {
    final nameController = TextEditingController();
    final limitController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Buat Pos Anggaran Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nama Pos (e.g. Belanja)')),
            const SizedBox(height: 12),
            TextField(controller: limitController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Alokasi Dana (Rp)')),
          ],
        ),
        actions: [
          TextButton(child: const Text('Batal'), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: const Text('Simpan'),
            onPressed: () {
              final name = nameController.text.trim();
              final limitVal = double.tryParse(limitController.text) ?? 0.0;
              if (name.isNotEmpty && limitVal > 0) {
                setState(() {
                  _envelopes.add({
                    'name': name,
                    'allocated': limitVal,
                    'spent': 0.0,
                    'hardStop': false,
                    'color': Colors.teal,
                  });
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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Envelope Budgeting',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pos Pengeluaran Teratur',
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                ),
                TextButton(
                  onPressed: _createNewEnvelope,
                  child: const Text('+ Tambah Pos'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _envelopes.length,
              itemBuilder: (context, index) {
                final env = _envelopes[index];
                double ratio = env['spent'] / env['allocated'];
                bool isWarning = ratio >= 0.9;

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
                          Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(color: env['color'], shape: BoxShape.circle),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                env['name'],
                                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                              ),
                            ],
                          ),
                          Text(
                            '${(ratio * 100).toInt()}%',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: isWarning ? AppTheme.errorRed : AppTheme.textDark,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      LinearProgressIndicator(
                        value: ratio.clamp(0.0, 1.0),
                        backgroundColor: const Color(0xFFF1F3FF),
                        color: isWarning ? AppTheme.errorRed : env['color'],
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Terpakai Rp ${env['spent'].toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                          ),
                          Text(
                            'Alokasi Rp ${env['allocated'].toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Fitur Hard Stop',
                                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Tolak otomatis transaksi baru jika anggaran telah habis terpakai.',
                                  style: GoogleFonts.inter(fontSize: 9, color: AppTheme.textLightGray, height: 1.3),
                                ),
                              ],
                            ),
                          ),
                          Switch.adaptive(
                            value: env['hardStop'],
                            activeColor: AppTheme.shariaGreen,
                            onChanged: (val) {
                              setState(() {
                                env['hardStop'] = val;
                              });
                            },
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
