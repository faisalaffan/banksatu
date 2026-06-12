import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/core/router/app_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

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
          'Profil Saya',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User Avatar & Card
            Center(
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [
                          AppTheme.primaryBlue,
                          AppTheme.primaryBlueDark,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: const Center(
                      child: Text(
                        'FA',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Faisal Affan',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.verified,
                          color: AppTheme.primaryBlue,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Nasabah Premium',
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
            const SizedBox(height: 32),

            // Section: Linked Applications (OAuth integration)
            _buildSectionHeader('Aplikasi Terintegrasi'),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.premiumShadow,
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.shariaGreen.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.trending_up,
                        color: AppTheme.shariaGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aplikasi Investasi X',
                          style: GoogleFonts.inter(
                            color: AppTheme.textDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Tersambung via BankSatu OAuth',
                          style: GoogleFonts.inter(
                            color: AppTheme.textLightGray,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.shariaGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Aktif',
                      style: GoogleFonts.inter(
                        color: AppTheme.shariaGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Section: Security & Customization
            _buildSectionHeader('Keamanan Akun'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.premiumShadow,
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Column(
                children: [
                  _buildNavigationRow(
                    Platform.isIOS ? CupertinoIcons.person_crop_circle : Icons.fingerprint,
                    'Login Biometrik & FaceID',
                    'Akses cepat biometrik & kunci PIN.',
                    () => const BiometricsSetupRoute().push(context),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F3FF)),
                  _buildNavigationRow(
                    Platform.isIOS ? CupertinoIcons.shield_fill : Icons.security,
                    'Jejak Keamanan & Sesi',
                    'Periksa login aktif & log device.',
                    () => const SecurityLogsRoute().push(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Section: App Accessibility Settings
            _buildSectionHeader('Aksesibilitas & Tampilan'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.premiumShadow,
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Column(
                children: [
                  _buildNavigationRow(
                    Platform.isIOS ? CupertinoIcons.textformat_size : Icons.accessibility,
                    'Aksesibilitas & Ukuran Font',
                    'Atur teks besar, kontras & audio guide.',
                    () => const AccessibilitySettingsRoute().push(context),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F3FF)),
                  _buildNavigationRow(
                    Platform.isIOS ? CupertinoIcons.moon_fill : Icons.dark_mode,
                    'Kustomisasi Tema Premium',
                    'Ganti tema HSL, gradien & glassmorphism.',
                    () => const ThemeCustomizerRoute().push(context),
                  ),
                  const Divider(height: 1, color: Color(0xFFF1F3FF)),
                  _buildNavigationRow(
                    Platform.isIOS ? CupertinoIcons.globe : Icons.language,
                    'Pilihan Bahasa',
                    'Bahasa Indonesia, Jawa, Sunda, English.',
                    () => const LanguageSelectorRoute().push(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // Section: Bantuan
            _buildSectionHeader('Bantuan & Dukungan'),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.premiumShadow,
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Column(
                children: [
                  _buildNavigationRow(
                    Platform.isIOS ? CupertinoIcons.headphones : Icons.headset_mic,
                    'Layanan Nasabah',
                    'Hubungi CS, FAQ, dan live chat.',
                    () => const CustomerServiceRoute().push(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton.icon(
                onPressed: () {
                  // Simply simulate logout by popping or showing alert
                  showDialog(
                    context: context,
                    builder: (context) => Platform.isIOS
                        ? CupertinoAlertDialog(
                            title: const Text('Keluar dari Akun?'),
                            content: const Text('Anda harus masuk kembali untuk mengakses informasi rekening.'),
                            actions: [
                              CupertinoDialogAction(
                                child: const Text('Batal'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              CupertinoDialogAction(
                                isDestructiveAction: true,
                                child: const Text('Keluar'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Reset stack to onboarding
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          )
                        : AlertDialog(
                            title: const Text('Keluar dari Akun?'),
                            content: const Text('Anda harus masuk kembali untuk mengakses informasi rekening.'),
                            actions: [
                              TextButton(
                                child: const Text('Batal'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                child: const Text('Keluar', style: TextStyle(color: AppTheme.errorRed)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.errorRed,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFFFFDAD6)),
                  ),
                  backgroundColor: const Color(0xFFFFDAD6).withOpacity(0.3),
                ),
                icon: Icon(
                  Platform.isIOS ? CupertinoIcons.square_arrow_right : Icons.logout,
                  size: 18,
                ),
                label: Text(
                  'Keluar dari Aplikasi',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 12),
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: AppTheme.textLightGray,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationRow(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryBlue,
              size: 20,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: AppTheme.textLightGray,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Platform.isIOS ? CupertinoIcons.chevron_right : Icons.chevron_right,
              color: AppTheme.textLightGray,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
