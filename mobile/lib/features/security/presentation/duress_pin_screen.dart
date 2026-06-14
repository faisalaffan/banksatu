import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class DuressPinScreen extends StatefulWidget {
  const DuressPinScreen({Key? key}) : super(key: key);

  @override
  State<DuressPinScreen> createState() => _DuressPinScreenState();
}

class _DuressPinScreenState extends State<DuressPinScreen> {
  bool _isActive = false;
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  double _fakeBalance = 500000.0; // mock Rp 500.000 decoy balance

  void _saveConfiguration() {
    showDialog(
      context: context,
      builder: (context) => Platform.isIOS
          ? CupertinoAlertDialog(
              title: const Text('Decoy PIN Disimpan'),
              content: const Text('Decoy PIN berhasil diset. Ketika PIN ini dimasukkan di layar Login, aplikasi akan menampilkan saldo palsu dan membisukan notifikasi.'),
              actions: [
                CupertinoDialogAction(child: const Text('Tutup'), onPressed: () => Navigator.pop(context)),
              ],
            )
          : AlertDialog(
              title: const Text('Decoy PIN Disimpan'),
              content: const Text('Decoy PIN berhasil diset. Ketika PIN ini dimasukkan di layar Login, aplikasi akan menampilkan saldo palsu dan membisukan notifikasi.'),
              actions: [
                TextButton(child: const Text('Tutup'), onPressed: () => Navigator.pop(context)),
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
          'Decoy/Duress PIN',
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
                          'Aktifkan Duress PIN',
                          style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Gunakan PIN alternatif saat dipaksa membuka aplikasi di bawah ancaman.',
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
                'Setup PIN Darurat (Decoy PIN)',
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
                    TextField(
                      controller: _pinController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Masukkan 6-Digit Decoy PIN', border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _confirmPinController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Ulangi PIN', border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                'Konfigurasi Tampilan Palsu (Decoy UI)',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Saldo Samaran:', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textLightGray)),
                        Text(
                          'Rp ${_fakeBalance.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w900, color: AppTheme.primaryBlue),
                        ),
                      ],
                    ),
                    Slider.adaptive(
                      value: _fakeBalance,
                      min: 100000.0,
                      max: 2000000.0,
                      divisions: 19,
                      activeColor: AppTheme.primaryBlue,
                      onChanged: (val) => setState(() => _fakeBalance = val),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Alarm Senyap (Silent Alert)', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                              const SizedBox(height: 2),
                              Text('Kirim sinyal lokasi & bantuan ke server darurat saat PIN dimasukkan.', style: GoogleFonts.inter(fontSize: 9, color: AppTheme.textLightGray, height: 1.3)),
                            ],
                          ),
                        ),
                        Switch.adaptive(
                          value: true,
                          activeColor: AppTheme.shariaGreen,
                          onChanged: (val) {},
                        ),
                      ],
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
                    onPressed: _saveConfiguration,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                    child: Text('Simpan Pengaturan Decoy', style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
