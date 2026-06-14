import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class DeviceManagementScreen extends StatefulWidget {
  const DeviceManagementScreen({Key? key}) : super(key: key);

  @override
  State<DeviceManagementScreen> createState() => _DeviceManagementScreenState();
}

class _DeviceManagementScreenState extends State<DeviceManagementScreen> {
  final List<Map<String, dynamic>> _devices = [
    {
      'name': 'iPhone 15 Pro Max',
      'type': 'Perangkat Ini',
      'location': 'Jakarta, Indonesia',
      'active': 'Aktif Sekarang',
      'isCurrent': true
    },
    {
      'name': 'MacBook Pro 16"',
      'type': 'macOS App',
      'location': 'Bandung, Indonesia',
      'active': 'Aktif 2 jam yang lalu',
      'isCurrent': false
    },
    {
      'name': 'Samsung Galaxy S24 Ultra',
      'type': 'Android Device',
      'location': 'Surabaya, Indonesia',
      'active': 'Aktif 3 hari yang lalu',
      'isCurrent': false
    },
  ];

  void _remoteLogout(int index) {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Logout Perangkat?'),
              content: Text('Sesi di ${_devices[index]['name']} akan dihentikan paksa.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Batal'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Logout'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _devices.removeAt(index);
                    });
                  },
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Logout Perangkat?'),
              content: Text('Sesi di ${_devices[index]['name']} akan dihentikan paksa.'),
              actions: [
                TextButton(
                  child: const Text('Batal'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Logout', style: TextStyle(color: AppTheme.errorRed)),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _devices.removeAt(index);
                    });
                  },
                ),
              ],
            ),
    );
  }

  void _logoutAll() {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Logout Semua Perangkat Lain?'),
              content: const Text('Semua sesi aktif di perangkat lain akan dihentikan paksa.'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Batal'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Logout Semua'),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _devices.removeWhere((d) => !d['isCurrent']);
                    });
                  },
                ),
              ],
            )
          : AlertDialog(
              title: const Text('Logout Semua Perangkat Lain?'),
              content: const Text('Semua sesi aktif di perangkat lain akan dihentikan paksa.'),
              actions: [
                TextButton(
                  child: const Text('Batal'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Logout Semua', style: TextStyle(color: AppTheme.errorRed)),
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _devices.removeWhere((d) => !d['isCurrent']);
                    });
                  },
                ),
              ],
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Manajemen Perangkat',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Perangkat Terdaftar',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
            ),
            const SizedBox(height: 6),
            Text(
              'Kelola semua perangkat tepercaya yang terhubung ke akun perbankan digital Anda.',
              style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLightGray, height: 1.4),
            ),
            const SizedBox(height: 24),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final d = _devices[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: d['isCurrent'] ? AppTheme.primaryBlue.withOpacity(0.3) : const Color(0xFFE8EEFF),
                      width: d['isCurrent'] ? 1.5 : 1.0,
                    ),
                    boxShadow: AppTheme.premiumShadow,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: d['isCurrent'] ? AppTheme.primaryBlue.withOpacity(0.08) : Colors.grey.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Platform.isIOS ? CupertinoIcons.device_phone_portrait : Icons.smartphone,
                          color: d['isCurrent'] ? AppTheme.primaryBlue : AppTheme.textLightGray,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  d['name'],
                                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                                ),
                                if (d['isCurrent']) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.shariaGreen.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'AKTIF',
                                      style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.w900, color: AppTheme.shariaGreen),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${d['type']} • ${d['location']}',
                              style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              d['active'],
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: d['isCurrent'] ? AppTheme.primaryBlue : AppTheme.textLightGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!d['isCurrent'])
                        IconButton(
                          icon: const Icon(Icons.logout, color: AppTheme.errorRed),
                          onPressed: () => _remoteLogout(index),
                        ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 28),
            if (_devices.length > 1)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _logoutAll,
                  icon: const Icon(Icons.power_settings_new),
                  label: Text('Logout dari Semua Perangkat Lain', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.errorRed,
                    elevation: 0,
                    side: const BorderSide(color: Color(0xFFF1F3FF)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
