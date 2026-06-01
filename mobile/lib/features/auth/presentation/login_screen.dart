import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/core/router/app_router.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  String _pin = '';
  bool _isSuccess = false;
  bool _isError = false;
  bool _isBiometricScanning = false;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    // Initialize date formatting safely
    initializeDateFormatting('id_ID', null);

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _shakeAnimation =
        Tween<double>(
            begin: 0.0,
            end: 12.0,
          ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _shakeController.reverse();
            }
          });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onKeyPress(String digit) {
    if (_isSuccess || _isBiometricScanning) return;
    if (_pin.length < 6) {
      setState(() {
        _isError = false;
        _pin += digit;
      });

      if (_pin.length == 6) {
        _verifyPin();
      }
    }
  }

  void _onBackspace() {
    if (_isSuccess || _isBiometricScanning) return;
    if (_pin.isNotEmpty) {
      setState(() {
        _isError = false;
        _pin = _pin.substring(0, _pin.length - 1);
      });
    }
  }

  void _verifyPin() {
    // Correct PIN: 123456 (Standard mock PIN)
    if (_pin == '123456') {
      _triggerSuccess();
    } else {
      _triggerError();
    }
  }

  void _triggerSuccess() async {
    setState(() {
      _isSuccess = true;
    });

    // Save mock token to secure storage
    await _storage.write(
      key: 'bank_satu_auth_token',
      value: 'mock_token_123456',
    );

    // Auto-navigate to Dashboard or redirect target after success animation
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        final from = GoRouterState.of(context).uri.queryParameters['from'];
        if (from != null && from.isNotEmpty) {
          context.go(from);
        } else {
          context.go('/');
        }
      }
    });
  }

  void _triggerError() {
    setState(() {
      _isError = true;
    });
    _shakeController.forward(from: 0.0);

    // Clear PIN after 800ms
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _pin = '';
          _isError = false;
        });
      }
    });
  }

  void _triggerBiometrics() {
    if (_isSuccess || _isBiometricScanning) return;

    setState(() {
      _isBiometricScanning = true;
    });

    // Simulate elite biometric scan delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isBiometricScanning = false;
        });
        _triggerSuccess();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: _isBiometricScanning
            ? _buildBiometricScanningView()
            : _buildPinLoginView(),
      ),
    );
  }

  Widget _buildPinLoginView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Brand & User Info Top Header
        Padding(
          padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
          child: Column(
            children: [
              // Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Platform.isIOS
                          ? CupertinoIcons.house_fill
                          : Icons.account_balance,
                      color: AppTheme.primaryBlue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'BankSatu',
                    style: GoogleFonts.inter(
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Animated User Greeting & Avatar
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryBlue, AppTheme.primaryBlueDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: AppTheme.premiumShadow,
                ),
                child: const Center(
                  child: Text(
                    'FA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Selamat Datang Kembali,',
                style: GoogleFonts.inter(
                  color: AppTheme.textLightGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Faisal Affan',
                style: GoogleFonts.inter(
                  color: AppTheme.textDark,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),

        // Middle PIN Indicators
        AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(
                _shakeAnimation.value * (1 - (_shakeController.value * 2)),
                0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    final isFilled = index < _pin.length;
                    Color dotColor = AppTheme.textDisabled;
                    if (_isSuccess) {
                      dotColor = AppTheme.shariaGreen;
                    } else if (_isError) {
                      dotColor = AppTheme.errorRed;
                    } else if (isFilled) {
                      dotColor = AppTheme.primaryBlue;
                    }

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dotColor,
                        border: Border.all(
                          color: isFilled || _isSuccess || _isError
                              ? Colors.transparent
                              : const Color(0xFFC3C6D6).withOpacity(0.5),
                          width: 1.5,
                        ),
                        boxShadow: isFilled && !_isError && !_isSuccess
                            ? [
                                BoxShadow(
                                  color: AppTheme.primaryBlue.withOpacity(0.3),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),

        // Bottom Custom Numerical Keypad
        Padding(
          padding: const EdgeInsets.only(bottom: 24, left: 32, right: 32),
          child: Column(
            children: [
              // 1-2-3
              _buildKeypadRow(['1', '2', '3']),
              const SizedBox(height: 12),
              // 4-5-6
              _buildKeypadRow(['4', '5', '6']),
              const SizedBox(height: 12),
              // 7-8-9
              _buildKeypadRow(['7', '8', '9']),
              const SizedBox(height: 12),
              // FaceID - 0 - Backspace
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Face ID Icon Button (Biometrics)
                  _buildBiometricKey(),
                  // 0
                  _buildKeypadButton('0'),
                  // Backspace
                  _buildBackspaceKey(),
                ],
              ),
              const SizedBox(height: 28),

              // Helper Action Text Links
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Lupa PIN?',
                      style: GoogleFonts.inter(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.pop(),
                    child: Text(
                      'Masuk Akun Lain',
                      style: GoogleFonts.inter(
                        color: AppTheme.textLightGray,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBiometricScanningView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Elegant rotating scanner mockup
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: AppTheme.floatingShadow,
              border: Border.all(
                color: AppTheme.primaryBlue.withOpacity(0.12),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Platform.isIOS
                        ? CupertinoIcons.lock_shield
                        : Icons.fingerprint,
                    color: AppTheme.primaryBlue,
                    size: 64,
                  ),
                  const SizedBox(height: 8),
                  Platform.isIOS
                      ? const CupertinoActivityIndicator(
                          radius: 8,
                          color: AppTheme.primaryBlue,
                        )
                      : const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Memindai Face ID...',
            style: GoogleFonts.inter(
              color: AppTheme.textDark,
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Dekatkan wajah Anda ke layar perangkat',
            style: GoogleFonts.inter(
              color: AppTheme.textLightGray,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: digits.map((d) => _buildKeypadButton(d)).toList(),
    );
  }

  Widget _buildKeypadButton(String digit) {
    return SizedBox(
      width: 72,
      height: 72,
      child: InkWell(
        onTap: () => _onKeyPress(digit),
        borderRadius: BorderRadius.circular(36),
        splashColor: AppTheme.primaryBlue.withOpacity(0.08),
        highlightColor: AppTheme.primaryBlue.withOpacity(0.04),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
            boxShadow: AppTheme.premiumShadow,
          ),
          child: Center(
            child: Text(
              digit,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBiometricKey() {
    return SizedBox(
      width: 72,
      height: 72,
      child: InkWell(
        onTap: _triggerBiometrics,
        borderRadius: BorderRadius.circular(36),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.06),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Platform.isIOS ? CupertinoIcons.lock_shield : Icons.fingerprint,
              color: AppTheme.primaryBlue,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceKey() {
    return SizedBox(
      width: 72,
      height: 72,
      child: InkWell(
        onTap: _onBackspace,
        borderRadius: BorderRadius.circular(36),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Platform.isIOS
                  ? CupertinoIcons.delete_left_fill
                  : Icons.backspace_outlined,
              color: AppTheme.textDark,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
