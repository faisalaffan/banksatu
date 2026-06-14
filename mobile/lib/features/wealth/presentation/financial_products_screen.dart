import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class FinancialProduct {
  final String title;
  final String description;
  final String risk;
  final String returnRate;
  final IconData icon;

  FinancialProduct({
    required this.title,
    required this.description,
    required this.risk,
    required this.returnRate,
    required this.icon,
  });
}

class FinancialProductsScreen extends StatelessWidget {
  const FinancialProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<FinancialProduct> products = [
      FinancialProduct(
        title: 'Reksa Dana Pasar Uang',
        description: 'Pilihan aman dengan likuiditas tinggi untuk investor pemula.',
        risk: 'Rendah',
        returnRate: '4.8% p.a.',
        icon: Platform.isIOS ? CupertinoIcons.square_stack_3d_up : Icons.stacked_line_chart_rounded,
      ),
      FinancialProduct(
        title: 'Obligasi Negara (SBN)',
        description: 'Investasi aman dijamin negara dengan kupon bulanan tetap.',
        risk: 'Sangat Rendah',
        returnRate: '6.2% p.a.',
        icon: Platform.isIOS ? CupertinoIcons.doc_text_viewfinder : Icons.account_balance_rounded,
      ),
      FinancialProduct(
        title: 'Investasi Emas Murni',
        description: 'Lindungi aset Anda dari inflasi dengan tabungan emas digital.',
        risk: 'Sedang',
        returnRate: 'Tren Naik',
        icon: Platform.isIOS ? CupertinoIcons.shield_fill : Icons.brightness_high_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Produk Finansial'),
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
              // Hero banner card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0C56D0), Color(0xFF003D9B)],
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
                      'MULAI KEMBANGKAN ASET',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Pilihan Investasi Cerdas',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pilih produk investasi yang sesuai dengan profil risiko Anda untuk masa depan yang lebih baik.',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Products list header
              Text(
                'PRODUK UTAMA',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Product list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final p = products[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
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
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(p.icon, color: AppTheme.primaryBlue, size: 20),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    p.title,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Risiko: ${p.risk}',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: p.risk == 'Rendah' || p.risk == 'Sangat Rendah'
                                          ? AppTheme.shariaGreen
                                          : const Color(0xFFC78314),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              p.returnRate,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          p.description,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.textLightGray,
                            height: 1.4,
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
