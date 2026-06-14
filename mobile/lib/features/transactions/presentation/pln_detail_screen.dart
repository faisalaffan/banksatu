import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class PLNDetailScreen extends StatefulWidget {
  const PLNDetailScreen({Key? key}) : super(key: key);

  @override
  State<PLNDetailScreen> createState() => _PLNDetailScreenState();
}

class _PLNDetailScreenState extends State<PLNDetailScreen> {
  void _showPinSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const PinCodeSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Konfirmasi Pembayaran',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Biller Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.premiumShadow,
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF9E6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: Colors.amber,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PLN Pascabayar',
                        style: GoogleFonts.inter(
                          color: AppTheme.textDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Penyedia Jasa: PT PLN (Persero)',
                        style: GoogleFonts.inter(
                          color: AppTheme.textLightGray,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Detailed Digital Receipt Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: AppTheme.premiumShadow,
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Rincian',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildReceiptRow('ID Pelanggan', '532104928392'),
                  _buildReceiptRow('Nama Pelanggan', 'Faisal Affan'),
                  _buildReceiptRow('Tarif / Daya', 'R1 / 2200 VA'),
                  _buildReceiptRow('Periode Tagihan', 'Mei 2026'),
                  const Divider(height: 32, color: Color(0xFFF1F3FF)),
                  _buildReceiptRow('Jumlah Tagihan', 'Rp 442.500'),
                  _buildReceiptRow('Biaya Admin', 'Rp 7.500'),
                  const Divider(height: 32, color: Color(0xFFF1F3FF)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pembayaran',
                        style: GoogleFonts.inter(
                          color: AppTheme.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Rp 450.000',
                        style: GoogleFonts.inter(
                          color: AppTheme.primaryBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Source of Funds info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Row(
                children: [
                  Icon(
                    Platform.isIOS ? CupertinoIcons.creditcard_fill : Icons.account_balance_wallet,
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sumber Dana',
                          style: GoogleFonts.inter(
                            color: AppTheme.textDark,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          'Tabungan Utama • Rp 25.800.000',
                          style: GoogleFonts.inter(
                            color: AppTheme.textLightGray,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
              onPressed: _showPinSheet,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                'Konfirmasi & Bayar',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppTheme.textLightGray,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: AppTheme.textDark,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// Custom 6-Digit PIN Bottom Sheet Code overlay
class PinCodeSheet extends StatefulWidget {
  const PinCodeSheet({Key? key}) : super(key: key);

  @override
  State<PinCodeSheet> createState() => _PinCodeSheetState();
}

class _PinCodeSheetState extends State<PinCodeSheet> {
  String _pin = '';
  bool _isVerifying = false;

  void _onKeyPress(String val) {
    if (_pin.length < 6) {
      setState(() {
        _pin += val;
      });

      if (_pin.length == 6) {
        _verifyPin();
      }
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _verifyPin() {
    setState(() {
      _isVerifying = true;
    });

    // Simulate Payment Execution Processing
    Future.delayed(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });

        Navigator.of(context).pop(); // dismiss PIN sheet

        // Show premium Native success dialog
        showDialog(
          context: context,
          builder: (context) => Platform.isIOS
              ? CupertinoAlertDialog(
                  title: const Text('Pembayaran Berhasil'),
                  content: const Text(
                      'Tagihan PLN Pascabayar Anda sebesar Rp 450.000 telah sukses dibayar.'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('Kembali ke Beranda'),
                      onPressed: () {
                        Navigator.of(context).pop(); // dismiss dialog
                        GoRouter.of(context).go('/'); // deep link back to root
                      },
                    ),
                  ],
                )
              : AlertDialog(
                  title: const Text('Pembayaran Berhasil'),
                  content: const Text(
                      'Tagihan PLN Pascabayar Anda sebesar Rp 450.000 telah sukses dibayar.'),
                  actions: [
                    TextButton(
                      child: const Text('Kembali ke Beranda'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        GoRouter.of(context).go('/');
                      },
                    ),
                  ],
                ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag handle indicator
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.textDisabled.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            _isVerifying ? 'Memproses Transaksi...' : 'Masukkan PIN Keamanan',
            style: GoogleFonts.inter(
              color: AppTheme.textDark,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Demi keamanan Anda, silakan verifikasi transaksi ini dengan PIN 6-digit.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppTheme.textLightGray,
              fontSize: 12,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 32),

          // Circle PIN indicators dots
          if (_isVerifying)
            Platform.isIOS
                ? const CupertinoActivityIndicator(
                    color: AppTheme.primaryBlue, radius: 14)
                : const CircularProgressIndicator(color: AppTheme.primaryBlue)
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                final active = index < _pin.length;
                return Container(
                  width: 14,
                  height: 14,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active ? AppTheme.primaryBlue : const Color(0xFFF1F3FF),
                    border: Border.all(
                      color: active ? AppTheme.primaryBlue : const Color(0xFFC3C6D6),
                      width: 1,
                    ),
                  ),
                );
              }),
            ),
          const SizedBox(height: 40),

          // Numeric Keypad Dials Grid (1 to 9, Backspace, 0)
          if (!_isVerifying)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                if (index == 9) {
                  return const SizedBox.shrink(); // empty bottom left
                }
                if (index == 11) {
                  // Backspace bottom right
                  return InkWell(
                    onTap: _onBackspace,
                    borderRadius: BorderRadius.circular(100),
                    child: const Center(
                      child: Icon(
                        Icons.backspace_outlined,
                        color: AppTheme.textDark,
                        size: 20,
                      ),
                    ),
                  );
                }

                final val = index == 10 ? '0' : (index + 1).toString();
                return InkWell(
                  onTap: () => _onKeyPress(val),
                  borderRadius: BorderRadius.circular(100),
                  child: Center(
                    child: Text(
                      val,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ),
                );
              },
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
