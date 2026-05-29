import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class ThemeConfig {
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final List<Color> gradientColors;

  ThemeConfig({
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.gradientColors,
  });
}

class ThemeCustomizerScreen extends StatefulWidget {
  const ThemeCustomizerScreen({Key? key}) : super(key: key);

  @override
  State<ThemeCustomizerScreen> createState() => _ThemeCustomizerScreenState();
}

class _ThemeCustomizerScreenState extends State<ThemeCustomizerScreen> {
  bool _enableGlassmorphism = true;
  String _selectedThemeName = 'BankSatu Royal Blue';

  final List<ThemeConfig> _themes = [
    ThemeConfig(
      name: 'BankSatu Royal Blue',
      primaryColor: AppTheme.primaryBlue,
      secondaryColor: AppTheme.primaryBlueDark,
      gradientColors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
    ),
    ThemeConfig(
      name: 'Emerald Sharia Green',
      primaryColor: AppTheme.shariaGreen,
      secondaryColor: const Color(0xFF004D26),
      gradientColors: [AppTheme.shariaGreen, const Color(0xFF004D26)],
    ),
    ThemeConfig(
      name: 'Nebula Violet',
      primaryColor: const Color(0xFF6A0DAD),
      secondaryColor: const Color(0xFF3B0066),
      gradientColors: [const Color(0xFF8A2BE2), const Color(0xFF4B0082)],
    ),
    ThemeConfig(
      name: 'Deep Amber Wealth',
      primaryColor: const Color(0xFFFF9F00),
      secondaryColor: const Color(0xFFCC7A00),
      gradientColors: [const Color(0xFFFFB300), const Color(0xFFFF6F00)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeTheme = _themes.firstWhere((t) => t.name == _selectedThemeName);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Kustomisasi Tema'),
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
              // Premium Card Preview (Interactive)
              Text(
                'PREVIEW TEMA & EFEK BLUR',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=600&auto=format&fit=crop&q=60'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: AppTheme.floatingShadow,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: _enableGlassmorphism ? 15 : 0,
                      sigmaY: _enableGlassmorphism ? 15 : 0,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      color: _enableGlassmorphism
                          ? Colors.white.withOpacity(0.18)
                          : activeTheme.primaryColor.withOpacity(0.85),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Faisal Affan',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'PREMIUM',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'LIMIT SALDO AKTIF',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Rp 150.000.000',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Palette Selector Grid
              Text(
                'PILIHAN WARNA DINAMIS (HSL/HEX)',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _themes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.25,
                ),
                itemBuilder: (context, index) {
                  final t = _themes[index];
                  final isSelected = t.name == _selectedThemeName;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedThemeName = t.name;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? t.primaryColor : const Color(0xFFE8EEFF),
                          width: isSelected ? 2.5 : 1.0,
                        ),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: t.primaryColor.withOpacity(0.15),
                            offset: const Offset(0, 6),
                            blurRadius: 12,
                          )
                        ] : AppTheme.premiumShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: t.gradientColors,
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  CupertinoIcons.checkmark_circle_fill,
                                  color: t.primaryColor,
                                  size: 18,
                                ),
                            ],
                          ),
                          Text(
                            t.name,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 28),

              // Glassmorphism Toggle Card
              Text(
                'ATURAN TAMPILAN',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: activeTheme.primaryColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CupertinoIcons.square_grid_3x2_fill,
                        color: activeTheme.primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Efek Glassmorphism',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Aktifkan blur latar belakang transparan.',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppTheme.textLightGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _enableGlassmorphism,
                      activeColor: activeTheme.primaryColor,
                      onChanged: (val) {
                        setState(() {
                          _enableGlassmorphism = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Apply Theme Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: activeTheme.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Back to Profile Screen
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Terapkan Tema Baru',
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
}
