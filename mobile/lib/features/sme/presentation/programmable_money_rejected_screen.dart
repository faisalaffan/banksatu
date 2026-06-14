import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class ProgrammableMoneyRejectedScreen extends StatelessWidget {
  const ProgrammableMoneyRejectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pembayaran Ditolak'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              // Custom Painted Shield Vector Error / Rejected State
              SizedBox(
                width: 140,
                height: 140,
                child: CustomPaint(
                  painter: RejectedWarningPainter(),
                ),
              ),

              const SizedBox(height: 32),

              // Status message
              Text(
                'Alokasi Dana Tidak Sesuai',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sistem mendeteksi adanya pelanggaran pada batasan penggunaan (Rules Smart Contract) subsidi pemerintah.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppTheme.textLightGray,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 28),

              // Failure Reason Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.errorRed.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.errorRed.withOpacity(0.12), width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.exclamationmark_shield_fill,
                          color: AppTheme.errorRed,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'LOG DETIL PENOLAKAN',
                          style: GoogleFonts.inter(
                            color: AppTheme.errorRed,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildReasonRow('Merchant Pembelian', 'Kopi Kenangan #192, Jakarta'),
                    const SizedBox(height: 10),
                    _buildReasonRow('Kategori Terdeteksi', 'F&B Kafe & Premium Dessert'),
                    const SizedBox(height: 10),
                    _buildReasonRow('Status Kontrak', 'BLOCKED (Bukan Sembako/Pendidikan)'),
                    const SizedBox(height: 10),
                    _buildReasonRow('Tindakan', 'Transaksi dibatalkan otomatis'),
                  ],
                ),
              ),

              const Spacer(flex: 2),

              // Action Buttons
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.textDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Navigate back to the SME Hub / Dashboard
                    // Pop back to SME Dashboard
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    'Kembali ke Beranda',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textLightGray,
                    side: const BorderSide(color: Color(0xFFC3C6D6), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // Go back to the verify screen to try the other scenario
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Coba Transaksi Lain',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasonRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppTheme.textLightGray,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppTheme.textDark,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class RejectedWarningPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // 1. Draw elegant background pulse glow rings
    final pulsePaint = Paint()
      ..color = AppTheme.errorRed.withOpacity(0.06)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width / 2, pulsePaint);

    final innerGlowPaint = Paint()
      ..color = AppTheme.errorRed.withOpacity(0.12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size.width / 2.6, innerGlowPaint);

    // 2. Draw Shield outline vector
    final shieldPaint = Paint()
      ..color = AppTheme.errorRed
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Start at top middle
    path.moveTo(w * 0.5, h * 0.25);
    // Top-right curved line
    path.quadraticBezierTo(w * 0.72, h * 0.25, w * 0.75, h * 0.35);
    // Right bottom-ward line
    path.quadraticBezierTo(w * 0.75, h * 0.65, w * 0.5, h * 0.8);
    // Left bottom-ward line
    path.quadraticBezierTo(w * 0.25, h * 0.65, w * 0.25, h * 0.35);
    // Top-left curved line
    path.quadraticBezierTo(w * 0.28, h * 0.25, w * 0.5, h * 0.25);
    path.close();

    canvas.drawPath(path, shieldPaint);

    // 3. Draw a big exclamation mark inside the shield
    final textPainter = TextPainter(
      text: TextSpan(
        text: '!',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 38,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy - textPainter.height / 1.7),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
