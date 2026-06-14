import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';
import 'package:banksatu_mobile/core/router/app_router.dart';
import 'package:banksatu_mobile/features/security/bloc/security_bloc.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SecurityBloc>().add(LoadSecurity());
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Security & Card Control'),
      ),
      body: BlocBuilder<SecurityBloc, SecurityState>(
        builder: (context, state) {
          if (state is SecurityLoading) {
            return Center(
              child: Platform.isIOS
                  ? const CupertinoActivityIndicator(color: AppTheme.primaryBlue, radius: 14)
                  : const CircularProgressIndicator(color: AppTheme.primaryBlue),
            );
          }

          if (state is SecurityLoaded) {
            final s = state.settings;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Virtual Card Graphic (Frosted Grayscale when Frozen, Glowing Blue when active)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 220,
                    decoration: BoxDecoration(
                      gradient: s.cardFrozen
                          ? const LinearGradient(
                              colors: [Color(0xFF8E909A), Color(0xFF5A5C64)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : const LinearGradient(
                              colors: [AppTheme.primaryBlue, Color(0xFF0C56D0), AppTheme.primaryBlueDark],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: s.cardFrozen
                              ? Colors.black.withOpacity(0.1)
                              : AppTheme.primaryBlue.withOpacity(0.25),
                          offset: const Offset(0, 12),
                          blurRadius: 24,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Stack(
                        children: [
                          // Abstract vector overlay shapes
                          Positioned(
                            right: -50,
                            bottom: -50,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.04),
                              ),
                            ),
                          ),
                          Positioned(
                            left: -20,
                            top: -20,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.04),
                              ),
                            ),
                          ),

                          // Card Contents
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'BankSatu Gold Platinum',
                                      style: GoogleFonts.inter(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Platform.isIOS ? CupertinoIcons.wifi : Icons.wifi_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '••••   ••••   ••••   4859',
                                      style: GoogleFonts.jetBrainsMono(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'NAMA PEMEGANG KARTU',
                                              style: GoogleFonts.inter(
                                                color: Colors.white.withOpacity(0.5),
                                                fontSize: 8,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              'FAISAL AFFAN',
                                              style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'EXPIRES',
                                              style: GoogleFonts.inter(
                                                color: Colors.white.withOpacity(0.5),
                                                fontSize: 8,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '09/31',
                                              style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Frozen Overlay Graphic
                          if (s.cardFrozen)
                            Container(
                              color: Colors.black.withOpacity(0.4),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Platform.isIOS ? CupertinoIcons.lock_fill : Icons.lock,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'KARTU DI-BEKUKAN',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Freeze Toggles Section
                  Container(
                    padding: const EdgeInsets.all(20),
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
                          title: 'KONTROL TRANSAKSI SALURAN',
                          subtitle: 'Bekukan kartu atau kunci akses pembayaran digital.',
                        ),
                        const SizedBox(height: 16),
                        _buildSwitchRow(
                          icon: Platform.isIOS ? CupertinoIcons.snow : Icons.ac_unit_rounded,
                          title: 'Bekukan Kartu Utama',
                          subtitle: 'Kunci seluruh transaksi kartu debit Anda secara real-time.',
                          value: s.cardFrozen,
                          onChanged: (_) => context.read<SecurityBloc>().add(ToggleCardFreeze()),
                          activeColor: AppTheme.errorRed,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildSwitchRow(
                          icon: Platform.isIOS ? CupertinoIcons.globe : Icons.language_rounded,
                          title: 'Kunci Transaksi Internasional',
                          subtitle: 'Blokir penggunaan kartu di merchant luar negeri.',
                          value: s.internationalLocked,
                          onChanged: (_) => context.read<SecurityBloc>().add(ToggleInternational()),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildSwitchRow(
                          icon: Platform.isIOS ? CupertinoIcons.cart : Icons.phonelink_ring_rounded,
                          title: 'Kunci Belanja Online (E-Commerce)',
                          subtitle: 'Blokir card-not-present transaksi online.',
                          value: s.onlinePaymentLocked,
                          onChanged: (_) => context.read<SecurityBloc>().add(ToggleOnlinePayment()),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Spending Limit Section
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
                          title: 'PENGATURAN LIMIT BELANJA HARIAN',
                          subtitle: 'Atur batas spending aman Anda dalam 24 Jam.',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Batas Maksimal Harian',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppTheme.textLightGray,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _formatCurrency(s.dailySpendingLimit),
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: AppTheme.primaryBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Platform.isIOS
                            ? SizedBox(
                                width: double.infinity,
                                child: CupertinoSlider(
                                  value: s.dailySpendingLimit,
                                  min: 1000000.00,  // Min Rp 1jt
                                  max: 50000000.00, // Max Rp 50jt
                                  activeColor: AppTheme.primaryBlue,
                                  onChanged: (val) {
                                    context.read<SecurityBloc>().add(UpdateSpendingLimit(val));
                                  },
                                ),
                              )
                            : SliderTheme(
                                data: SliderThemeData(
                                  activeTrackColor: AppTheme.primaryBlue,
                                  inactiveTrackColor: const Color(0xFFE3E8F9),
                                  thumbColor: AppTheme.primaryBlue,
                                  overlayColor: AppTheme.primaryBlue.withOpacity(0.12),
                                  trackHeight: 6,
                                ),
                                child: Slider(
                                  value: s.dailySpendingLimit,
                                  min: 1000000.00,  // Min Rp 1jt
                                  max: 50000000.00, // Max Rp 50jt
                                  onChanged: (val) {
                                    context.read<SecurityBloc>().add(UpdateSpendingLimit(val));
                                  },
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Rp 1.000.000', style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray)),
                            Text('Rp 50.000.000', style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textLightGray)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Passkey & Categories Locks Section
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
                          title: 'BIOMETRIC & CATEGORY LOCKS (MCC)',
                          subtitle: 'Keamanan ekstra lewat FIDO2 dan spending lock per merchant.',
                        ),
                        const SizedBox(height: 16),
                        _buildSwitchRow(
                          icon: Platform.isIOS ? CupertinoIcons.lock_shield : Icons.fingerprint_rounded,
                          title: 'FIDO2 / Passkey Login & Sign',
                          subtitle: 'Otorisasi transaksi besar menggunakan hardware biometric.',
                          value: s.passkeyEnabled,
                          onChanged: (_) => context.read<SecurityBloc>().add(TogglePasskey()),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        Text(
                          'KUNCI BELANJA PER KATEGORI (MCC FILTER)',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textLightGray,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildCategoryChip(context, 'Entertainment', s.lockedMerchantCategories),
                            _buildCategoryChip(context, 'Gaming', s.lockedMerchantCategories),
                            _buildCategoryChip(context, 'Shopping', s.lockedMerchantCategories),
                            _buildCategoryChip(context, 'Dining', s.lockedMerchantCategories),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Advanced Security Features Section
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
                          title: 'KEAMANAN LANJUTAN',
                          subtitle: 'Kelola kartu, ahli waris digital, sengketa, dan API.',
                        ),
                        const SizedBox(height: 16),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.creditcard_fill : Icons.credit_card,
                          title: 'Atur Limit Kartu',
                          subtitle: 'Batas pengeluaran & kontrol MCC.',
                          onTap: () => const CardLimitSettingsRoute().push(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.person_2_fill : Icons.family_restroom,
                          title: 'Ahli Waris Digital',
                          subtitle: 'Atur penerus akses akun digital Anda.',
                          onTap: () => const DigitalHeirRoute().push(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.exclamationmark_bubble_fill : Icons.gavel,
                          title: 'Manajer Sengketa',
                          subtitle: 'Ajukan & lacak penyelesaian transaksi.',
                          onTap: () => const DisputeManagerRoute().push(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.creditcard_fill : Icons.credit_card_off,
                          title: 'Kartu Virtual',
                          subtitle: 'Buat kartu digital sekali pakai untuk online.',
                          onTap: () => const VirtualCardRoute().push(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.creditcard : Icons.credit_score,
                          title: 'Manajemen Kartu Kredit',
                          subtitle: 'Pantau tagihan & limit kredit harian.',
                          onTap: () => const CreditCardRoute().push(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.device_phone_portrait : Icons.smartphone,
                          title: 'Manajemen Perangkat',
                          subtitle: 'Kelola perangkat & remote logout.',
                          onTap: () => const DeviceManagementRoute().push(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.airplane : Icons.flight_takeoff,
                          title: 'Travel Mode',
                          subtitle: 'Whitelist transaksi luar negeri.',
                          onTap: () => const TravelModeRoute().push(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.shield_slash : Icons.gpp_maybe,
                          title: 'Decoy/Duress PIN',
                          subtitle: 'PIN darurat untuk keamanan terancam.',
                          onTap: () => const DuressPinRoute().push(context),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(color: Color(0xFFE8EEFF)),
                        ),
                        _buildNavRow(
                          icon: Platform.isIOS ? CupertinoIcons.gear_alt_fill : Icons.api,
                          title: 'API & Webhooks Pribadi',
                          subtitle: 'Generate token akses & integrasi.',
                          onTap: () => const PersonalApiRoute().push(context),
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

  Widget _buildSwitchRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    Color? activeColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: activeColor ?? AppTheme.primaryBlue, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppTheme.textLightGray,
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor ?? AppTheme.primaryBlue,
        ),
      ],
    );
  }

  Widget _buildNavRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryBlue, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textLightGray,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Platform.isIOS ? CupertinoIcons.chevron_right : Icons.chevron_right,
            color: AppTheme.textLightGray,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    String category,
    List<String> lockedCategories,
  ) {
    final isLocked = lockedCategories.contains(category);

    return FilterChip(
      label: Text(
        category,
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isLocked ? Colors.white : AppTheme.textLightGray,
        ),
      ),
      selected: isLocked,
      onSelected: (selected) {
        context.read<SecurityBloc>().add(ToggleCategoryLock(category));
      },
      selectedColor: AppTheme.errorRed,
      checkmarkColor: Colors.white,
      backgroundColor: AppTheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
        side: BorderSide(
          color: isLocked ? AppTheme.errorRed : const Color(0xFFE8EEFF),
          width: 1,
        ),
      ),
    );
  }
}
