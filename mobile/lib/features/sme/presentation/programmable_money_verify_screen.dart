import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/core/router/app_router.dart';

class ProgrammableMoneyVerifyScreen extends StatefulWidget {
  const ProgrammableMoneyVerifyScreen({Key? key}) : super(key: key);

  @override
  State<ProgrammableMoneyVerifyScreen> createState() => _ProgrammableMoneyVerifyScreenState();
}

class _ProgrammableMoneyVerifyScreenState extends State<ProgrammableMoneyVerifyScreen> {
  String _pin = '';
  bool _isValidating = false;
  String _validationStep = '';
  String _selectedMerchant = 'Beras Makmur Jaya';
  String _selectedCategory = 'Sembako';
  double _spendingAmount = 120000;

  void _handleNumberPress(String number) {
    if (_pin.length < 6) {
      setState(() {
        _pin += number;
      });

      if (_pin.length == 6) {
        _startValidationProcess();
      }
    }
  }

  void _handleBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _startValidationProcess() {
    setState(() {
      _isValidating = true;
      _validationStep = 'Menghubungkan ke Kemensos Smart Contracts...';
    });

    // Step 1
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (!mounted) return;
      setState(() {
        _validationStep = 'Memeriksa kategori merchant: "$_selectedCategory"...';
      });

      // Step 2
      Future.delayed(const Duration(milliseconds: 1200), () {
        if (!mounted) return;
        final bool isAllowed = _selectedCategory == 'Sembako' || _selectedCategory == 'Pendidikan';

        if (isAllowed) {
          setState(() {
            _validationStep = 'Verifikasi Lolos! Mengamankan transaksi...';
          });

          // Success completion
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (!mounted) return;
            setState(() {
              _isValidating = false;
              _pin = '';
            });

            _showSuccessDialog();
          });
        } else {
          // Failure completion -> redirect to rejected screen
          Future.delayed(const Duration(milliseconds: 800), () {
            if (!mounted) return;
            setState(() {
              _isValidating = false;
              _pin = '';
            });
            const ProgrammableMoneyRejectedRoute().push(context);
          });
        }
      });
    });
  }

  void _showSuccessDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Pembayaran Sukses'),
          content: Text(
            'Transaksi di "$_selectedMerchant" sebesar Rp ${_spendingAmount.toStringAsFixed(0)} disetujui oleh Smart Contract Dana Bansos.',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Selesai'),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to details
              },
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Pembayaran Sukses'),
          content: Text(
            'Transaksi di "$_selectedMerchant" sebesar Rp ${_spendingAmount.toStringAsFixed(0)} disetujui oleh Smart Contract Dana Bansos.',
          ),
          actions: [
            TextButton(
              child: const Text('Selesai'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Otorisasi Bansos'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Platform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
            color: AppTheme.textDark,
          ),
        ),
      ),
      body: SafeArea(
        child: _isValidating
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBlue.withOpacity(0.06),
                          shape: BoxShape.circle,
                        ),
                        child: const SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Memvalidasi Transaksi',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _validationStep,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppTheme.textLightGray,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  // Merchant & Checkout Details Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceCard,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFE8EEFF), width: 1.5),
                        boxShadow: AppTheme.premiumShadow,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _selectedMerchant,
                                    style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: (_selectedCategory == 'Sembako'
                                              ? AppTheme.shariaGreen
                                              : AppTheme.errorRed)
                                          .withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      _selectedCategory.toUpperCase(),
                                      style: GoogleFonts.inter(
                                        color: _selectedCategory == 'Sembako'
                                            ? AppTheme.shariaGreen
                                            : AppTheme.errorRed,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Rp ${_spendingAmount.toStringAsFixed(0)}',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: Color(0xFFE8EEFF), height: 1),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Pilih Skenario Demo:',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.textLightGray,
                                ),
                              ),
                              Row(
                                children: [
                                  _buildScenarioBtn(
                                    label: 'Lolos',
                                    isActive: _selectedCategory == 'Sembako',
                                    onTap: () {
                                      setState(() {
                                        _selectedMerchant = 'Beras Makmur Jaya';
                                        _selectedCategory = 'Sembako';
                                        _spendingAmount = 120000;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                  _buildScenarioBtn(
                                    label: 'Ditolak',
                                    isActive: _selectedCategory == 'F&B Kafe',
                                    onTap: () {
                                      setState(() {
                                        _selectedMerchant = 'Kopi Kenangan';
                                        _selectedCategory = 'F&B Kafe';
                                        _spendingAmount = 45000;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // PIN Prompt header
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          'Masukkan PIN BankSatu Anda',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Konfirmasi transaksi aman untuk alokasi dana pintar',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.textLightGray,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // PIN Indicators (Circles)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        final isFilled = index < _pin.length;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFilled ? AppTheme.primaryBlue : Colors.transparent,
                            border: Border.all(
                              color: isFilled ? AppTheme.primaryBlue : AppTheme.textDisabled,
                              width: 2,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const Spacer(),

                  // Custom Premium Numeric Keypad
                  Container(
                    padding: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildKeypadBtn('1'),
                            _buildKeypadBtn('2'),
                            _buildKeypadBtn('3'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildKeypadBtn('4'),
                            _buildKeypadBtn('5'),
                            _buildKeypadBtn('6'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildKeypadBtn('7'),
                            _buildKeypadBtn('8'),
                            _buildKeypadBtn('9'),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 70, height: 70), // Empty placeholder
                            _buildKeypadBtn('0'),
                            GestureDetector(
                              onTap: _handleBackspace,
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Icon(
                                    CupertinoIcons.delete_left,
                                    color: AppTheme.textDark,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildScenarioBtn({required String label, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppTheme.primaryBlue : AppTheme.primaryBlue.withOpacity(0.06),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isActive ? Colors.white : AppTheme.primaryBlue,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadBtn(String number) {
    return GestureDetector(
      onTap: () => _handleNumberPress(number),
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE8EEFF), width: 1.5),
          boxShadow: AppTheme.premiumShadow,
        ),
        child: Center(
          child: Text(
            number,
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: AppTheme.textDark,
            ),
          ),
        ),
      ),
    );
  }
}
