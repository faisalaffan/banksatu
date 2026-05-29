import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/core/router/app_router.dart';

class ProgrammableMoneyDetailScreen extends StatefulWidget {
  const ProgrammableMoneyDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProgrammableMoneyDetailScreen> createState() => _ProgrammableMoneyDetailScreenState();
}

class _ProgrammableMoneyDetailScreenState extends State<ProgrammableMoneyDetailScreen> {
  final _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final double balance = 750000;
    final double totalAllocated = 1200000;
    final double percentUsed = (totalAllocated - balance) / totalAllocated;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Dana Bansos Pintar'),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welfare Card Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.shariaGreen, Color(0xFF008947)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shariaGreen.withOpacity(0.25),
                      offset: const Offset(0, 10),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.checkmark_seal_fill,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'PROGRAMMABLE MONEY',
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Kemensos RI',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Bantuan Sembako & Pendidikan',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'ID Penerima: KPM-89021820',
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white70,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SISA SALDO DANA',
                              style: GoogleFonts.inter(
                                color: Colors.white70,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _currencyFormatter.format(balance),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'TOTAL ALOKASI',
                              style: GoogleFonts.inter(
                                color: Colors.white70,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _currencyFormatter.format(totalAllocated),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Spending Target Progress Card
              Text(
                'TRACKER DANA BANSOS',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: CircularProgressIndicator(
                                value: 1.0 - percentUsed,
                                strokeWidth: 10,
                                backgroundColor: const Color(0xFFE8EEFF),
                                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.shariaGreen),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${((totalAllocated - balance) / totalAllocated * 100).toStringAsFixed(0)}%',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alokasi Terpakai',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Anda telah membelanjakan ${_currencyFormatter.format(totalAllocated - balance)} dari total subsidi.',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppTheme.textLightGray,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Spending Limitations Card List
              Text(
                'BATASAN & KATEGORI MERCHANT',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: Column(
                  children: [
                    _buildLimitationRow(
                      icon: CupertinoIcons.shopping_cart,
                      title: 'Kategori Sembako',
                      status: 'DIIZINKAN',
                      desc: 'Beras, Minyak, Telur, Gula, Susu, Daging, Sayuran',
                      isAllowed: true,
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Color(0xFFE8EEFF), height: 1),
                    const SizedBox(height: 16),
                    _buildLimitationRow(
                      icon: CupertinoIcons.book,
                      title: 'Kebutuhan Sekolah & Buku',
                      status: 'DIIZINKAN',
                      desc: 'Seragam sekolah, alat tulis, buku pelajaran, SPP',
                      isAllowed: true,
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Color(0xFFE8EEFF), height: 1),
                    const SizedBox(height: 16),
                    _buildLimitationRow(
                      icon: CupertinoIcons.slash_circle,
                      title: 'F&B Kafe, Rokok & Hiburan',
                      status: 'DIBLOKIR',
                      desc: 'Starbucks, Kopi Kenangan, bioskop, minimarket rokok',
                      isAllowed: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Premium Scan QR / Spend Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.shariaGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(CupertinoIcons.qrcode_viewfinder),
                  label: Text(
                    'Belanjakan Dana Bansos',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: () => const ProgrammableMoneyVerifyRoute().push(context),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLimitationRow({
    required IconData icon,
    required String title,
    required String status,
    required String desc,
    required bool isAllowed,
  }) {
    final statusColor = isAllowed ? AppTheme.shariaGreen : AppTheme.errorRed;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: statusColor, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.inter(
                        color: statusColor,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppTheme.textLightGray,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
