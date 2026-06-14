import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class MarketplaceCategory {
  final String label;
  final IconData icon;

  MarketplaceCategory({
    required this.label,
    required this.icon,
  });
}

class LifestyleProduct {
  final String title;
  final String price;
  final String points;
  final String discount;
  final IconData icon;

  LifestyleProduct({
    required this.title,
    required this.price,
    required this.points,
    required this.discount,
    required this.icon,
  });
}

class LifestyleMarketplaceScreen extends StatelessWidget {
  const LifestyleMarketplaceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MarketplaceCategory> categories = [
      MarketplaceCategory(label: 'Tiket Bioskop', icon: Platform.isIOS ? CupertinoIcons.film : Icons.movie_outlined),
      MarketplaceCategory(label: 'Voucher Makan', icon: Platform.isIOS ? CupertinoIcons.square_list : Icons.restaurant_rounded),
      MarketplaceCategory(label: 'Hotel & Travel', icon: Platform.isIOS ? CupertinoIcons.home : Icons.hotel_rounded),
      MarketplaceCategory(label: 'Voucher Game', icon: Platform.isIOS ? CupertinoIcons.gamecontroller : Icons.videogame_asset_outlined),
    ];

    final List<LifestyleProduct> deals = [
      LifestyleProduct(
        title: 'Voucher XXI Rp 100.000',
        price: 'Rp 85.000',
        points: '850 pts',
        discount: 'Diskon 15%',
        icon: Platform.isIOS ? CupertinoIcons.film : Icons.movie_outlined,
      ),
      LifestyleProduct(
        title: 'Saldo GrabFood Rp 50.000',
        price: 'Rp 45.000',
        points: '450 pts',
        discount: 'Diskon 10%',
        icon: Platform.isIOS ? CupertinoIcons.square_list : Icons.fastfood_outlined,
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Lifestyle Marketplace'),
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
              // Promo Banner
              Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF815000), Color(0xFF613B00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF613B00).withOpacity(0.25),
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'PROMO MINGGU INI',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Diskon s.d 50% Tiket Bioskop',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Beli tiket XXI lewat BankSatu & nikmati promo khususnya.',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Categories Header
              Text(
                'KATEGORI GAYA HIDUP',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Categories Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 2.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE8EEFF)),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(cat.icon, color: AppTheme.primaryBlue, size: 20),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            cat.label,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),

              // Deals list header
              Text(
                'PENAWARAN TERBAIK UNTUK ANDA',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Deal List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: deals.length,
                itemBuilder: (context, index) {
                  final deal = deals[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFE8EEFF)),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(deal.icon, color: AppTheme.primaryBlue, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deal.title,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    deal.price,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppTheme.primaryBlue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    deal.points,
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: const Color(0xFFC78314),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.shariaGreen.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            deal.discount,
                            style: GoogleFonts.inter(
                              color: AppTheme.shariaGreen,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
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
