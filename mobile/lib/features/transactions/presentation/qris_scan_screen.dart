import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/core/router/app_router.dart';

class QRISScanScreen extends StatefulWidget {
  const QRISScanScreen({Key? key}) : super(key: key);

  @override
  State<QRISScanScreen> createState() => _QRISScanScreenState();
}

class _QRISScanScreenState extends State<QRISScanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _laserController;
  late Animation<double> _laserAnimation;
  bool _flashOn = false;
  Timer? _detectionTimer;

  @override
  void initState() {
    super.initState();
    _laserController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _laserAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _laserController, curve: Curves.easeInOut),
    );

    // Simulate merchant QRIS scan detection after 3.5s
    _detectionTimer = Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        // Play small audio click or vibration feedback and navigate to payment detail
        const PLNDetailRoute().push(context);
      }
    });
  }

  @override
  void dispose() {
    _laserController.dispose();
    _detectionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Simulated Camera Feed Background (Slightly blurred cafe counter)
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: Opacity(
                opacity: 0.6,
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBJg6mbB0TOaZbooUtkHppqQjmalmT7KYUF6rYSunGePjnUTxYmoxICZDmVydQi_S8GOAguoI1i-54idk5iOdKflLU4WPUYS4qgZSCt_-zvqrIYlIvV6KdRjl6glTjRJzWcTmNAZ_UuFSRzjmUaNroTpbP0wpR-1Fq4t7h28wLmG_ZWGsoTCz8HsCm95U41Pey3yGlOSxmQrjeic0gVkhEi1zq32p-E3KjejM0kIADAvfck_I6UfT0guFsblsBkqfa7weZR3VUG1w',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // 2. CustomViewfinder transparent mask overlay
          Positioned.fill(
            child: CustomPaint(
              painter: CameraMaskPainter(),
            ),
          ),

          // 3. Viewfinder pulsing green borders & laser scan
          Center(
            child: SizedBox(
              width: 260,
              height: 260,
              child: Stack(
                children: [
                  // Viewfinder corners
                  const ViewfinderBorders(),

                  // Animated Horizontal Laser Line
                  AnimatedBuilder(
                    animation: _laserAnimation,
                    builder: (context, child) {
                      return Positioned(
                        top: 260 * _laserAnimation.value,
                        left: 8,
                        right: 8,
                        child: Container(
                          height: 3,
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
                                color: AppTheme.shariaGreenLight.withOpacity(0.8),
                                blurRadius: 8,
                                spreadRadius: 1,
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

          // 4. Instructions overlay header
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.qr_code_scanner,
                      color: AppTheme.shariaGreenLight,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Scan & Bayar di merchant mana saja',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 5. Back Button (Left top)
          Positioned(
            top: 55,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),

          // 6. Flashlight & Gallery triggers (Bottom floating panel)
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Gallery button
                _buildFloatControl(
                  icon: Platform.isIOS ? CupertinoIcons.photo : Icons.image,
                  label: 'Upload Galeri',
                  onTap: () {},
                ),
                const SizedBox(width: 48),
                // Flashlight button
                _buildFloatControl(
                  icon: _flashOn
                      ? (Platform.isIOS ? CupertinoIcons.lightbulb_fill : Icons.flashlight_off)
                      : (Platform.isIOS ? CupertinoIcons.lightbulb : Icons.flashlight_on),
                  label: 'Senter',
                  onTap: () {
                    setState(() {
                      _flashOn = !_flashOn;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatControl({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.8),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Custom Viewfinder corners painter
class ViewfinderBorders extends StatelessWidget {
  const ViewfinderBorders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double length = 24;
    const double stroke = 4;
    const Color color = AppTheme.shariaGreenLight;

    return Stack(
      children: [
        // Top Left
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: length,
            height: stroke,
            color: color,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: stroke,
            height: length,
            color: color,
          ),
        ),

        // Top Right
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: length,
            height: stroke,
            color: color,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: stroke,
            height: length,
            color: color,
          ),
        ),

        // Bottom Left
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: length,
            height: stroke,
            color: color,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: stroke,
            height: length,
            color: color,
          ),
        ),

        // Bottom Right
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: length,
            height: stroke,
            color: color,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: stroke,
            height: length,
            color: color,
          ),
        ),
      ],
    );
  }
}

// Custom painter to mask camera feed leaving transparent square center
class CameraMaskPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double squareSize = 260.0;

    // Viewfinder Rect
    final rect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: squareSize,
      height: squareSize,
    );

    // Dark backdrop overlay path
    final maskPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(rect, const Radius.circular(16)))
      ..fillType = PathFillType.evenOdd;

    final paint = Paint()
      ..color = Colors.black.withOpacity(0.65)
      ..style = PaintingStyle.fill;

    canvas.drawPath(maskPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
