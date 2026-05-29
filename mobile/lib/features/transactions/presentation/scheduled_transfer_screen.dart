import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/theme/app_theme.dart';

class ScheduledTransferScreen extends StatefulWidget {
  const ScheduledTransferScreen({Key? key}) : super(key: key);

  @override
  State<ScheduledTransferScreen> createState() => _ScheduledTransferScreenState();
}

class _ScheduledTransferScreenState extends State<ScheduledTransferScreen> {
  final TextEditingController _receiverController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _thresholdController = TextEditingController();

  String _frequency = 'Bulanan';
  bool _conditionalEnabled = true;

  @override
  void dispose() {
    _receiverController.dispose();
    _amountController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  void _saveSchedule() {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Otomatisasi Disimpan'),
              content: const Text(
                  'Transfer bersyarat berhasil dijadwalkan dan akan dieksekusi secara otomatis oleh sistem.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Kembali ke Beranda'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    GoRouter.of(context).go('/');
                  },
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Otomatisasi Disimpan'),
              content: const Text(
                  'Transfer bersyarat berhasil dijadwalkan dan akan dieksekusi secara otomatis oleh sistem.'),
              actions: [
                TextButton(
                  child: const Text('Kembali ke Beranda'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    GoRouter.of(context).go('/');
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
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Transfer Bersyarat',
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
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            Text(
              'Otomatisasi Keuangan',
              style: GoogleFonts.inter(
                color: AppTheme.textDark,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Atur aturan otomatisasi transfer berdasarkan jadwal atau ambang batas saldo tertentu.',
              style: GoogleFonts.inter(
                color: AppTheme.textLightGray,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),

            // Parameters Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.premiumShadow,
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Receiver
                  Text(
                    'Rekening Penerima',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _receiverController,
                    decoration: InputDecoration(
                      hintText: 'Nomor rekening atau nama penerima',
                      prefixIcon: Icon(
                        Platform.isIOS ? CupertinoIcons.person_solid : Icons.account_box,
                        color: AppTheme.textLightGray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Amount
                  Text(
                    'Nominal Eksekusi',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nominal',
                      prefixIcon: Icon(
                        Platform.isIOS ? CupertinoIcons.money_dollar_circle : Icons.monetization_on,
                        color: AppTheme.textLightGray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Frequency
                  Text(
                    'Frekuensi Eksekusi',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildFrequencyChip('Harian'),
                      const SizedBox(width: 8),
                      _buildFrequencyChip('Mingguan'),
                      const SizedBox(width: 8),
                      _buildFrequencyChip('Bulanan'),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Conditional threshold toggle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Eksekusi Bersyarat',
                            style: GoogleFonts.inter(
                              color: AppTheme.textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Kirim hanya jika syarat saldo terpenuhi',
                            style: GoogleFonts.inter(
                              color: AppTheme.textLightGray,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _conditionalEnabled,
                        activeColor: AppTheme.shariaGreen,
                        onChanged: (val) {
                          setState(() {
                            _conditionalEnabled = val;
                          });
                        },
                      ),
                    ],
                  ),

                  if (_conditionalEnabled) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Batas Minimum Saldo Rekening Anda',
                      style: GoogleFonts.inter(
                        color: AppTheme.textDark,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _thresholdController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Misal: Saldo harus di atas Rp 2.000.000',
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 100),
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
              onPressed: _saveSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                'Jadwalkan Transfer',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFrequencyChip(String label) {
    final active = _frequency == label;
    return ChoiceChip(
      label: Text(label),
      selected: active,
      labelStyle: GoogleFonts.inter(
        color: active ? Colors.white : AppTheme.textDark,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      selectedColor: AppTheme.primaryBlue,
      backgroundColor: const Color(0xFFF1F3FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      side: const BorderSide(color: Colors.transparent),
      onSelected: (val) {
        if (val) {
          setState(() {
            _frequency = label;
          });
        }
      },
    );
  }
}
