import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class RoundUpScreen extends StatefulWidget {
   const RoundUpScreen({Key? key}) : super(key: key);

   @override
   State<RoundUpScreen> createState() => _RoundUpScreenState();
}

class _RoundUpScreenState extends State<RoundUpScreen> {
   bool _isActive = true;
   int _selectedRounding = 5000; // nearest Rp 5.000
   int _multiplier = 1; // 1x, 2x, 5x

   // Rounds up everyday transactions logic simulator
   int _calculateRoundUp(int purchase) {
     int rem = purchase % _selectedRounding;
     if (rem == 0) return 0;
     return (_selectedRounding - rem) * _multiplier;
   }

   @override
   Widget build(BuildContext context) {
     final int samplePurchase = 12500;
     final int calculatedRoundUp = _calculateRoundUp(samplePurchase);
     final int finalTotal = samplePurchase + calculatedRoundUp;

     String purchaseStr = 'Rp ${samplePurchase.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
     String roundUpStr = 'Rp ${calculatedRoundUp.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
     String totalStr = 'Rp ${finalTotal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

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
           'Autosave Round-up',
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
         padding: const EdgeInsets.symmetric(horizontal: 24),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const SizedBox(height: 12),

             // Main activation toggle card
             Container(
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(24),
                 boxShadow: AppTheme.premiumShadow,
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
                           'Tabungan Otomatis',
                           style: GoogleFonts.inter(
                             color: AppTheme.textDark,
                             fontSize: 15,
                             fontWeight: FontWeight.w800,
                           ),
                         ),
                         const SizedBox(height: 4),
                         Text(
                           'Aktifkan pembulatan nominal transaksi belanja sehari-hari untuk ditabung.',
                           style: GoogleFonts.inter(
                             color: AppTheme.textLightGray,
                             fontSize: 11,
                             height: 1.3,
                           ),
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(width: 16),
                   Switch.adaptive(
                     value: _isActive,
                     activeColor: AppTheme.shariaGreen,
                     onChanged: (val) {
                       setState(() {
                         _isActive = val;
                       });
                     },
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 28),

             if (_isActive) ...[
               // Round-up threshold selector
               Text(
                 'Aturan Pembulatan Terdekat',
                 style: GoogleFonts.inter(
                   color: AppTheme.textDark,
                   fontSize: 15,
                   fontWeight: FontWeight.w800,
                 ),
               ),
               const SizedBox(height: 16),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   _buildRoundingChip(2000, 'Rp 2.000'),
                   _buildRoundingChip(5000, 'Rp 5.000'),
                   _buildRoundingChip(10000, 'Rp 10.000'),
                 ],
               ),
               const SizedBox(height: 28),

               // Multiplier boost options
               Text(
                 'Pengali Tabungan (Multiplier)',
                 style: GoogleFonts.inter(
                   color: AppTheme.textDark,
                   fontSize: 15,
                   fontWeight: FontWeight.w800,
                 ),
               ),
               const SizedBox(height: 16),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   _buildMultiplierChip(1, '1x', 'Standar'),
                   _buildMultiplierChip(2, '2x', 'Sedang'),
                   _buildMultiplierChip(5, '5x', 'Maksimal'),
                 ],
               ),
               const SizedBox(height: 28),

               // Interactive calculation demonstration receipt card
               Text(
                 'Cara Kerja Pembulatan',
                 style: GoogleFonts.inter(
                   color: AppTheme.textDark,
                   fontSize: 15,
                   fontWeight: FontWeight.w800,
                 ),
               ),
               const SizedBox(height: 16),
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
                     Row(
                       children: [
                         Container(
                           padding: const EdgeInsets.all(10),
                           decoration: const BoxDecoration(
                             color: Color(0xFFFFF9E6),
                             shape: BoxShape.circle,
                           ),
                           child: const Icon(
                             Icons.bolt,
                             color: Colors.amber,
                             size: 20,
                           ),
                         ),
                         const SizedBox(width: 16),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               'Simulasi Belanja Kopi',
                               style: GoogleFonts.inter(
                                 color: AppTheme.textDark,
                                 fontSize: 13,
                                 fontWeight: FontWeight.w800,
                               ),
                             ),
                             Text(
                               'Transaksi belanja kartu debit/QRIS',
                               style: GoogleFonts.inter(
                                 color: AppTheme.textLightGray,
                                 fontSize: 10,
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                     const Divider(height: 32, color: Color(0xFFF1F3FF)),
                     _buildReceiptRow('Pembayaran Asli', purchaseStr),
                     const SizedBox(height: 8),
                     _buildReceiptRow(
                       'Ditabung Otomatis (${_multiplier}x)',
                       roundUpStr,
                       highlight: true,
                     ),
                     const Divider(height: 32, color: Color(0xFFF1F3FF)),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(
                           'Total Terpotong Saldo',
                           style: GoogleFonts.inter(
                             color: AppTheme.textDark,
                             fontSize: 13,
                             fontWeight: FontWeight.w700,
                           ),
                         ),
                         Text(
                           totalStr,
                           style: GoogleFonts.inter(
                             color: AppTheme.primaryBlue,
                             fontSize: 16,
                             fontWeight: FontWeight.w900,
                           ),
                         ),
                       ],
                     ),
                   ],
                 ),
               ),
               const SizedBox(height: 40),
             ],
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
               onPressed: () {
                 if (_isActive) {
                   context.push('/wealth/roundup/instruments');
                 } else {
                   Navigator.of(context).pop();
                 }
               },
               style: ElevatedButton.styleFrom(
                 backgroundColor: AppTheme.primaryBlue,
                 foregroundColor: Colors.white,
                 elevation: 0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(100),
                 ),
               ),
               child: Text(
                 _isActive ? 'Pilih Instrumen Investasi' : 'Simpan Pengaturan',
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

   Widget _buildRoundingChip(int rounding, String label) {
     final active = _selectedRounding == rounding;
     return GestureDetector(
       onTap: () {
         setState(() {
           _selectedRounding = rounding;
         });
       },
       child: Container(
         width: 96,
         padding: const EdgeInsets.symmetric(vertical: 12),
         decoration: BoxDecoration(
           color: active ? AppTheme.primaryBlue : Colors.white,
           borderRadius: BorderRadius.circular(16),
           border: Border.all(
             color: active ? AppTheme.primaryBlue : const Color(0xFFE8EEFF),
           ),
           boxShadow: active ? AppTheme.premiumShadow : null,
         ),
         child: Center(
           child: Text(
             label,
             style: GoogleFonts.inter(
               color: active ? Colors.white : AppTheme.textDark,
               fontSize: 12,
               fontWeight: FontWeight.w800,
             ),
           ),
         ),
       ),
     );
   }

   Widget _buildMultiplierChip(int multiplier, String title, String sub) {
     final active = _multiplier == multiplier;
     return GestureDetector(
       onTap: () {
         setState(() {
           _multiplier = multiplier;
         });
       },
       child: Container(
         width: 96,
         padding: const EdgeInsets.all(12),
         decoration: BoxDecoration(
           color: active ? AppTheme.primaryBlue : Colors.white,
           borderRadius: BorderRadius.circular(16),
           border: Border.all(
             color: active ? AppTheme.primaryBlue : const Color(0xFFE8EEFF),
           ),
           boxShadow: active ? AppTheme.premiumShadow : null,
         ),
         child: Column(
           children: [
             Text(
               title,
               style: GoogleFonts.inter(
                 color: active ? Colors.white : AppTheme.textDark,
                 fontSize: 16,
                 fontWeight: FontWeight.w900,
               ),
             ),
             const SizedBox(height: 2),
             Text(
               sub,
               style: GoogleFonts.inter(
                 color: active ? Colors.white70 : AppTheme.textLightGray,
                 fontSize: 8,
                 fontWeight: FontWeight.w500,
               ),
             ),
           ],
         ),
       ),
     );
   }

   Widget _buildReceiptRow(String label, String value, {bool highlight = false}) {
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
             color: highlight ? AppTheme.shariaGreen : AppTheme.textDark,
             fontSize: 12,
             fontWeight: highlight ? FontWeight.w800 : FontWeight.w700,
           ),
         ),
       ],
     );
   }
}
