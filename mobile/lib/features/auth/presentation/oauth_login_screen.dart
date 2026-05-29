import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/theme/app_theme.dart';

class OAuthLoginScreen extends StatefulWidget {
  const OAuthLoginScreen({Key? key}) : super(key: key);

  @override
  State<OAuthLoginScreen> createState() => _OAuthLoginScreenState();
}

class _OAuthLoginScreenState extends State<OAuthLoginScreen> {
  bool _isAuthorizing = false;

  void _handleAuthorize() {
    setState(() {
      _isAuthorizing = true;
    });

    // Simulate link delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isAuthorizing = false;
        });

        // Show a premium native dialog confirming link success
        showDialog(
          context: context,
          builder: (context) => Platform.isIOS
              ? CupertinoAlertDialog(
                  title: const Text('Otorisasi Berhasil'),
                  content: const Text(
                      'Aplikasi Investasi X sekarang terhubung dengan aman ke akun BankSatu Anda.'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        if (this.mounted) {
                          this.context.pop(); // Go back to onboarding
                        }
                      },
                    ),
                  ],
                )
              : AlertDialog(
                  title: const Text('Otorisasi Berhasil'),
                  content: const Text(
                      'Aplikasi Investasi X sekarang terhubung dengan aman ke akun BankSatu Anda.'),
                  actions: [
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        if (this.mounted) {
                          this.context.pop(); // Go back to onboarding
                        }
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
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'BankSatu',
          style: GoogleFonts.inter(
            color: AppTheme.primaryBlue,
            fontWeight: FontWeight.w800,
            fontSize: 20,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: const Color(0xFFF1F3FF),
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: _isAuthorizing
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Platform.isIOS
                        ? const CupertinoActivityIndicator(
                            color: AppTheme.primaryBlue, radius: 16)
                        : const CircularProgressIndicator(
                            color: AppTheme.primaryBlue),
                    const SizedBox(height: 16),
                    Text(
                      'Menghubungkan Akun...',
                      style: GoogleFonts.inter(
                        color: AppTheme.textDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Connection Header (BankSatu Icon <=> Synced Partner App Icon)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // BankSatu Circle Icon
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppTheme.primaryBlue.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.account_balance,
                              color: AppTheme.primaryBlue,
                              size: 28,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Icon(
                            Icons.sync_alt,
                            color: AppTheme.textLightGray,
                          ),
                        ),
                        // Partner App Circle Icon (Aplikasi Investasi X)
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFE8EEFF),
                              width: 1,
                            ),
                            boxShadow: AppTheme.premiumShadow,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.trending_up,
                              color: AppTheme.shariaGreen,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Headings
                    Text(
                      'Aplikasi Investasi X',
                      style: GoogleFonts.inter(
                        color: AppTheme.textDark,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Meminta akses ke akun BankSatu Anda',
                      style: GoogleFonts.inter(
                        color: AppTheme.textLightGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Permissions Details Box
                    Container(
                      width: double.infinity,
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
                          Text(
                            'Informasi yang akan dibagikan:',
                            style: GoogleFonts.inter(
                              color: AppTheme.textDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 20),
                          _buildPermissionRow(
                            Platform.isIOS ? CupertinoIcons.person_crop_square_fill : Icons.badge,
                            'Nama Lengkap',
                            'Sesuai KTP Anda',
                          ),
                          const SizedBox(height: 16),
                          _buildPermissionRow(
                            Platform.isIOS ? CupertinoIcons.creditcard_fill : Icons.credit_card,
                            'Nomor Induk Kependudukan (NIK)',
                            'Untuk verifikasi identitas legal',
                          ),
                          const SizedBox(height: 16),
                          _buildPermissionRow(
                            Platform.isIOS ? CupertinoIcons.mail_solid : Icons.mark_email_read,
                            'Email Terverifikasi',
                            'Alamat email yang terdaftar di BankSatu',
                          ),
                          const SizedBox(height: 16),
                          _buildPermissionRow(
                            Platform.isIOS ? CupertinoIcons.checkmark_shield_fill : Icons.verified_user,
                            'Status Rekening',
                            'Status aktif/non-aktif rekening Anda',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Security Tip Row
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.shariaGreen.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppTheme.shariaGreen.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Platform.isIOS ? CupertinoIcons.lock_shield_fill : Icons.lock_outline,
                            color: AppTheme.shariaGreen,
                            size: 18,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Keamanan Terjamin',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.shariaGreen,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'BankSatu tidak akan pernah membagikan Password atau PIN Anda kepada Aplikasi Investasi X atau pihak ketiga manapun.',
                                  style: GoogleFonts.inter(
                                    color: AppTheme.textLightGray,
                                    fontSize: 11,
                                    height: 1.4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Actions
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleAuthorize,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryBlue,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Authorize',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: TextButton(
                        onPressed: () => context.pop(),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.textDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(color: Color(0xFFC3C6D6)),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildPermissionRow(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppTheme.primaryBlue,
          size: 20,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  color: AppTheme.textDark,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
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
    );
  }
}
