import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';
import 'package:banksatu_mobile/core/router/app_router.dart';

class KYCFaceScreen extends StatefulWidget {
  const KYCFaceScreen({Key? key}) : super(key: key);

  @override
  State<KYCFaceScreen> createState() => _KYCFaceScreenState();
}

class _KYCFaceScreenState extends State<KYCFaceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanningController;
  bool _isScanning = false;
  double _scanProgress = 0.0;
  String _statusText = 'Place your face in the oval frame';
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _scanningController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scanningController.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }

  void _startFaceScan() {
    setState(() {
      _isScanning = true;
      _statusText = 'Scanning... Please stay still';
    });

    _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _scanProgress += 0.04;
        if (_scanProgress >= 0.3 && _scanProgress < 0.6) {
          _statusText = 'Analyzing facial symmetry...';
        } else if (_scanProgress >= 0.6 && _scanProgress < 0.9) {
          _statusText = 'Checking liveness detection...';
        } else if (_scanProgress >= 1.0) {
          _scanProgress = 1.0;
          _statusText = 'Verification successful!';
          _progressTimer?.cancel();
          _isScanning = false;

          // Auto-navigate to Success screen after 800ms
          Future.delayed(const Duration(milliseconds: 800), () {
            if (mounted) {
              const KYCSuccessRoute().push(context);
            }
          });
        }
      });
    });
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
          'Step 2 of 3',
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
            // Segmented Progress Bar (Steps 1 & 2 Completed)
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
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(
                      'Face Verification',
                      style: GoogleFonts.inter(
                        color: AppTheme.primaryBlue,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We need to check your facial details to verify that you are indeed the rightful owner of the account.',
                      style: GoogleFonts.inter(
                        color: AppTheme.textLightGray,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Centered Face Viewfinder Frame
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Base Camera Simulation Container
                          Container(
                            width: 240,
                            height: 280,
                            decoration: BoxDecoration(
                              color: const Color(0xFF131722),
                              borderRadius: BorderRadius.circular(120), // Oval
                              boxShadow: AppTheme.floatingShadow,
                            ),
                            child: ClipOval(
                              child: Stack(
                                children: [
                                  // Grid Overlay inside oval
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: RadialFacePainter(),
                                    ),
                                  ),

                                  // Simulated Face Outlines (Mesh lines)
                                  if (_isScanning)
                                    AnimatedBuilder(
                                      animation: _scanningController,
                                      builder: (context, child) {
                                        return Center(
                                          child: Opacity(
                                            opacity: 0.2 + 0.6 * _scanningController.value,
                                            child: Icon(
                                              Platform.isIOS
                                                  ? CupertinoIcons.person_crop_circle_badge_checkmark
                                                  : Icons.face_retouching_natural,
                                              size: 160,
                                              color: AppTheme.shariaGreenLight,
                                            ),
                                          ),
                                        );
                                      },
                                    ),

                                  // Simulated Laser Scan Arc moving up & down
                                  if (_isScanning)
                                    AnimatedBuilder(
                                      animation: _scanningController,
                                      builder: (context, child) {
                                        return Positioned(
                                          top: 280 * _scanningController.value,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: 4,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  AppTheme.shariaGreenLight.withOpacity(0),
                                                  AppTheme.shariaGreenLight,
                                                  AppTheme.shariaGreenLight.withOpacity(0),
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppTheme.shariaGreenLight.withOpacity(0.9),
                                                  blurRadius: 12,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),

                          // Outer Biometric Progress ring
                          SizedBox(
                            width: 260,
                            height: 300,
                            child: CircularProgressIndicator(
                              value: _scanProgress,
                              strokeWidth: 4,
                              color: AppTheme.shariaGreenLight,
                              backgroundColor: AppTheme.primaryBlue.withOpacity(0.08),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    // Status Description
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isScanning
                              ? AppTheme.primaryBlue.withOpacity(0.06)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: _isScanning
                                ? AppTheme.primaryBlue.withOpacity(0.12)
                                : const Color(0xFFE8EEFF),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_isScanning) ...[
                              Platform.isIOS
                                  ? const CupertinoActivityIndicator(radius: 8)
                                  : const SizedBox(
                                      width: 14,
                                      height: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppTheme.primaryBlue,
                                      ),
                                    ),
                              const SizedBox(width: 10),
                            ] else
                              Icon(
                                Platform.isIOS ? CupertinoIcons.info : Icons.info_outline,
                                size: 16,
                                color: AppTheme.textLightGray,
                              ),
                            if (!_isScanning) const SizedBox(width: 8),
                            Text(
                              _statusText,
                              style: GoogleFonts.inter(
                                color: AppTheme.textDark,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFF1F3FF))),
        ),
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _isScanning ? null : _startFaceScan,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                disabledBackgroundColor: AppTheme.primaryBlue.withOpacity(0.5),
              ),
              icon: Icon(
                Platform.isIOS ? CupertinoIcons.person_crop_circle_fill : Icons.face,
                size: 22,
              ),
              label: Text(
                _isScanning ? 'Scanning Face...' : 'Scan Face',
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
}

class RadialFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..strokeWidth = 1;

    final double cx = size.width / 2;
    final double cy = size.height / 2;

    for (double r = 30; r < size.width; r += 30) {
      canvas.drawCircle(Offset(cx, cy), r, paint);
    }

    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), paint);
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
