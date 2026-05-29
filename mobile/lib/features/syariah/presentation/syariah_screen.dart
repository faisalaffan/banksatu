import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:simulator/core/theme/app_theme.dart';
import 'package:simulator/features/syariah/bloc/syariah_bloc.dart';

class SyariahScreen extends StatefulWidget {
  const SyariahScreen({Key? key}) : super(key: key);

  @override
  State<SyariahScreen> createState() => _SyariahScreenState();
}

class _SyariahScreenState extends State<SyariahScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SyariahBloc>().add(LoadSyariah());
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Platform.isIOS ? CupertinoIcons.checkmark_seal : Icons.eco,
              color: AppTheme.shariaGreen,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'BankSatu Syariah',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: BlocBuilder<SyariahBloc, SyariahState>(
        builder: (context, state) {
          if (state is SyariahLoading) {
            return Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator(color: AppTheme.shariaGreen, radius: 14)
                  : const CircularProgressIndicator(color: AppTheme.shariaGreen),
            );
          }

          if (state is SyariahLoaded) {
            final d = state.data;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Dual Wallet Balance Header (Halal & Syubhat)
                  Row(
                    children: [
                      // Saldo Halal Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceCard,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppTheme.shariaGreen.withOpacity(0.2), width: 1.5),
                            boxShadow: AppTheme.premiumShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Platform.isIOS ? CupertinoIcons.checkmark_seal_fill : Icons.check_circle,
                                    color: AppTheme.shariaGreen,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'SALDO HALAL',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: AppTheme.shariaGreen,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _formatCurrency(d.halalBalance),
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Saldo Syubhat Card
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceCard,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: d.syubhatBalance > 0
                                  ? AppTheme.errorRed.withOpacity(0.2)
                                  : const Color(0xFFE8EEFF),
                              width: 1.5,
                            ),
                            boxShadow: AppTheme.premiumShadow,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Platform.isIOS
                                        ? CupertinoIcons.exclamationmark_triangle_fill
                                        : Icons.warning_amber_rounded,
                                    color: d.syubhatBalance > 0 ? AppTheme.errorRed : AppTheme.textDisabled,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'DANA SYUBHAT',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: d.syubhatBalance > 0 ? AppTheme.errorRed : AppTheme.textDisabled,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _formatCurrency(d.syubhatBalance),
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: d.syubhatBalance > 0 ? AppTheme.textDark : AppTheme.textDisabled,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Syubhat Cleansing Module
                  if (d.syubhatBalance > 0)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFDAD6), // Red container light
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppTheme.errorRed.withOpacity(0.12), width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Platform.isIOS ? CupertinoIcons.sparkles : Icons.clean_hands_rounded,
                                color: AppTheme.errorRed,
                                size: 22,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Pembersihan Dana Syubhat',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF410002),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Anda memiliki Rp ${d.syubhatBalance.toInt()} akumulasi dana bunga/reward non-halal. Bersihkan dana ini sekarang untuk menyalurkannya langsung ke badan sosial/zakat terverifikasi.',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: const Color(0xFF410002).withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<SyariahBloc>().add(CleanseSyubhat());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Pembersihan Sukses! Dana Syubhat disalurkan ke ZISWAF.',
                                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                                  ),
                                  backgroundColor: AppTheme.shariaGreen,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.errorRed,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Text(
                              'Bersihkan Sekarang',
                              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD0F2E1), // Green container light
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppTheme.shariaGreen.withOpacity(0.12), width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Platform.isIOS ? CupertinoIcons.checkmark_circle : Icons.check_circle_outline,
                            color: AppTheme.shariaGreen,
                            size: 24,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dana Anda Suci & Bersih!',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.shariaGreen,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Tidak ada dana syubhat terdeteksi di dompet Anda saat ini.',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    color: AppTheme.shariaGreen.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Zakat Auto-Debit Calculator
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          title: 'KALKULATOR ZAKAT MAAL OTOMATIS',
                          subtitle: 'Estimasi kewajiban zakat 2.5% dari saldo aktif Anda.',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Estimasi Zakat Mal',
                              style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: AppTheme.textLightGray,
                                  fontWeight: FontWeight.w500,
                                ),
                            ),
                            Text(
                              _formatCurrency(d.zakatDue),
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: AppTheme.shariaGreen,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Jadwalkan Auto-Debit Zakat',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Daftar debet otomatis setiap tanggal haul.',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      color: AppTheme.textLightGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Switch.adaptive(
                              value: d.zakatAutoDebitEnabled,
                              onChanged: (_) => context.read<SyariahBloc>().add(ToggleZakatAutoDebit()),
                              activeColor: AppTheme.shariaGreen,
                            ),
                          ],
                        ),
                        if (d.zakatDue > 0) ...[
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<SyariahBloc>().add(PayZakatNow(d.zakatDue));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Zakat Maal berhasil disalurkan secara instan!',
                                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                                  ),
                                  backgroundColor: AppTheme.shariaGreen,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.shariaGreen,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            ),
                            child: Text(
                              'Bayar Zakat Sekarang',
                              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Akad Transparency Module
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceCard,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                      boxShadow: AppTheme.premiumShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(
                          title: 'TRANSPARANSI AKAD DIGITAL',
                          subtitle: 'Pilih dan tandatangani akad produk perbankan secara syah.',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Akad Sukses Saat Ini',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppTheme.textLightGray,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: d.isAkadSigned
                                    ? AppTheme.shariaGreen.withOpacity(0.08)
                                    : AppTheme.warningAmber.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    d.isAkadSigned
                                        ? (Platform.isIOS ? CupertinoIcons.checkmark_shield_fill : Icons.verified_user)
                                        : (Platform.isIOS ? CupertinoIcons.clock : Icons.pending_actions),
                                    color: d.isAkadSigned ? AppTheme.shariaGreen : AppTheme.warningAmber,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    d.isAkadSigned ? 'Sudah Ttd' : 'Menunggu Ttd',
                                    style: GoogleFonts.inter(
                                      color: d.isAkadSigned ? AppTheme.shariaGreen : AppTheme.warningAmber,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          d.selectedAkad,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        Text(
                          'PILIH & GANTI AKAD PRODUK',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textLightGray,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: d.availableAkads.length,
                          itemBuilder: (context, idx) {
                            final akadName = d.availableAkads[idx];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: InkWell(
                                onTap: () => _showAkadSigningDrawer(context, akadName),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppTheme.background,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFFE8EEFF), width: 1),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          akadName,
                                          style: GoogleFonts.inter(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textDark,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Platform.isIOS ? CupertinoIcons.pencil_ellipsis_rectangle : Icons.edit_note_rounded,
                                        color: AppTheme.shariaGreen,
                                        size: 22,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Bottom padding spacer to avoid persistent floating navigation bar clipping
                  const SizedBox(height: 120),
                ],
              ),
            );
          }

          return const Center(child: Text('Terjadi kesalahan fatal.'));
        },
      ),
    );
  }

  void _showAkadSigningDrawer(BuildContext context, String akadName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          child: Container(
            color: AppTheme.surfaceCard,
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 48,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppTheme.textDisabled,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Icon(
                      Platform.isIOS ? CupertinoIcons.pencil_outline : Icons.border_color_outlined,
                      color: AppTheme.shariaGreen,
                      size: 26,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Tandatangan Akad Digital',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textDark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Tinjau isi kesepakatan produk dan bubuhkan tandatangan digital Anda di bawah.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppTheme.textLightGray,
                  ),
                ),
                const SizedBox(height: 20),

                // Mock Contract Clause Box
                Container(
                  height: 120,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE8EEFF)),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      'Dengan ini, Pihak Pertama (Nasabah) sepakat melakukan perikatan jual-beli atau penitipan modal kepada Pihak Kedua (BankSatu Syariah) berdasarkan prinsip "$akadName". Bank berhak mengelola dana sesuai syariat Islam, dengan skema bagi hasil (nisbah) transparan tanpa unsur riba/riba fadl. Ketentuan ini sah sejak ditandatangani secara digital.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textLightGray,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Mock Signature Area (Paint canvas widget)
                Text(
                  'BUBUHKAN TANDATANGAN DI SINI',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textLightGray,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.background,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFE3E8F9), style: BorderStyle.solid),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Platform.isIOS ? CupertinoIcons.hand_draw : Icons.gesture_rounded,
                          color: AppTheme.textDisabled,
                          size: 24,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sentuh & Geser untuk Tanda Tangan',
                          style: GoogleFonts.inter(fontSize: 11, color: AppTheme.textDisabled),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    context.read<SyariahBloc>().add(SignAkad(akadName));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Akad $akadName Berhasil Ditandatangani!',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                        ),
                        backgroundColor: AppTheme.shariaGreen,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.shariaGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    'Setuju & Tandatangani Akad',
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppTheme.textLightGray,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppTheme.textLightGray,
          ),
        ),
      ],
    );
  }
}
