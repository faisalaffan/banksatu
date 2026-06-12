import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class DisputeTicket {
  final String ticketId;
  final String date;
  final String amount;
  final String status; // 'dalam investigasi', 'disetujui', 'ditolak'
  final String merchant;

  DisputeTicket({
    required this.ticketId,
    required this.date,
    required this.amount,
    required this.status,
    required this.merchant,
  });
}

class DisputeManagerScreen extends StatelessWidget {
  const DisputeManagerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DisputeTicket> tickets = [
      DisputeTicket(
        ticketId: 'DSP-29188',
        date: '10 Jun 2026',
        amount: 'Rp 250.000',
        status: 'Dalam Investigasi',
        merchant: 'Spotify USA (Unauthorized)',
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('In-App Dispute Manager'),
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
              // Welcome advice card
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
                      'Pusat Sanggahan Transaksi',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Apakah Anda mendeteksi transaksi yang tidak Anda kenal? Laporkan segera di sini. Tim fraud kami akan menginvestigasi dalam waktu maksimal 3x24 jam kerja.',
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

              // Active Disputes Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TIKET SANGGAHAN AKTIF',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLightGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    '+ Buat Baru',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Dispute List
              tickets.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          'Tidak ada tiket sanggahan aktif.',
                          style: GoogleFonts.inter(fontSize: 13, color: AppTheme.textLightGray),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final t = tickets[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceCard,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFE8EEFF)),
                            boxShadow: AppTheme.premiumShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    t.ticketId,
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.primaryBlue,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFC78314).withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      t.status,
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFFC78314),
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                t.merchant,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textDark,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Nilai: ${t.amount}',
                                    style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                                  ),
                                  Text(
                                    t.date,
                                    style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textLightGray),
                                  ),
                                ],
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
