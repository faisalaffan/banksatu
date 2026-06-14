import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class LimitItem {
  final String title;
  final String description;
  double currentValue;
  final double maxValue;
  final double minValue;

  LimitItem({
    required this.title,
    required this.description,
    required this.currentValue,
    required this.maxValue,
    required this.minValue,
  });
}

class CardLimitSettingsScreen extends StatefulWidget {
  const CardLimitSettingsScreen({Key? key}) : super(key: key);

  @override
  State<CardLimitSettingsScreen> createState() => _CardLimitSettingsScreenState();
}

class _CardLimitSettingsScreenState extends State<CardLimitSettingsScreen> {
  final List<LimitItem> _limits = [
    LimitItem(
      title: 'Limit Tarik Tunai ATM',
      description: 'Batas harian penarikan uang tunai di mesin ATM.',
      currentValue: 10000000.0,
      minValue: 1000000.0,
      maxValue: 25000000.0,
    ),
    LimitItem(
      title: 'Limit Transaksi EDC (Mesin Gesek)',
      description: 'Batas harian pembayaran fisik di kasir toko retail.',
      currentValue: 20000000.0,
      minValue: 1000000.0,
      maxValue: 50000000.0,
    ),
    LimitItem(
      title: 'Limit Transfer Dana Harian',
      description: 'Batas harian transfer antar-bank atau sesama BankSatu.',
      currentValue: 25000000.0,
      minValue: 5000000.0,
      maxValue: 100000000.0,
    ),
  ];

  String _formatCurrency(double amount) {
    return 'Rp ${(amount / 1000000).toStringAsFixed(0)} Juta';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pengaturan Limit Kartu'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.shield_outlined, color: AppTheme.primaryBlue, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Mengatur limit kartu dengan bijak dapat meminimalkan risiko kerugian akibat penyalahgunaan kartu.',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.textLightGray,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Limit sliders
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _limits.length,
                itemBuilder: (context, index) {
                  final limit = _limits[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
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
                            Text(
                              limit.title,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                            Text(
                              _formatCurrency(limit.currentValue),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          limit.description,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.textLightGray,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Platform.isIOS
                            ? SizedBox(
                                width: double.infinity,
                                child: CupertinoSlider(
                                  value: limit.currentValue,
                                  min: limit.minValue,
                                  max: limit.maxValue,
                                  activeColor: AppTheme.primaryBlue,
                                  onChanged: (val) {
                                    setState(() {
                                      limit.currentValue = val;
                                    });
                                  },
                                ),
                              )
                            : SliderTheme(
                                data: SliderThemeData(
                                  activeTrackColor: AppTheme.primaryBlue,
                                  inactiveTrackColor: const Color(0xFFE3E8F9),
                                  thumbColor: AppTheme.primaryBlue,
                                  trackHeight: 4,
                                ),
                                child: Slider(
                                  value: limit.currentValue,
                                  min: limit.minValue,
                                  max: limit.maxValue,
                                  onChanged: (val) {
                                    setState(() {
                                      limit.currentValue = val;
                                    });
                                  },
                                ),
                              ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
