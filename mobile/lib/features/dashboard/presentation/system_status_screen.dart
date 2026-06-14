import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class SystemComponent {
  final String name;
  final String status;
  final String latency;
  final bool isOperational;

  SystemComponent({
    required this.name,
    required this.status,
    required this.latency,
    required this.isOperational,
  });
}

class SystemStatusScreen extends StatelessWidget {
  const SystemStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<SystemComponent> components = [
      SystemComponent(name: 'Core Banking Engine', status: 'Operational', latency: '42ms', isOperational: true),
      SystemComponent(name: 'Payment Gateway (BI-FAST)', status: 'Operational', latency: '120ms', isOperational: true),
      SystemComponent(name: 'Card Authorization Network', status: 'Operational', latency: '65ms', isOperational: true),
      SystemComponent(name: 'Mobile API Services', status: 'Operational', latency: '18ms', isOperational: true),
      SystemComponent(name: 'Database Cluster (MySQL)', status: 'Operational', latency: '2ms', isOperational: true),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Status Sistem & Uptime'),
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
              // Overall Status Hero Panel
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF006D37), Color(0xFF004D26)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF006D37).withOpacity(0.25),
                      offset: const Offset(0, 12),
                      blurRadius: 24,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: Colors.greenAccent,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SEMUA SISTEM OPERASIONAL',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Uptime 99.98% dalam 30 hari terakhir. Layanan perbankan digital berjalan dengan optimal.',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Diagnostics Header
              Text(
                'STATUS KOMPONEN INDIVIDU',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textLightGray,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),

              // Component Status Cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: components.length,
                itemBuilder: (context, index) {
                  final c = components[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.name,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Latency: ${c.latency}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppTheme.textLightGray,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF006D37).withOpacity(0.08),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            c.status,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF006D37),
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
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
