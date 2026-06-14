import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class VoiceBankingScreen extends StatefulWidget {
  const VoiceBankingScreen({Key? key}) : super(key: key);

  @override
  State<VoiceBankingScreen> createState() => _VoiceBankingScreenState();
}

class _VoiceBankingScreenState extends State<VoiceBankingScreen> {
  bool _isListening = false;
  String _transcript = 'Ketuk mikrofon dan mulailah berbicara...';
  String _assistantReply = '';

  void _startListening() {
    setState(() {
      _isListening = true;
      _transcript = 'Mendengarkan suara Anda...';
      _assistantReply = '';
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        setState(() {
          _isListening = false;
          _transcript = '"Kirim 50 ribu ke Budi Pratama untuk patungan kopi"';
          _assistantReply = 'Mentransfer Rp 50.000 ke Budi Pratama. Konfirmasikan dengan PIN/Face ID Anda.';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Voice Banking',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textDark),
        ),
        leading: IconButton(
          icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back, color: AppTheme.textDark),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Perintah Suara Pintar',
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                ),
                const SizedBox(height: 6),
                Text(
                  'Gunakan suara Anda untuk melakukan transaksi tanpa menyentuh layar.',
                  style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLightGray, height: 1.3),
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE8EEFF)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Transkripsi Suara Anda:',
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textLightGray),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _transcript,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: _isListening ? AppTheme.primaryBlue : AppTheme.textDark,
                          fontStyle: _isListening ? FontStyle.italic : FontStyle.normal,
                        ),
                      ),
                      if (_assistantReply.isNotEmpty) ...[
                        const Divider(height: 24),
                        Text(
                          'Respon Asisten:',
                          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.textLightGray),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _assistantReply,
                          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.shariaGreen),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                if (_isListening)
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 4,
                          height: (index % 2 == 0 ? 30 : 15),
                          decoration: BoxDecoration(color: AppTheme.primaryBlue, borderRadius: BorderRadius.circular(2)),
                        );
                      }),
                    ),
                  ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _isListening ? null : _startListening,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: _isListening ? AppTheme.primaryBlue.withOpacity(0.12) : AppTheme.primaryBlue,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none_outlined,
                      color: _isListening ? AppTheme.primaryBlue : Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _isListening ? 'Mendengarkan...' : 'Ketuk untuk Bicara',
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.textLightGray),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
