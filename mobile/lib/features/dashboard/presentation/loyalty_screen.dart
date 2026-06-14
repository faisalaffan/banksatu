import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class RewardItem {
  final String title;
  final String category;
  final int pointsCost;
  final IconData icon;
  final double progress;

  RewardItem({
    required this.title,
    required this.category,
    required this.pointsCost,
    required this.icon,
    required this.progress,
  });
}

class LoyaltyScreen extends StatelessWidget {
  const LoyaltyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<RewardItem> rewards = [
      RewardItem(
        title: 'Gratis Kopi Premium',
        category: 'Food & Beverage',
        pointsCost: 850,
        icon: Platform.isIOS ? CupertinoIcons.drop_fill : Icons.local_cafe_rounded,
        progress: 0.9,
      ),
      RewardItem(
        title: 'Voucher Cashback Rp 50.000',
        category: 'Cashback',
        pointsCost: 5000,
        icon: Platform.isIOS ? CupertinoIcons.money_dollar : Icons.monetization_on_rounded,
        progress: 0.45,
      ),
      RewardItem(
        title: 'Diskon Penerbangan Tiket.com',
        category: 'Travel',
        pointsCost: 12000,
        icon: Platform.isIOS ? CupertinoIcons.airplane : Icons.flight_rounded,
        progress: 0.15,
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Loyalty & Rewards'),
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
              // Premium Golden Glowing Points Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE5A93B), Color(0xFFC78314)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFC78314).withOpacity(0.35),
                      offset: const Offset(0, 12),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'STATUS KEANGGOTAAN',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.75),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            'Gold Member',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '12.550 pts',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Kumpulkan 2.450 poin lagi untuk menjadi Platinum Member',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Rewards Catalog Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'HADIAH KHUSUS UNTUK ANDA',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLightGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Lihat Semua',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Reward Cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final r = rewards[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE8EEFF)),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5A93B).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(r.icon, color: const Color(0xFFC78314), size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                r.title,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${r.category} • ${r.pointsCost} Poin',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppTheme.textLightGray,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Progress Bar to redeem
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: r.progress,
                                  backgroundColor: const Color(0xFFF1F3FF),
                                  color: const Color(0xFFE5A93B),
                                  minHeight: 4,
                                ),
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
