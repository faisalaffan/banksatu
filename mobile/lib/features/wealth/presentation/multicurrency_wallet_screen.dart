import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class CurrencyWallet {
  final String code;
  final String name;
  final double balance;
  final String symbol;
  final String flag;

  CurrencyWallet({
    required this.code,
    required this.name,
    required this.balance,
    required this.symbol,
    required this.flag,
  });
}

class MulticurrencyWalletScreen extends StatelessWidget {
  const MulticurrencyWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CurrencyWallet> wallets = [
      CurrencyWallet(code: 'IDR', name: 'Rupiah Indonesia', balance: 45200000.0, symbol: 'Rp', flag: '🇮🇩'),
      CurrencyWallet(code: 'USD', name: 'Dolar Amerika Serikat', balance: 1250.50, symbol: '\$', flag: '🇺🇸'),
      CurrencyWallet(code: 'EUR', name: 'Euro', balance: 800.0, symbol: '€', flag: '🇪🇺'),
      CurrencyWallet(code: 'SGD', name: 'Dolar Singapura', balance: 500.0, symbol: 'S\$', flag: '🇸🇬'),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Multi-currency Wallet'),
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
              // Summary card of total assets in equivalent IDR
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryBlue, Color(0xFF0C56D0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withOpacity(0.3),
                      offset: const Offset(0, 12),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL SETARA RUPIAH (ESTIMASI)',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Rp 75.320.000',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Mencakup 4 valuta asing aktif',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Wallets list header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SALDO SETIAP VALUTA',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLightGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Action to convert FX
                    },
                    child: Text(
                      'Tukar Valas',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Wallet Item List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: wallets.length,
                itemBuilder: (context, index) {
                  final w = wallets[index];
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
                        Text(
                          w.flag,
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                w.code,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                w.name,
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppTheme.textLightGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${w.symbol} ${w.balance.toStringAsFixed(index == 0 ? 0 : 2)}',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
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
