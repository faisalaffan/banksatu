import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class SupportChannel {
  final String title;
  final String description;
  final IconData icon;
  final String actionText;

  SupportChannel({
    required this.title,
    required this.description,
    required this.icon,
    required this.actionText,
  });
}

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SupportChannel> channels = [
      SupportChannel(
        title: 'Hubungi Live Chat CS',
        description: 'Tanya jawab langsung dengan agen resmi kami secara real-time.',
        icon: Platform.isIOS ? CupertinoIcons.chat_bubble_2_fill : Icons.chat_rounded,
        actionText: 'Mulai Chat',
      ),
      SupportChannel(
        title: 'Layanan Telepon 24 Jam',
        description: 'Hubungi hotline premium kami di 1500-111 kapan saja.',
        icon: Platform.isIOS ? CupertinoIcons.phone_fill : Icons.phone_in_talk_rounded,
        actionText: 'Hubungi CS',
      ),
      SupportChannel(
        title: 'Kirim Email Bantuan',
        description: 'Ajukan keluhan tertulis lewat email ke support@banksatu.id.',
        icon: Platform.isIOS ? CupertinoIcons.mail_solid : Icons.mail_rounded,
        actionText: 'Kirim Email',
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Layanan Bantuan / CS'),
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Banner
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryBlue, Color(0xFF0C56D0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryBlue.withOpacity(0.25),
                      offset: const Offset(0, 12),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pusat Hubungan BankSatu',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Butuh bantuan perbankan digital? Tim kami siap melayani Anda 24 jam sehari, 7 hari seminggu.',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Channels Header
              Text(
                'SALURAN DUKUNGAN RESMI',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Channel list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: channels.length,
                itemBuilder: (context, index) {
                  final ch = channels[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE8EEFF)),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(ch.icon, color: AppTheme.primaryBlue, size: 20),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                ch.title,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          ch.description,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.textLightGray,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Perform support channel action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            ch.actionText,
                            style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
