import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class GeolocationMapScreen extends StatelessWidget {
  const GeolocationMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Peta Transaksi (Geolocation)',
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
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE8EEFF)),
                boxShadow: AppTheme.premiumShadow,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Stylized grid background representing street layout mock
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.15,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                        itemCount: 48,
                        itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.primaryBlue),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Mock Street Lines
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Container(height: 12, color: Colors.white),
                  ),
                  Positioned(
                    left: 120,
                    top: 0,
                    bottom: 0,
                    child: Container(width: 12, color: Colors.white),
                  ),
                  // Simulated Map Pins
                  _buildMapPin(80, 150, 'Kopi Kenangan', AppTheme.primaryBlue),
                  _buildMapPin(160, 90, 'Superindo Supermarket', AppTheme.shariaGreen),
                  _buildMapPin(230, 220, 'Gaji Bulanan (Kantor)', Colors.amber),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        children: [
                          const Icon(Icons.my_location, size: 16, color: AppTheme.primaryBlue),
                          const SizedBox(width: 6),
                          Text('DKI Jakarta', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Riwayat Lokasi Belanja',
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                  ),
                  const SizedBox(height: 12),
                  _buildLocationRow('Kopi Kenangan - Senayan City', '12 Jun 2026, 15:30', 'Rp 45.000'),
                  _buildLocationRow('Superindo - Kebayoran Baru', '11 Jun 2026, 19:15', 'Rp 280.000'),
                  _buildLocationRow('Pertamina SPBU - Gatot Subroto', '09 Jun 2026, 08:45', 'Rp 150.000'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPin(double top, double left, String name, Color color) {
    return Positioned(
      top: top,
      left: left,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Text(name, style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
          ),
          Icon(Icons.location_on, color: color, size: 24),
        ],
      ),
    );
  }

  Widget _buildLocationRow(String place, String time, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EEFF)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
                const SizedBox(height: 2),
                Text(time, style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray)),
              ],
            ),
          ),
          Text(amount, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
        ],
      ),
    );
  }
}
