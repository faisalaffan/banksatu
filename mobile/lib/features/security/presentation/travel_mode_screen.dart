import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class TravelModeScreen extends StatefulWidget {
  const TravelModeScreen({Key? key}) : super(key: key);

  @override
  State<TravelModeScreen> createState() => _TravelModeScreenState();
}

class _TravelModeScreenState extends State<TravelModeScreen> {
  bool _isActive = false;
  final List<Map<String, dynamic>> _countries = [
    {'name': 'Singapura', 'code': 'SG', 'selected': true},
    {'name': 'Malaysia', 'code': 'MY', 'selected': false},
    {'name': 'Jepang', 'code': 'JP', 'selected': false},
    {'name': 'Australia', 'code': 'AU', 'selected': false},
  ];

  void _toggleCountry(int index) {
    setState(() {
      _countries[index]['selected'] = !_countries[index]['selected'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Travel Mode',
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE8EEFF)),
                boxShadow: AppTheme.premiumShadow,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mode Perjalanan Luar Negeri',
                          style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Aktifkan penggunaan kartu debit/kredit Anda di luar wilayah Indonesia secara aman.',
                          style: GoogleFonts.inter(color: AppTheme.textLightGray, fontSize: 11, height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Switch.adaptive(
                    value: _isActive,
                    activeColor: AppTheme.shariaGreen,
                    onChanged: (val) => setState(() => _isActive = val),
                  ),
                ],
              ),
            ),
            if (_isActive) ...[
              const SizedBox(height: 28),
              Text(
                'Daftar Negara Whitelist',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _countries.length,
                itemBuilder: (context, index) {
                  final c = _countries[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE8EEFF)),
                    ),
                    child: CheckboxListTile.adaptive(
                      title: Text(c['name'], style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: Text('Kode ISO: ${c['code']}', style: GoogleFonts.inter(fontSize: 11)),
                      value: c['selected'],
                      activeColor: AppTheme.primaryBlue,
                      onChanged: (val) => _toggleCountry(index),
                    ),
                  );
                },
              ),
              const SizedBox(height: 28),
              Text(
                'Pengaturan Keamanan Tambahan',
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: AppTheme.textDark),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE8EEFF)),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today, color: AppTheme.primaryBlue),
                      title: Text('Tanggal Perjalanan', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: Text('15 Jun 2026 - 22 Jun 2026', style: GoogleFonts.inter(fontSize: 11)),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                    const Divider(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.credit_card, color: AppTheme.primaryBlue),
                      title: Text('Limit Belanja Harian', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: Text('Maksimal Rp 25.000.000 / hari', style: GoogleFonts.inter(fontSize: 11)),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
      bottomNavigationBar: _isActive
          ? Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFF1F3FF))),
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                    child: Text('Simpan Pengaturan Travel', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
