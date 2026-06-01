import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/core/router/app_router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Illustration & Branding Area (Top Half)
                Expanded(
                  flex: 55,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        color: AppTheme.primaryBlue.withOpacity(0.08),
                        width: 1.5,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Abstract Premium Gradients
                          Positioned(
                            top: -100,
                            right: -100,
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    AppTheme.primaryBlueLight.withOpacity(0.4),
                                    AppTheme.primaryBlueLight.withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -50,
                            left: -50,
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    AppTheme.shariaGreenLight.withOpacity(0.2),
                                    AppTheme.shariaGreenLight.withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Floating Metallic/Glassmorphic 3D Card Illustration
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 200,
                                  height: 120,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateX(-0.1)
                                    ..rotateY(-0.25)
                                    ..rotateZ(0.08),
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppTheme.primaryBlue,
                                        Color(0xFF003D9B),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryBlue.withOpacity(0.3),
                                        offset: const Offset(8, 16),
                                        blurRadius: 24,
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 16,
                                        left: 16,
                                        child: Icon(
                                          Platform.isIOS ? CupertinoIcons.square_grid_2x2 : Icons.grid_view,
                                          color: Colors.white.withOpacity(0.8),
                                          size: 24,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 16,
                                        left: 16,
                                        right: 16,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '•••• 5432',
                                              style: GoogleFonts.jetBrainsMono(
                                                color: Colors.white.withOpacity(0.9),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.contactless,
                                              color: Colors.white70,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                // Second Floating Element (Security Badge)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: AppTheme.premiumShadow,
                                    border: Border.all(color: const Color(0xFFE8EEFF)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Platform.isIOS ? CupertinoIcons.shield_fill : Icons.shield,
                                        color: AppTheme.shariaGreen,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Encrypted & Secure',
                                        style: GoogleFonts.inter(
                                          color: AppTheme.textDark,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Top-Left Brand Floating Badge
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.85),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: AppTheme.primaryBlue.withOpacity(0.1),
                                  width: 1,
                                ),
                                boxShadow: AppTheme.premiumShadow,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Platform.isIOS ? CupertinoIcons.house_fill : Icons.account_balance,
                                    color: AppTheme.primaryBlue,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'BankSatu',
                                    style: GoogleFonts.inter(
                                      color: AppTheme.primaryBlue,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                      letterSpacing: -0.2,
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
                ),

                // Content & Action Area (Bottom Half)
                Expanded(
                  flex: 45,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Headline Text
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              'Satu platform untuk semua kebutuhan perbankan',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: AppTheme.textDark,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                height: 1.3,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Kelola keuangan, transfer instan, dan pantau pengeluaran Anda dengan aman dan mudah dalam satu genggaman.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: AppTheme.textLightGray,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),

                        // Action Buttons & Legal
                        Column(
                          children: [
                            // Primary CTA - Buka Rekening (KYC flow)
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () => const KYCIdentityRoute().push(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryBlue,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'Buka Rekening',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Secondary CTA - Masuk (OAuth Login screen)
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: TextButton(
                                onPressed: () => const LoginRoute().push(context),
                                style: TextButton.styleFrom(
                                  backgroundColor: AppTheme.background,
                                  foregroundColor: AppTheme.primaryBlue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  'Masuk',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Legal Warning OJK
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Platform.isIOS ? CupertinoIcons.lock_fill : Icons.lock,
                                  color: AppTheme.textLightGray,
                                  size: 12,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Terdaftar dan diawasi oleh OJK',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.textLightGray,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
