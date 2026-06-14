import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class ElderModeScreen extends StatelessWidget {
  const ElderModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Ultra high contrast
      appBar: AppBar(
        title: const Text(
          'MODE LANSIA (ELDER MODE)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Large Balance Widget
              Container(
                padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Column(
                  children: [
                    const Text(
                      'TOTAL SALDO ANDA SAAT INI:',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 1.0),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rp 25.800.000',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
              // Two Huge Buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 90,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // In reality would push to transfer
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_upward, size: 36, color: Colors.white),
                      label: const Text(
                        'KIRIM UANG',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 90,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // In reality would push to request money
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_downward, size: 36, color: Colors.white),
                      label: const Text(
                        'MINTA UANG',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.shariaGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                          side: const BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'Hubungi bantuan darurat / Customer Service jika Anda mengalami kesulitan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
