import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';
import 'package:banksatu_mobile/core/router/app_router.dart';

class SMEDashboardScreen extends StatefulWidget {
  const SMEDashboardScreen({Key? key}) : super(key: key);

  @override
  State<SMEDashboardScreen> createState() => _SMEDashboardScreenState();
}

class _SMEDashboardScreenState extends State<SMEDashboardScreen> {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final double totalPemasukan = 45230000;
    final double totalTertunggak = 12800000;
    final double batasKredit = 150000000;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Custom Premium Header
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.06),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
                              color: AppTheme.primaryBlue,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Portal Bisnis',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Text(
                              'SME & Cashflow',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.5,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Platform.isIOS ? CupertinoIcons.briefcase_fill : Icons.business_center,
                            color: AppTheme.primaryBlue,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Premium SME',
                            style: GoogleFonts.inter(
                              color: AppTheme.primaryBlue,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Cashflow Overview Card
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: AppTheme.floatingShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'PENDAPATAN SME BULAN INI',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            'Mei 2026',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        formatter.format(totalPemasukan),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Divider(color: Colors.white24, height: 1),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.clock_fill,
                                      color: Colors.orangeAccent,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Invoice Pending',
                                      style: GoogleFonts.inter(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formatter.format(totalTertunggak),
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(width: 1, height: 36, color: Colors.white12),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.checkmark_circle_fill,
                                      color: Colors.greenAccent,
                                      size: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Limit Kredit SME',
                                      style: GoogleFonts.inter(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formatter.format(batasKredit),
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Quick SME Action Carousel
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 124,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _buildActionCard(
                        context: context,
                        icon: CupertinoIcons.doc_text_viewfinder,
                        title: 'Buat Invoice',
                        subtitle: 'Kirim tagihan instan',
                        color: AppTheme.primaryBlue,
                        onTap: () => const SMENewInvoiceRoute().push(context),
                      ),
                      _buildActionCard(
                        context: context,
                        icon: Platform.isIOS ? CupertinoIcons.checkmark_seal_fill : Icons.verified_user_rounded,
                        title: 'Approval Workflow',
                        subtitle: 'Persetujuan transaksi',
                        color: Colors.deepPurple,
                        onTap: () => const ApprovalWorkflowRoute().push(context),
                      ),
                      _buildActionCard(
                        context: context,
                        icon: CupertinoIcons.gift_fill,
                        title: 'Dana Bansos',
                        subtitle: 'Welfare tracking',
                        color: AppTheme.shariaGreen,
                        onTap: () => const ProgrammableMoneyDetailRoute().push(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Revenue Chart Section
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              sliver: SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceCard,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                    boxShadow: AppTheme.premiumShadow,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tren Omzet Bulanan',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Gross sales MoM growth',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppTheme.textLightGray,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.shariaGreen.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '+18.4% MoM',
                              style: GoogleFonts.inter(
                                color: AppTheme.shariaGreen,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 160,
                        child: CustomPaint(
                          size: Size.infinite,
                          painter: SMERevenuePainter(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Legend / Months labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Jan', style: TextStyle(color: AppTheme.textLightGray, fontSize: 10)),
                          Text('Feb', style: TextStyle(color: AppTheme.textLightGray, fontSize: 10)),
                          Text('Mar', style: TextStyle(color: AppTheme.textLightGray, fontSize: 10)),
                          Text('Apr', style: TextStyle(color: AppTheme.textLightGray, fontSize: 10)),
                          Text('Mei', style: TextStyle(color: AppTheme.textLightGray, fontSize: 10)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Recent Invoices Header
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 8),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Daftar Invoice Terakhir',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                    Text(
                      'Lihat Semua',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Invoices List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildInvoiceItem(
                    invNo: 'INV/2026/089',
                    client: 'PT Astra Digital',
                    date: 'Due 10 Jun 2026',
                    amount: 28500000,
                    status: 'Pending',
                  ),
                  _buildInvoiceItem(
                    invNo: 'INV/2026/088',
                    client: 'Kopi Toko Djawa',
                    date: 'Due 02 Jun 2026',
                    amount: 6300000,
                    status: 'Lunas',
                  ),
                  _buildInvoiceItem(
                    invNo: 'INV/2026/087',
                    client: 'Warung Nasi Ampera',
                    date: 'Due 28 Mei 2026',
                    amount: 10430000,
                    status: 'Lunas',
                  ),
                ]),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 48)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
          boxShadow: AppTheme.premiumShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: AppTheme.textLightGray,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvoiceItem({
    required String invNo,
    required String client,
    required String date,
    required double amount,
    required String status,
  }) {
    final isLunas = status == 'Lunas';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
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
                  color: (isLunas ? AppTheme.shariaGreen : Colors.orange).withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isLunas ? CupertinoIcons.checkmark_seal_fill : CupertinoIcons.clock_fill,
                  color: isLunas ? AppTheme.shariaGreen : Colors.orange,
                  size: 18,
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    client,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        invNo,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          color: AppTheme.textLightGray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '•',
                        style: TextStyle(color: AppTheme.textLightGray.withOpacity(0.5)),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: AppTheme.textLightGray,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatter.format(amount),
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: (isLunas ? AppTheme.shariaGreen : Colors.orange).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.inter(
                    color: isLunas ? AppTheme.shariaGreen : Colors.orange,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SMERevenuePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // We'll draw 5 beautifully designed bars with rounded corners, double gradients, etc.
    final List<double> values = [0.4, 0.55, 0.7, 0.65, 0.95];
    final double barWidth = size.width / 5 - 20;
    final double spacing = (size.width - (barWidth * 5)) / 4;

    for (int i = 0; i < values.length; i++) {
      final double x = i * (barWidth + spacing);
      final double h = size.height * values[i];
      final double y = size.height - h;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, h),
        const Radius.circular(8),
      );

      final grad = LinearGradient(
        colors: i == 4
            ? [AppTheme.primaryBlue, const Color(0xFF00B4DB)]
            : [AppTheme.primaryBlue.withOpacity(0.6), AppTheme.primaryBlue.withOpacity(0.9)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

      paint.shader = grad.createShader(Rect.fromLTWH(x, y, barWidth, h));
      canvas.drawRRect(rect, paint);

      // Add a subtle glossy top dot for active current month (index 4)
      if (i == 4) {
        final dotPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
        canvas.drawCircle(Offset(x + barWidth / 2, y + 8), 4, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
