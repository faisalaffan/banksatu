import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class VirtualCard {
  final String label;
  final String number;
  final String expiry;
  final String cvv;
  final bool isFrozen;
  final Color cardColor;

  VirtualCard({
    required this.label,
    required this.number,
    required this.expiry,
    required this.cvv,
    required this.isFrozen,
    required this.cardColor,
  });
}

class VirtualCardScreen extends StatefulWidget {
  const VirtualCardScreen({Key? key}) : super(key: key);

  @override
  State<VirtualCardScreen> createState() => _VirtualCardScreenState();
}

class _VirtualCardScreenState extends State<VirtualCardScreen> {
  final List<VirtualCard> _cards = [
    VirtualCard(
      label: 'Kartu Belanja Utama',
      number: '4859 1029 4810 2938',
      expiry: '09/31',
      cvv: '123',
      isFrozen: false,
      cardColor: AppTheme.primaryBlue,
    ),
    VirtualCard(
      label: 'Langganan Netflix & Spotify',
      number: '4859 2201 3912 8765',
      expiry: '12/28',
      cvv: '456',
      isFrozen: true,
      cardColor: const Color(0xFFE5A93B),
    ),
  ];

  bool _showDetails = false;

  void _toggleCardFreeze(int index) {
    setState(() {
      _cards[index] = VirtualCard(
        label: _cards[index].label,
        number: _cards[index].number,
        expiry: _cards[index].expiry,
        cvv: _cards[index].cvv,
        isFrozen: !_cards[index].isFrozen,
        cardColor: _cards[index].cardColor,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Virtual Cards'),
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
              // Detail visibility toggle header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'KARTU VIRTUAL ANDA',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textLightGray,
                      letterSpacing: 1.2,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showDetails = !_showDetails;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          _showDetails ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill,
                          color: AppTheme.primaryBlue,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _showDetails ? 'Sembunyikan' : 'Tampilkan Detail',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Cards List
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      gradient: card.isFrozen
                          ? const LinearGradient(
                              colors: [Color(0xFF8E909A), Color(0xFF5A5C64)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [card.cardColor, card.cardColor.withOpacity(0.8)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: (card.isFrozen ? Colors.black : card.cardColor).withOpacity(0.25),
                          offset: const Offset(0, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              card.label,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                card.isFrozen ? Icons.play_arrow_rounded : Icons.pause_rounded,
                                color: Colors.white,
                              ),
                              tooltip: card.isFrozen ? 'Aktifkan' : 'Bekukan',
                              onPressed: () => _toggleCardFreeze(index),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _showDetails ? card.number : '••••  ••••  ••••  ${card.number.substring(15)}',
                          style: GoogleFonts.jetBrainsMono(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'EXPIRES',
                                  style: GoogleFonts.inter(color: Colors.white60, fontSize: 8),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  card.expiry,
                                  style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CVV',
                                  style: GoogleFonts.inter(color: Colors.white60, fontSize: 8),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  _showDetails ? card.cvv : '•••',
                                  style: GoogleFonts.inter(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                              ],
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
