import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class LanguageConfig {
  final String code;
  final String name;
  final String nativeName;
  final String flagChar;
  final String demoGreeting;
  final String demoHeader;

  LanguageConfig({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flagChar,
    required this.demoGreeting,
    required this.demoHeader,
  });
}

class LanguageSelectorScreen extends StatefulWidget {
  const LanguageSelectorScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectorScreen> createState() => _LanguageSelectorScreenState();
}

class _LanguageSelectorScreenState extends State<LanguageSelectorScreen> {
  String _selectedLanguageCode = 'id';

  final List<LanguageConfig> _languages = [
    LanguageConfig(
      code: 'id',
      name: 'Indonesian',
      nativeName: 'Bahasa Indonesia',
      flagChar: '🇮🇩',
      demoGreeting: 'Selamat Pagi, Faisal!',
      demoHeader: 'Rekening Tabungan Utama',
    ),
    LanguageConfig(
      code: 'en',
      name: 'English',
      nativeName: 'English (US)',
      flagChar: '🇺🇸',
      demoGreeting: 'Good Morning, Faisal!',
      demoHeader: 'Main Savings Account',
    ),
    LanguageConfig(
      code: 'jv',
      name: 'Javanese',
      nativeName: 'Basa Jawa',
      flagChar: '🌾',
      demoGreeting: 'Sugeng Enjang, Faisal!',
      demoHeader: 'Celengan Utami',
    ),
    LanguageConfig(
      code: 'su',
      name: 'Sundanese',
      nativeName: 'Basa Sunda',
      flagChar: '🏔️',
      demoGreeting: 'Wilujeng Enjing, Faisal!',
      demoHeader: 'Tabungan Utama',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeLanguage = _languages.firstWhere((l) => l.code == _selectedLanguageCode);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Pilihan Bahasa'),
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
              // Realtime Language Demo Preview Box
              Text(
                'SIMULASI TERJEMAHAN DYNAMIC',
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
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8EEFF), width: 1.5),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          activeLanguage.demoGreeting,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                        ),
                        Text(
                          activeLanguage.flagChar,
                          style: const TextStyle(fontSize: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Color(0xFFE8EEFF), height: 1),
                    const SizedBox(height: 10),
                    Text(
                      activeLanguage.demoHeader,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textLightGray,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rp 750.000',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Locales Selector Grid
              Text(
                'LOKALISASI DAERAH & GLOBAL',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final lang = _languages[index];
                  final isSelected = lang.code == _selectedLanguageCode;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppTheme.primaryBlue : const Color(0xFFE8EEFF),
                        width: isSelected ? 2.0 : 1.0,
                      ),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLanguageCode = lang.code;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Beautiful Circular Flag Badge
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.06),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  lang.flagChar,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lang.nativeName,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    lang.name,
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: AppTheme.textLightGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                CupertinoIcons.checkmark_seal_fill,
                                color: AppTheme.primaryBlue,
                                size: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Save and Pop
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Pilih Bahasa & Update Tampilan',
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
