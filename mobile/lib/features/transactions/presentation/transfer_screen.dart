import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';
import 'package:banksatu_mobile/core/router/app_router.dart';
import 'package:go_router/go_router.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  int _activeTab = 0; // 0 for Transfer, 1 for Bayar
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _accountController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _addNominal(int value) {
    final currentText = _amountController.text;
    final int currentVal = int.tryParse(currentText) ?? 0;
    setState(() {
      _amountController.text = (currentVal + value).toString();
    });
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
          onPressed: () => GoRouter.of(context).go('/'),
        ),
        title: Text(
          'Transfer & Pembayaran',
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            // Subtitle
            Text(
              'Kirim uang atau bayar tagihan dengan mudah dan aman.',
              style: GoogleFonts.inter(
                color: AppTheme.textLightGray,
                fontSize: 14,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // Tab Toggle (Transfer / Bayar)
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _activeTab = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _activeTab == 0 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: _activeTab == 0 ? AppTheme.premiumShadow : null,
                        ),
                        child: Center(
                          child: Text(
                            'Transfer',
                            style: GoogleFonts.inter(
                              color: _activeTab == 0 ? AppTheme.primaryBlue : AppTheme.textLightGray,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Redirect view or state
                        setState(() => _activeTab = 1);
                        // Proactively navigate to PayBillsScreen after animation
                        Future.delayed(const Duration(milliseconds: 150), () {
                          if (mounted && _activeTab == 1) {
                            const PayBillsRoute().push(context);
                            setState(() => _activeTab = 0); // reset tab back
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _activeTab == 1 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: _activeTab == 1 ? AppTheme.premiumShadow : null,
                        ),
                        child: Center(
                          child: Text(
                            'Bayar',
                            style: GoogleFonts.inter(
                              color: _activeTab == 1 ? AppTheme.primaryBlue : AppTheme.textLightGray,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Actions Options
            Row(
              children: [
                _buildQuickAction(
                  icon: Platform.isIOS ? CupertinoIcons.house_fill : Icons.account_balance,
                  title: 'BI-FAST',
                  subtitle: 'Antar Bank',
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  icon: Platform.isIOS ? CupertinoIcons.refresh_bold : Icons.sync_alt,
                  title: 'Ke Rekening',
                  subtitle: 'BankSatu',
                  onTap: () {},
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  icon: Platform.isIOS ? CupertinoIcons.phone_fill : Icons.contact_phone,
                  title: 'Nomor HP',
                  subtitle: 'Pay via HP',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildQuickAction(
                  icon: Platform.isIOS ? CupertinoIcons.group_solid : Icons.group,
                  title: 'Bulk Transfer',
                  subtitle: 'Multi Target',
                  onTap: () => const BulkTransferRoute().push(context),
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  icon: Platform.isIOS ? CupertinoIcons.link : Icons.link,
                  title: 'Payment Link',
                  subtitle: 'Tagihan Link',
                  onTap: () => const PaymentLinkRoute().push(context),
                ),
                const SizedBox(width: 12),
                _buildQuickAction(
                  icon: Platform.isIOS ? CupertinoIcons.money_dollar_circle_fill : Icons.monetization_on,
                  title: 'Minta Uang',
                  subtitle: 'Request Bill',
                  onTap: () => const RequestMoneyRoute().push(context),
                ),
              ],
            ),
            const SizedBox(height: 24),
 
            // Transfer Detail Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: AppTheme.premiumShadow,
                border: Border.all(color: const Color(0xFFE8EEFF)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Transfer',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Rekening Tujuan
                  Text(
                    'Rekening Tujuan',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _accountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Masukkan nomor rekening',
                      prefixIcon: Icon(
                        Platform.isIOS ? CupertinoIcons.person_solid : Icons.account_circle,
                        color: AppTheme.textLightGray,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nominal Transfer
                  Text(
                    'Nominal Transfer',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primaryBlue,
                    ),
                    decoration: const InputDecoration(
                      hintText: '0',
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(left: 16, top: 12, right: 8),
                        child: Text(
                          'Rp',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textLightGray,
                          ),
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Quick Nominal Selector
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        _buildQuickAmount(50000, '+50k'),
                        const SizedBox(width: 8),
                        _buildQuickAmount(100000, '+100k'),
                        const SizedBox(width: 8),
                        _buildQuickAmount(500000, '+500k'),
                        const SizedBox(width: 8),
                        _buildQuickAmount(1000000, '+1.0M'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Catatan (Opsional)
                  Text(
                    'Catatan (Opsional)',
                    style: GoogleFonts.inter(
                      color: AppTheme.textDark,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      hintText: 'Misal: Bayar patungan makan',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate directly to split bill or simulate transaction success
                        const BillSplitRoute().push(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lanjut Verifikasi',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Platform.isIOS ? CupertinoIcons.arrow_right : Icons.arrow_forward,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Favorites Horizontal Grid
            Text(
              'Favorit',
              style: GoogleFonts.inter(
                color: AppTheme.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildAddFavoriteButton(),
                  const SizedBox(width: 16),
                  _buildFavoriteContact(context, 'Budi S.', 'BS', const Color(0xFFF1F3FF)),
                  const SizedBox(width: 16),
                  _buildFavoriteContact(context, 'Ani M.', 'AM', const Color(0xFFE8EEFF)),
                  const SizedBox(width: 16),
                  _buildFavoriteContact(context, 'Dedi T.', 'DT', const Color(0xFFFFDAD6)),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Recent Transactions List
            Text(
              'Transfer Terakhir',
              style: GoogleFonts.inter(
                color: AppTheme.textDark,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecentRow(
              Platform.isIOS ? CupertinoIcons.house_fill : Icons.account_balance,
              'BCA - Budi Santoso',
              '014 • 8923749823',
            ),
            const Divider(height: 1, color: Color(0xFFF1F3FF)),
            _buildRecentRow(
              Platform.isIOS ? CupertinoIcons.refresh_bold : Icons.sync_alt,
              'BankSatu - Rina Wati',
              '1029384756',
            ),
            const Divider(height: 1, color: Color(0xFFF1F3FF)),
            _buildRecentRow(
              Platform.isIOS ? CupertinoIcons.house_fill : Icons.account_balance,
              'Mandiri - Toko Makmur',
              '008 • 1122334455',
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAction({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.12)),
            boxShadow: AppTheme.premiumShadow,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withOpacity(0.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: AppTheme.primaryBlue,
                  size: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: AppTheme.textDark,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  color: AppTheme.textLightGray,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAmount(int value, String label) {
    return ActionChip(
      label: Text(label),
      labelStyle: GoogleFonts.inter(
        color: AppTheme.textDark,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: const Color(0xFFF1F3FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      side: const BorderSide(color: Color(0xFFE8EEFF)),
      onPressed: () => _addNominal(value),
    );
  }

  Widget _buildAddFavoriteButton() {
    return Column(
      children: [
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.textLightGray.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              color: AppTheme.textLightGray,
              size: 20,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tambah',
          style: GoogleFonts.inter(
            color: AppTheme.textLightGray,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildFavoriteContact(BuildContext context, String name, String initials, Color bgColor) {
    return GestureDetector(
      onTap: () => const ContactHistoryRoute().push(context),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              boxShadow: AppTheme.premiumShadow,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Center(
              child: Text(
                initials,
                style: GoogleFonts.inter(
                  color: AppTheme.primaryBlue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: GoogleFonts.inter(
              color: AppTheme.textDark,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3FF),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppTheme.primaryBlue,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
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
                  subtitle,
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
    );
  }
}
