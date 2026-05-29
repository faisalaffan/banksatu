import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/theme/app_theme.dart';

class TimeDepositScreen extends StatefulWidget {
   const TimeDepositScreen({Key? key}) : super(key: key);

   @override
   State<TimeDepositScreen> createState() => _TimeDepositScreenState();
}

class _TimeDepositScreenState extends State<TimeDepositScreen> {
   final TextEditingController _goalNameController = TextEditingController();
   final TextEditingController _amountController = TextEditingController();
   
   double _durationMonths = 12.0; // Slider value: 3, 6, 12, 24
   bool _isLockedAgreement = false;

   // BankSatu annual interest rate (e.g. 5.5% per annum)
   final double _annualInterestRate = 0.055;

   @override
   void dispose() {
     _goalNameController.dispose();
     _amountController.dispose();
     super.dispose();
   }

   // Dynamic interest calculator logic
   double _calculateEstimatedInterest() {
     final double principal = double.tryParse(_amountController.text.replaceAll('.', '')) ?? 0.0;
     final double timeYears = _durationMonths / 12.0;
     return principal * _annualInterestRate * timeYears;
   }

   double _calculateTotalPayout() {
     final double principal = double.tryParse(_amountController.text.replaceAll('.', '')) ?? 0.0;
     return principal + _calculateEstimatedInterest();
   }

   void _handleCreateDeposit() {
     if (_goalNameController.text.isEmpty || _amountController.text.isEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Harap lengkapi semua bidang formulir.')),
       );
       return;
     }

