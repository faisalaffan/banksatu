import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class PortfolioScreen extends StatefulWidget {
   const PortfolioScreen({Key? key}) : super(key: key);

   @override
   State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> with SingleTickerProviderStateMixin {
   late AnimationController _animationController;
   late Animation<double> _animation;

   // Month-over-Month asset accumulation data
   final List<double> _momData = [20.0, 24.5, 28.0, 32.5, 36.8, 42.85];
   final List<String> _months = ['Des', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei'];

   @override
   void initState() {
     super.initState();
     _animationController = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 900),
     );
     _animation = CurvedAnimation(
       parent: _animationController,
       curve: Curves.easeOutBack,
     );
     _animationController.forward();
   }

   @override
   void dispose() {
     _animationController.dispose();
     super.dispose();
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
           'Unified Portfolio',
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

             // Net Worth Header Display Card
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
                     'Kekayaan Bersih Anda (Net Worth)',
                     style: GoogleFonts.inter(
                       color: AppTheme.textLightGray,
                       fontSize: 11,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   const SizedBox(height: 6),
                   Text(
                     'Rp 68.650.000',
                     style: GoogleFonts.inter(
                       color: AppTheme.textDark,
                       fontSize: 26,
                       fontWeight: FontWeight.w900,
                       letterSpacing: -0.5,
                     ),
                   ),
                   const SizedBox(height: 20),
                   const Divider(color: Color(0xFFF1F3FF), height: 1),
                   const SizedBox(height: 20),
                   Row(
                     children: [
                       // Total Assets
                       Expanded(
                         child: Row(
                           children: [
                             Container(
                               padding: const EdgeInsets.all(8),
                               decoration: BoxDecoration(
                                 color: AppTheme.shariaGreen.withOpacity(0.08),
                                 shape: BoxShape.circle,
                               ),
                               child: const Icon(
                                 Icons.arrow_upward,
                                 color: AppTheme.shariaGreen,
                                 size: 14,
                               ),
                             ),
                             const SizedBox(width: 10),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   'Total Aset',
                                   style: GoogleFonts.inter(
                                     color: AppTheme.textLightGray,
                                     fontSize: 9,
                                     fontWeight: FontWeight.w500,
                                   ),
                                 ),
                                 const SizedBox(height: 2),
                                 Text(
                                   'Rp 73.650.000',
                                   style: GoogleFonts.inter(
                                     color: AppTheme.textDark,
                                     fontSize: 12,
                                     fontWeight: FontWeight.w700,
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                       // Total Liabilities
                       Expanded(
                         child: Row(
                           children: [
                             Container(
                               padding: const EdgeInsets.all(8),
                               decoration: BoxDecoration(
                                 color: Colors.red.withOpacity(0.08),
                                 shape: BoxShape.circle,
                               ),
                               child: const Icon(
                                 Icons.arrow_downward,
                                 color: Colors.red,
                                 size: 14,
                               ),
                             ),
                             const SizedBox(width: 10),
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(
                                   'Total Kewajiban',
                                   style: GoogleFonts.inter(
                                     color: AppTheme.textLightGray,
                                     fontSize: 9,
                                     fontWeight: FontWeight.w500,
                                   ),
                                 ),
                                 const SizedBox(height: 2),
                                 Text(
                                   'Rp 5.000.000',
                                   style: GoogleFonts.inter(
                                     color: AppTheme.textDark,
                                     fontSize: 12,
                                     fontWeight: FontWeight.w700,
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 28),

             // MoM Accumulation Bar Chart
             Text(
               'Akumulasi Kekayaan (MoM)',
               style: GoogleFonts.inter(
                 color: AppTheme.textDark,
                 fontSize: 15,
                 fontWeight: FontWeight.w800,
               ),
             ),
             const SizedBox(height: 16),
             Container(
               height: 180,
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: AppTheme.premiumShadow,
                 border: Border.all(color: const Color(0xFFE8EEFF)),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: List.generate(_momData.length, (index) {
                   final val = _momData[index];
                   final month = _months[index];
                   return AnimatedBuilder(
                     animation: _animation,
                     builder: (context, child) {
                       final animatedHeight = (val / 50.0) * 110.0 * _animation.value;
                       return Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Text(
                             '${val.toStringAsFixed(0)}M',
                             style: GoogleFonts.inter(
                               color: AppTheme.primaryBlue,
                               fontSize: 9,
                               fontWeight: FontWeight.w700,
                             ),
                           ),
                           const SizedBox(height: 6),
                           Container(
                             width: 24,
                             height: animatedHeight.clamp(4.0, 110.0),
                             decoration: BoxDecoration(
                               gradient: LinearGradient(
                                 colors: [
                                   AppTheme.primaryBlue,
                                   AppTheme.primaryBlue.withOpacity(0.6),
                                 ],
                                 begin: Alignment.topCenter,
                                 end: Alignment.bottomCenter,
                               ),
                               borderRadius: BorderRadius.circular(6),
                             ),
                           ),
                           const SizedBox(height: 8),
                           Text(
                             month,
                             style: GoogleFonts.inter(
                               color: AppTheme.textLightGray,
                               fontSize: 10,
                               fontWeight: FontWeight.w600,
                             ),
                           ),
                         ],
                       );
                     },
                   );
                 }),
               ),
             ),
             const SizedBox(height: 28),

             // Unified Account Aggregator
             Text(
               'Daftar Aset & Rekening',
               style: GoogleFonts.inter(
                 color: AppTheme.textDark,
                 fontSize: 15,
                 fontWeight: FontWeight.w800,
               ),
             ),
             const SizedBox(height: 16),

             // Cash pocket listings
             _buildAssetRow(
               'Tabungan Utama',
               'Cash Account • BankSatu',
               'Rp 25.800.000',
               Icons.account_balance_wallet,
               AppTheme.primaryBlue,
             ),
             _buildAssetRow(
               'Portofolio Reksa Dana',
               'Investasi • Reksadana',
               'Rp 32.500.000',
               Icons.pie_chart,
               AppTheme.shariaGreen,
             ),
             _buildAssetRow(
               'Tabungan Logam Mulia',
               'Investasi • Emas Antam',
               'Rp 10.350.000',
               Icons.brightness_5,
               Colors.amber,
             ),
             _buildAssetRow(
               'Shared Vault Pocket',
               'Joint Target Pocket',
               'Rp 5.000.000',
               Icons.folder_shared,
               Colors.deepPurple,
             ),
             _buildAssetRow(
               'Kartu Kredit Platinum',
               'Kewajiban • Tagihan',
               '- Rp 5.000.000',
               Icons.credit_card,
               Colors.red,
             ),
             const SizedBox(height: 40),
           ],
         ),
       ),
     );
   }

   Widget _buildAssetRow(
     String title,
     String type,
     String balance,
     IconData icon,
     Color color,
   ) {
     final isNegative = balance.startsWith('-');
     return Container(
       margin: const EdgeInsets.only(bottom: 12),
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(16),
         border: Border.all(color: const Color(0xFFE8EEFF)),
         boxShadow: AppTheme.premiumShadow,
       ),
       child: Row(
         children: [
           Container(
             padding: const EdgeInsets.all(10),
             decoration: BoxDecoration(
               color: color.withOpacity(0.08),
               borderRadius: BorderRadius.circular(12),
             ),
             child: Icon(
               icon,
               color: color,
               size: 20,
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
                   type,
                   style: GoogleFonts.inter(
                     color: AppTheme.textLightGray,
                     fontSize: 10,
                     fontWeight: FontWeight.w500,
                   ),
                 ),
               ],
             ),
           ),
           Text(
             balance,
             style: GoogleFonts.inter(
               color: isNegative ? Colors.red : AppTheme.textDark,
               fontSize: 13,
               fontWeight: FontWeight.w800,
             ),
           ),
         ],
       ),
     );
   }
}
