import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class BiometricsSetupScreen extends StatefulWidget {
  const BiometricsSetupScreen({Key? key}) : super(key: key);

  @override
  State<BiometricsSetupScreen> createState() => _BiometricsSetupScreenState();
}

class _BiometricsSetupScreenState extends State<BiometricsSetupScreen> with SingleTickerProviderStateMixin {
  bool _faceIdEnabled = true;
  bool _fingerprintEnabled = false;
  bool _isScanning = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _triggerScanDemo() {
    setState(() {
      _isScanning = true;
    });
    _animationController.repeat();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      _animationController.stop();
      setState(() {
        _isScanning = false;
        _faceIdEnabled = true;
      });

      _showSuccessAlert();
    });
  }

  void _showSuccessAlert() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Biometrik Siap'),
          content: const Text('Sensor wajah (FaceID) berhasil dikalibrasi dan siap digunakan untuk otorisasi transaksi BankSatu.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Selesai'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Biometrik Siap'),
          content: const Text('Sensor wajah (FaceID) berhasil dikalibrasi dan siap digunakan untuk otorisasi transaksi BankSatu.'),
          actions: [
            TextButton(
              child: const Text('Selesai'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Biometrik & Login Cepat'),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              // Visual Face ID Mesh Simulator
              Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE8EEFF), width: 2),
                    boxShadow: AppTheme.premiumShadow,
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return CustomPaint(
                              size: const Size(140, 140),
                              painter: FaceMeshPainter(
                                progress: _animationController.value,
                                isScanning: _isScanning,
                              ),
                            );
                          },
                        ),
                      ),
                      if (_isScanning)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 120),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryBlue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'Menganalisis Wajah...',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                _isScanning ? 'Memproses Biometrik Wajah...' : 'Sensor Biometrik Siap',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Gunakan data biometrik perangkat untuk membuka aplikasi dan memvalidasi transfer secara instan.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppTheme.textLightGray,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 32),

              // Settings Switch Box
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'INTEGRASI SENSOR PERANGKAT',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textLightGray,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: Column(
                  children: [
                    _buildSensorSwitch(
                      icon: Icons.face,
                      title: 'Otorisasi FaceID',
                      subtitle: 'Buka & transfer dengan sensor wajah.',
                      value: _faceIdEnabled,
                      onChanged: (val) {
                        setState(() {
                          _faceIdEnabled = val;
                        });
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE8EEFF)),
                    _buildSensorSwitch(
                      icon: Icons.fingerprint,
                      title: 'Otorisasi Sidik Jari',
                      subtitle: 'Alternatif akses cepat TouchID.',
                      value: _fingerprintEnabled,
                      onChanged: (val) {
                        setState(() {
                          _fingerprintEnabled = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Diagnostic / Trigger Actions
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  icon: const Icon(CupertinoIcons.camera_viewfinder, size: 18),
                  label: Text(
                    'Uji Kalibrasi FaceID',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onPressed: _isScanning ? null : _triggerScanDemo,
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.textDark,
                    side: const BorderSide(color: Color(0xFFC3C6D6), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // Navigate back
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Kembali ke Pengaturan PIN',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorSwitch({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textLightGray,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            activeColor: AppTheme.shariaGreen,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class FaceMeshPainter extends CustomPainter {
  final double progress;
  final bool isScanning;

  FaceMeshPainter({required this.progress, required this.isScanning});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = isScanning ? AppTheme.primaryBlue.withOpacity(0.4) : AppTheme.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // 1. Draw elegant glowing background radar rings
    canvas.drawCircle(center, size.width / 2, paint);
    canvas.drawCircle(center, size.width / 3.5, paint);

    // 2. Draw mock facial mesh node lines
    final nodePaint = Paint()
      ..color = isScanning ? AppTheme.primaryBlue : AppTheme.primaryBlue.withOpacity(0.7)
      ..style = PaintingStyle.fill;

    final List<Offset> facialNodes = [
      Offset(size.width * 0.5, size.height * 0.25), // Forehead
      Offset(size.width * 0.35, size.height * 0.4),  // Left eye
      Offset(size.width * 0.65, size.height * 0.4),  // Right eye
      Offset(size.width * 0.5, size.height * 0.55),  // Nose
      Offset(size.width * 0.3, size.height * 0.65),  // Left cheek
      Offset(size.width * 0.7, size.height * 0.65),  // Right cheek
      Offset(size.width * 0.5, size.height * 0.8),   // Chin
    ];

    // Connect node lines
    for (int i = 0; i < facialNodes.length; i++) {
      for (int j = i + 1; j < facialNodes.length; j++) {
        // Only connect adjacent coordinates to form an aesthetic wireframe mesh
        final dist = (facialNodes[i] - facialNodes[j]).distance;
        if (dist < size.width * 0.4) {
          canvas.drawLine(facialNodes[i], facialNodes[j], paint);
        }
      }
    }

    // Draw little node dots
    for (final node in facialNodes) {
      canvas.drawCircle(node, 4, nodePaint);
    }

    // 3. Draw green pulsing laser line if actively scanning
    if (isScanning) {
      final laserPaint = Paint()
        ..color = AppTheme.shariaGreen
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;

      final laserY = size.height * 0.2 + (size.height * 0.6 * progress);
      canvas.drawLine(
        Offset(size.width * 0.15, laserY),
        Offset(size.width * 0.85, laserY),
        laserPaint,
      );

      // Add soft laser glow outline
      final laserGlow = Paint()
        ..color = AppTheme.shariaGreen.withOpacity(0.3)
        ..strokeWidth = 10
        ..style = PaintingStyle.stroke;
      canvas.drawLine(
        Offset(size.width * 0.15, laserY),
        Offset(size.width * 0.85, laserY),
        laserGlow,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FaceMeshPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isScanning != isScanning;
}
