import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';
import 'package:banksatu_mobile/core/router/app_router.dart';

class KYCIdentityScreen extends StatefulWidget {
  const KYCIdentityScreen({Key? key}) : super(key: key);

  @override
  State<KYCIdentityScreen> createState() => _KYCIdentityScreenState();
}

class _KYCIdentityScreenState extends State<KYCIdentityScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _scannerController;
  late Animation<double> _scannerAnimation;

  @override
  void initState() {
    super.initState();
    _scannerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _scannerAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scannerController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Step 1 of 3',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textLightGray,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Segmented Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.textDisabled.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.textDisabled.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Identity Verification',
                      style: GoogleFonts.inter(
                        color: AppTheme.primaryBlue,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please take a clear photo of your E-KTP. Ensure all details are legible to proceed.',
                      style: GoogleFonts.inter(
                        color: AppTheme.textLightGray,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Custom Camera Viewfinder Card with Animated Scanner Line
                    AspectRatio(
                      aspectRatio: 85.6 / 53.98, // Standard card shape
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF131722,
                          ), // Sleek camera background
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: AppTheme.floatingShadow,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              // Decorative Grid Mockup
                              CustomPaint(
                                painter: GridPainter(),
                                size: Size.infinite,
                              ),

                              // Viewfinder Corner Brackets
                              Positioned.fill(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.12),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const ViewfinderCorners(),
                                  ),
                                ),
                              ),

                              // Simulated Scanner Line Animation
                              Positioned.fill(
                                child: AnimatedBuilder(
                                  animation: _scannerAnimation,
                                  builder: (context, child) {
                                    return Align(
                                      alignment: Alignment(
                                        0,
                                        -1.0 + 2.0 * _scannerAnimation.value,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0,
                                        ),
                                        child: Container(
                                          height: 3,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                AppTheme.shariaGreenLight
                                                    .withOpacity(0),
                                                AppTheme.shariaGreenLight,
                                                AppTheme.shariaGreenLight
                                                    .withOpacity(0),
                                              ],
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.shariaGreenLight
                                                    .withOpacity(0.8),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Position Indicator
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Platform.isIOS
                                          ? CupertinoIcons.creditcard
                                          : Icons.credit_card,
                                      color: Colors.white.withOpacity(0.7),
                                      size: 48,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'POSITION E-KTP HERE',
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Automatic Data Extraction Cards
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withOpacity(0.03),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppTheme.primaryBlue.withOpacity(0.08),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Platform.isIOS
                                  ? CupertinoIcons.doc_text_viewfinder
                                  : Icons.document_scanner,
                              color: AppTheme.primaryBlue,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Automatic Data Extraction',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.textDark,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Our secure system will instantly extract the following details from your photo:',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.textLightGray,
                                    fontSize: 12,
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildExtractionItem(
                                  'NIK (National Identity Number)',
                                ),
                                const SizedBox(height: 6),
                                _buildExtractionItem('Full Legal Name'),
                                const SizedBox(height: 6),
                                _buildExtractionItem('Date of Birth'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100), // Spacing for floating button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                // Simulate capture and navigate to Step 2: Face scanning
                const KYCFaceRoute().push(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              icon: Icon(
                Platform.isIOS
                    ? CupertinoIcons.camera_fill
                    : Icons.photo_camera,
                size: 20,
              ),
              label: Text(
                'Open Camera to Capture',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExtractionItem(String label) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: AppTheme.shariaGreen, size: 14),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            color: AppTheme.textDark,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Custom Viewfinder corners painter
class ViewfinderCorners extends StatelessWidget {
  const ViewfinderCorners({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double length = 20;
    const double stroke = 4;
    const Color color = AppTheme.shariaGreenLight;

    return Stack(
      children: [
        // Top Left
        Positioned(
          top: 0,
          left: 0,
          child: Container(width: length, height: stroke, color: color),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(width: stroke, height: length, color: color),
        ),

        // Top Right
        Positioned(
          top: 0,
          right: 0,
          child: Container(width: length, height: stroke, color: color),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(width: stroke, height: length, color: color),
        ),

        // Bottom Left
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(width: length, height: stroke, color: color),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(width: stroke, height: length, color: color),
        ),

        // Bottom Right
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(width: length, height: stroke, color: color),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(width: stroke, height: length, color: color),
        ),
      ],
    );
  }
}

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..strokeWidth = 1;

    const double step = 20;
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
