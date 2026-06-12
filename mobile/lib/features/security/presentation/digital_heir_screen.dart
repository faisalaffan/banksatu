import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class Heir {
  final String name;
  final String relation;
  final double allocation; // in %
  final bool isVerified;

  Heir({
    required this.name,
    required this.relation,
    required this.allocation,
    required this.isVerified,
  });
}

class DigitalHeirScreen extends StatelessWidget {
  const DigitalHeirScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Heir> heirs = [
      Heir(name: 'Adinda Larasati', relation: 'Istri', allocation: 70.0, isVerified: true),
      Heir(name: 'Budi Hartono', relation: 'Anak Kandung', allocation: 30.0, isVerified: true),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Ahli Waris Digital'),
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
              // Security info panel
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF243B55), Color(0xFF141E30)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF141E30).withOpacity(0.25),
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
                          'WARISAN DIGITAL AKTIF',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const Icon(Icons.verified_user_rounded, color: Colors.greenAccent, size: 20),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Aman & Terenkripsi',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sistem BankSatu akan mengalokasikan akses aset keuangan digital Anda ke ahli waris yang terdaftar secara sah secara otomatis jika terjadi keadaan darurat.',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Heirs list header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'DAFTAR AHLI WARIS TERDAFTAR',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLightGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    '+ Tambah',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Heirs cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: heirs.length,
                itemBuilder: (context, index) {
                  final h = heirs[index];
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.06),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Platform.isIOS ? CupertinoIcons.person_fill : Icons.person_rounded,
                                color: AppTheme.primaryBlue,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      h.name,
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textDark,
                                      ),
                                    ),
                                    if (h.isVerified) ...[
                                      const SizedBox(width: 6),
                                      const Icon(Icons.verified_rounded, color: Colors.green, size: 14),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Hubungan: ${h.relation}',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppTheme.textLightGray,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '${h.allocation.toStringAsFixed(0)}%',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primaryBlue,
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
