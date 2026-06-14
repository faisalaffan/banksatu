import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class SessionLog {
  final String device;
  final String location;
  final String ip;
  final String date;
  final bool isCurrent;

  SessionLog({
    required this.device,
    required this.location,
    required this.ip,
    required this.date,
    required this.isCurrent,
  });
}

class SecurityLogsScreen extends StatefulWidget {
  const SecurityLogsScreen({Key? key}) : super(key: key);

  @override
  State<SecurityLogsScreen> createState() => _SecurityLogsScreenState();
}

class _SecurityLogsScreenState extends State<SecurityLogsScreen> {
  final List<SessionLog> _sessions = [
    SessionLog(
      device: 'iPhone 15 Pro Max (iOS)',
      location: 'Bandung, Indonesia',
      ip: '182.253.140.23',
      date: 'Aktif Sekarang',
      isCurrent: true,
    ),
    SessionLog(
      device: 'MacBook Pro 16 (macOS)',
      location: 'Jakarta, Indonesia',
      ip: '36.85.102.191',
      date: 'Kemarin, 14:23',
      isCurrent: false,
    ),
    SessionLog(
      device: 'Chrome Browser (Windows)',
      location: 'Surabaya, Indonesia',
      ip: '114.79.12.87',
      date: '24 Mei 2026, 09:12',
      isCurrent: false,
    ),
  ];

  void _revokeSession(int index) {
    setState(() {
      _sessions.removeAt(index);
    });
    _showToast('Sesi perangkat berhasil dicabut.');
  }

  void _revokeAllSessions() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Cabut Semua Sesi?'),
          content: const Text('Tindakan ini akan mengakhiri semua sesi aktif di perangkat lain kecuali perangkat yang Anda gunakan saat ini.'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Cabut Semua'),
              onPressed: () {
                setState(() {
                  _sessions.removeWhere((s) => !s.isCurrent);
                });
                Navigator.pop(context);
                _showToast('Semua sesi eksternal dicabut.');
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Cabut Semua Sesi?'),
          content: const Text('Tindakan ini akan mengakhiri semua sesi aktif di perangkat lain kecuali perangkat yang Anda gunakan saat ini.'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text('Cabut Semua', style: TextStyle(color: AppTheme.errorRed)),
              onPressed: () {
                setState(() {
                  _sessions.removeWhere((s) => !s.isCurrent);
                });
                Navigator.pop(context);
                _showToast('Semua sesi eksternal dicabut.');
              },
            ),
          ],
        ),
      );
    }
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: AppTheme.primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Jejak Keamanan & Sesi'),
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
              // Security shield status
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0F2027), Color(0xFF2C5364)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: AppTheme.floatingShadow,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.shield_fill,
                        color: Colors.greenAccent,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Akun Anda Aman',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Sistem memantau sesi masuk secara real-time untuk mencegah intrusi asing.',
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 11,
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

              // Sessions list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SESI PERANGKAT AKTIF',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLightGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  if (_sessions.length > 1)
                    GestureDetector(
                      onTap: _revokeAllSessions,
                      child: Text(
                        'Cabut Semua',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: AppTheme.errorRed,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _sessions.length,
                itemBuilder: (context, index) {
                  final s = _sessions[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (s.isCurrent ? AppTheme.shariaGreen : AppTheme.textLightGray).withOpacity(0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                s.isCurrent ? CupertinoIcons.device_phone_portrait : CupertinoIcons.desktopcomputer,
                                color: s.isCurrent ? AppTheme.shariaGreen : AppTheme.textLightGray,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      s.device,
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.textDark,
                                      ),
                                    ),
                                    if (s.isCurrent) ...[
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppTheme.shariaGreen.withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          'INI',
                                          style: GoogleFonts.inter(
                                            color: AppTheme.shariaGreen,
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${s.location} • IP: ${s.ip}',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppTheme.textLightGray,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  s.date,
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    color: s.isCurrent ? AppTheme.shariaGreen : AppTheme.textLightGray,
                                    fontWeight: s.isCurrent ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (!s.isCurrent)
                          GestureDetector(
                            onTap: () => _revokeSession(index),
                            child: const Icon(
                              CupertinoIcons.clear_circled_solid,
                              color: AppTheme.errorRed,
                              size: 20,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),

              // Security Advisory Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1), width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      CupertinoIcons.info_circle_fill,
                      color: AppTheme.primaryBlue,
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tips Keamanan',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Jika Anda melihat aktivitas masuk dari lokasi atau perangkat yang mencurigakan, segera cabut sesi perangkat tersebut dan ganti kata sandi PIN BankSatu Anda.',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppTheme.textLightGray,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
