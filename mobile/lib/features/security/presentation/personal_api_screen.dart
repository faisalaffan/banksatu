import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class PersonalApiScreen extends StatefulWidget {
  const PersonalApiScreen({Key? key}) : super(key: key);

  @override
  State<PersonalApiScreen> createState() => _PersonalApiScreenState();
}

class _PersonalApiScreenState extends State<PersonalApiScreen> {
  final String _apiKey = 'pk_live_51N8hS9aK29j1a8sh29sJas8a1hsa';
  bool _showApiKey = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Personal API & Webhooks'),
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
              // Developer Info Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Developer Console',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Gunakan kunci API dan Webhook untuk mengintegrasikan data transaksi BankSatu Anda ke aplikasi personal, dashboard keuangan mandiri, atau automasi rumah pintar Anda.',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppTheme.textLightGray,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // API Key Section
              Text(
                'KUNCI API PRIBADI (LIVE API KEY)',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE8EEFF)),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _showApiKey ? _apiKey : '••••••••••••••••••••••••••••••••••••••••',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12,
                          color: AppTheme.textDark,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _showApiKey ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                        color: AppTheme.primaryBlue,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _showApiKey = !_showApiKey;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Webhooks section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'WEBHOOK URLS',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLightGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    '+ Tambah URL',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE8EEFF)),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'https://api.myfinanceapp.com/v1/webhooks',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: AppTheme.textDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Events: transaction.success, transaction.failed',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppTheme.textLightGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