     if (!_isLockedAgreement) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Anda harus menyetujui syarat penguncian saldo.')),
       );
       return;
     }

     // Success prompt
     showDialog(
       context: context,
       builder: (context) => Platform.isIOS
           ? CupertinoAlertDialog(
               title: const Text('Tabungan Aktif!'),
               content: Text(
                   'Target "${_goalNameController.text}" berhasil dikunci selama ${_durationMonths.toInt()} bulan. Saldo akan otomatis dipindahkan dari rekening utama.'),
               actions: [
                 CupertinoDialogAction(
                   child: const Text('Mantap'),
                   onPressed: () {
                     Navigator.of(context).pop();
                     context.go('/wealth/portfolio');
                   },
                 ),
               ],
             )
           : AlertDialog(
               title: const Text('Tabungan Aktif!'),
               content: Text(
                   'Target "${_goalNameController.text}" berhasil dikunci selama ${_durationMonths.toInt()} bulan. Saldo akan otomatis dipindahkan dari rekening utama.'),
               actions: [
                 TextButton(
                   child: const Text('Mantap'),
                   onPressed: () {
                     Navigator.of(context).pop();
                     context.go('/wealth/portfolio');
                   },
                 ),
               ],
             ),
     );
   }

   @override
   Widget build(BuildContext context) {
     final estInterest = _calculateEstimatedInterest();
     final totalPayout = _calculateTotalPayout();
     
     // Format nominal display
     String estInterestStr = 'Rp ${estInterest.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
     String totalPayoutStr = 'Rp ${totalPayout.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

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
           'Tabungan Berjangka',
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
             // Header Title
             Text(
               'Wujudkan Impian Anda',
               style: GoogleFonts.inter(
                 color: AppTheme.textDark,
                 fontSize: 20,
                 fontWeight: FontWeight.w800,
                 letterSpacing: -0.3,
               ),
             ),
             const SizedBox(height: 6),
             Text(
               'Kunci dana Anda secara disiplin dengan bunga kompetitif 5.5% per tahun.',
               style: GoogleFonts.inter(
                 color: AppTheme.textLightGray,
                 fontSize: 14,
                 height: 1.4,
               ),
             ),
             const SizedBox(height: 28),

             // Main Interactive configuration card
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
                   // Goal Name Input
                   Text(
                     'Nama Target Impian',
                     style: GoogleFonts.inter(
                       color: AppTheme.textDark,
                       fontSize: 13,
                       fontWeight: FontWeight.w800,
                     ),
                   ),
                   const SizedBox(height: 8),
                   TextField(
                     controller: _goalNameController,
                     decoration: const InputDecoration(
                       hintText: 'Misal: Liburan ke Tokyo, Beli MacBook',
                     ),
                     onChanged: (_) => setState(() {}),
                   ),
                   const SizedBox(height: 20),

                   // Deposit Amount Input
                   Text(
                     'Nominal Setoran Awal',
                     style: GoogleFonts.inter(
                       color: AppTheme.textDark,
                       fontSize: 13,
                       fontWeight: FontWeight.w800,
                     ),
                   ),
                   const SizedBox(height: 8),
                   TextField(
                     controller: _amountController,
                     keyboardType: TextInputType.number,
                     decoration: const InputDecoration(
                       hintText: 'Masukkan nominal setoran',
                       prefixText: 'Rp ',
                       prefixStyle: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.primaryBlue),
                     ),
                     onChanged: (val) {
                       setState(() {});
                     },
                   ),
                   const SizedBox(height: 24),

                   // Goal Lock Duration Slider
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Durasi Penguncian Saldo',
                         style: GoogleFonts.inter(
                           color: AppTheme.textDark,
                           fontSize: 13,
                           fontWeight: FontWeight.w800,
                         ),
                       ),
                       Text(
                         '${_durationMonths.toInt()} Bulan',
                         style: GoogleFonts.inter(
                           color: AppTheme.primaryBlue,
                           fontSize: 14,
                           fontWeight: FontWeight.w900,
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(height: 8),
                   Slider.adaptive(
                     value: _durationMonths,
                     min: 3.0,
                     max: 24.0,
                     divisions: 3, // dividers for 3, 6, 12, 24 months
                     activeColor: AppTheme.primaryBlue,
                     inactiveColor: const Color(0xFFF1F3FF),
                     onChanged: (val) {
                       setState(() {
                         // Snapping points for slider intervals
                         if (val < 4.5) {
                           _durationMonths = 3.0;
                         } else if (val < 9.0) {
                           _durationMonths = 6.0;
                         } else if (val < 18.0) {
                           _durationMonths = 12.0;
                         } else {
                           _durationMonths = 24.0;
                         }
                       });
                     },
                   ),
                   const SizedBox(height: 24),

                   // Yield Projections panel
                   Container(
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                       color: const Color(0xFFF9FAFF),
                       borderRadius: BorderRadius.circular(16),
                       border: Border.all(color: const Color(0xFFE8EEFF)),
                     ),
                     child: Column(
                       children: [
                         _buildProjectionRow('Bunga Tahunan (P.A.)', '5.5%'),
                         const SizedBox(height: 8),
                         _buildProjectionRow('Estimasi Bagi Hasil', estInterestStr, highlight: true),
                         const Divider(height: 24, color: Color(0xFFE8EEFF)),
                         _buildProjectionRow('Total Pengembalian', totalPayoutStr, bold: true),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 24),

             // Terms agreement switch row
             Container(
               padding: const EdgeInsets.all(16),
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
                         Text(
                           'Setujui Penguncian Saldo',
                           style: GoogleFonts.inter(
                             color: AppTheme.textDark,
                             fontSize: 13,
                             fontWeight: FontWeight.w800,
                           ),
                         ),
                         const SizedBox(height: 2),
                         Text(
                           'Saya bersedia saldo ini tidak ditarik sebelum jatuh tempo.',
                           style: GoogleFonts.inter(
                             color: AppTheme.textLightGray,
                             fontSize: 10,
                             height: 1.3,
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(width: 16),
                   Switch.adaptive(
                     value: _isLockedAgreement,
                     activeColor: AppTheme.shariaGreen,
                     onChanged: (val) {
                       setState(() {
                         _isLockedAgreement = val;
                       });
                     },
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
               onPressed: _handleCreateDeposit,
               style: ElevatedButton.styleFrom(
                 backgroundColor: AppTheme.primaryBlue,
                 foregroundColor: Colors.white,
                 elevation: 0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(100),
                 ),
               ),
               child: Text(
                 'Kunci Tabungan Impian',
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

   Widget _buildProjectionRow(String label, String value, {bool highlight = false, bool bold = false}) {
     return Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Text(
           label,
           style: GoogleFonts.inter(
             color: AppTheme.textLightGray,
             fontSize: 12,
             fontWeight: FontWeight.w600,
           ),
         ),
         Text(
           value,
           style: GoogleFonts.inter(
             color: highlight
                 ? AppTheme.shariaGreen
                 : (bold ? AppTheme.primaryBlue : AppTheme.textDark),
             fontSize: bold ? 15 : 12,
             fontWeight: bold || highlight ? FontWeight.w900 : FontWeight.w700,
           ),
         ),
       ],
     );
   }
}
