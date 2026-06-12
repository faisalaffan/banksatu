import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class FxRate {
  final String pair;
  final double buy;
  final double sell;
  final bool isUp;
  final String flag;

  FxRate({
    required this.pair,
    required this.buy,
    required this.sell,
    required this.isUp,
    required this.flag,
  });
}

class LiveFxRateScreen extends StatelessWidget {
  const LiveFxRateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<FxRate> rates = [
      FxRate(pair: 'USD/IDR', buy: 16210.0, sell: 16350.0, isUp: true, flag: '🇺🇸'),
      FxRate(pair: 'EUR/IDR', buy: 17450.0, sell: 17620.0, isUp: false, flag: '🇪🇺'),
      FxRate(pair: 'SGD/IDR', buy: 11980.0, sell: 12110.0, isUp: true, flag: '🇸🇬'),
      FxRate(pair: 'JPY/IDR', buy: 103.50, sell: 105.10, isUp: false, flag: '🇯🇵'),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Live FX Rates'),
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
              // Premium Info Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.sync_rounded, color: AppTheme.primaryBlue, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Nilai tukar diperbarui setiap 60 detik secara otomatis.',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.textLightGray,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Rates List Header
              Text(
                'NILAI TUKAR HARI INI',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // FX Cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rates.length,
                itemBuilder: (context, index) {
                  final r = rates[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE8EEFF)),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Row(
                      children: [
                        Text(r.flag, style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    r.pair,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    r.isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                                    color: r.isUp ? AppTheme.shariaGreen : AppTheme.errorRed,
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Beli: Rp ${r.buy.toStringAsFixed(0)}',
                                    style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Jual: Rp ${r.sell.toStringAsFixed(0)}',
                                    style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                                  ),
                                ],
                              ),
                            ],
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
