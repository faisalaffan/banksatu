import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class AccessibilitySettingsScreen extends StatefulWidget {
  const AccessibilitySettingsScreen({Key? key}) : super(key: key);

  @override
  State<AccessibilitySettingsScreen> createState() => _AccessibilitySettingsScreenState();
}

class _AccessibilitySettingsScreenState extends State<AccessibilitySettingsScreen> {
  double _fontScale = 1.0;
  bool _highContrast = false;
  bool _screenReader = false;
  bool _reduceMotion = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _highContrast ? Colors.black : AppTheme.background,
      appBar: AppBar(
        title: const Text('Aksesibilitas'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: _highContrast ? Colors.white : AppTheme.textDark,
          ),
        ),
        foregroundColor: _highContrast ? Colors.white : AppTheme.textDark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Realtime Scale Preview Box
              Text(
                'PREVIEW TAMPILAN TEKS',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _highContrast ? Colors.white70 : AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _highContrast ? Colors.grey[900] : AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _highContrast ? Colors.white : const Color(0xFFE8EEFF),
                    width: _highContrast ? 2.0 : 1.0,
                  ),
                  boxShadow: _highContrast ? [] : AppTheme.premiumShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tabungan Utama Faisal',
                      style: GoogleFonts.inter(
                        fontSize: 15 * _fontScale,
                        fontWeight: FontWeight.bold,
                        color: _highContrast ? Colors.white : AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Rp 750.000',
                      style: GoogleFonts.inter(
                        fontSize: 22 * _fontScale,
                        fontWeight: FontWeight.w800,
                        color: _highContrast ? Colors.yellowAccent : AppTheme.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gunakan slider di bawah untuk menyesuaikan kenyamanan membaca Anda.',
                      style: GoogleFonts.inter(
                        fontSize: 12 * _fontScale,
                        color: _highContrast ? Colors.white : AppTheme.textLightGray,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Text size adjustment slider
              Text(
                'UKURAN FONT',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _highContrast ? Colors.white70 : AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _highContrast ? Colors.grey[900] : AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _highContrast ? Colors.white54 : const Color(0xFFE8EEFF),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('A', style: TextStyle(fontSize: 12, color: _highContrast ? Colors.white : AppTheme.textDark)),
                        Text('Aa', style: TextStyle(fontSize: 22, color: _highContrast ? Colors.white : AppTheme.textDark, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Platform.isIOS
                        ? CupertinoSlider(
                            value: _fontScale,
                            min: 0.8,
                            max: 1.6,
                            activeColor: AppTheme.primaryBlue,
                            onChanged: (val) {
                              setState(() {
                                _fontScale = val;
                              });
                            },
                          )
                        : Slider(
                            value: _fontScale,
                            min: 0.8,
                            max: 1.6,
                            activeColor: AppTheme.primaryBlue,
                            onChanged: (val) {
                              setState(() {
                                _fontScale = val;
                              });
                            },
                          ),
                    const SizedBox(height: 8),
                    Text(
                      'Skala Font saat ini: ${(_fontScale * 100).toStringAsFixed(0)}%',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: _highContrast ? Colors.white70 : AppTheme.textLightGray,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Accessibility Toggle List
              Text(
                'FITUR INKLUSIF',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _highContrast ? Colors.white70 : AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: _highContrast ? Colors.grey[900] : AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _highContrast ? Colors.white54 : const Color(0xFFE8EEFF),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildAccessibilityToggle(
                      icon: CupertinoIcons.eye_fill,
                      title: 'Kontras Tinggi',
                      subtitle: 'Gunakan mode kontras tinggi hitam murni.',
                      value: _highContrast,
                      onChanged: (val) {
                        setState(() {
                          _highContrast = val;
                        });
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE8EEFF)),
                    _buildAccessibilityToggle(
                      icon: CupertinoIcons.waveform_circle_fill,
                      title: 'Audio Screen Reader',
                      subtitle: 'Aktifkan petunjuk suara untuk tunanetra.',
                      value: _screenReader,
                      onChanged: (val) {
                        setState(() {
                          _screenReader = val;
                        });
                      },
                    ),
                    const Divider(height: 1, color: Color(0xFFE8EEFF)),
                    _buildAccessibilityToggle(
                      icon: CupertinoIcons.bolt_horizontal_circle_fill,
                      title: 'Kurangi Animasi',
                      subtitle: 'Matikan animasi transisi yang cepat.',
                      value: _reduceMotion,
                      onChanged: (val) {
                        setState(() {
                          _reduceMotion = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Save / Done Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _highContrast ? Colors.white : AppTheme.primaryBlue,
                    foregroundColor: _highContrast ? Colors.black : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: _highContrast ? const BorderSide(color: Colors.white, width: 2) : BorderSide.none,
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Simpan Pengaturan',
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

  Widget _buildAccessibilityToggle({
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
              color: (_highContrast ? Colors.white : AppTheme.primaryBlue).withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: _highContrast ? Colors.white : AppTheme.primaryBlue,
              size: 20,
            ),
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
                    fontWeight: FontWeight.w700,
                    color: _highContrast ? Colors.white : AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: _highContrast ? Colors.white70 : AppTheme.textLightGray,
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
