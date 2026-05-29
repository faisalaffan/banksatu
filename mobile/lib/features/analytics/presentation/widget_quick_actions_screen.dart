import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/theme/app_theme.dart';

class WidgetQuickActionsScreen extends StatefulWidget {
   const WidgetQuickActionsScreen({Key? key}) : super(key: key);

   @override
   State<WidgetQuickActionsScreen> createState() => _WidgetQuickActionsScreenState();
}

class _WidgetQuickActionsScreenState extends State<WidgetQuickActionsScreen> {
   int _selectedSize = 0; // 0: Small, 1: Medium, 2: Large

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
           'Widget & Quick Actions',
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
             // Header title
             Text(
               'Widget Layar Utama',
               style: GoogleFonts.inter(
                 color: AppTheme.textDark,
                 fontSize: 20,
                 fontWeight: FontWeight.w800,
                 letterSpacing: -0.3,
               ),
             ),
             const SizedBox(height: 6),
             Text(
               'Pantau portofolio, patungan Shared Vault, atau scan QRIS langsung dari Widget iOS / Android Anda.',
               style: GoogleFonts.inter(
                 color: AppTheme.textLightGray,
                 fontSize: 14,
                 height: 1.4,
               ),
             ),
             const SizedBox(height: 28),

             // Widget size tabs selectors
             Container(
               padding: const EdgeInsets.all(4),
               decoration: BoxDecoration(
                 color: const Color(0xFFF1F3FF),
                 borderRadius: BorderRadius.circular(16),
               ),
               child: Row(
                 children: [
                   _buildSizeTab(0, 'Kecil (Small)'),
                   _buildSizeTab(1, 'Sedang (Medium)'),
                   _buildSizeTab(2, 'Besar (Large)'),
                 ],
               ),
             ),
             const SizedBox(height: 32),

             // Simulated home wallpaper background containing the widget card
             Container(
               width: double.infinity,
               padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
               decoration: BoxDecoration(
                 gradient: const LinearGradient(
                   colors: [
                     Color(0xFF8E9EAB),
                     Color(0xFFEEF2F3),
                   ],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                 ),
                 borderRadius: BorderRadius.circular(32),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black.withOpacity(0.12),
                     blurRadius: 24,
                     offset: const Offset(0, 12),
                   ),
                 ],
               ),
               child: Center(
                 child: _buildSimulatedWidget(),
               ),
             ),
             const SizedBox(height: 28),

             // Widget customization guides tips card
             Container(
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 border: Border.all(color: const Color(0xFFE8EEFF)),
                 boxShadow: AppTheme.premiumShadow,
               ),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const Icon(
                     Icons.info_outline,
                     color: AppTheme.primaryBlue,
                     size: 22,
                   ),
                   const SizedBox(width: 16),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Cara Menambahkan di iOS',
                           style: GoogleFonts.inter(
                             color: AppTheme.textDark,
                             fontSize: 13,
                             fontWeight: FontWeight.w800,
                           ),
                         ),
                         const SizedBox(height: 6),
                         Text(
                           '1. Sentuh & tahan area kosong di Layar Utama.\n2. Tap ikon "+" di pojok kiri atas.\n3. Cari "BankSatu" dan pilih ukuran widget yang Anda inginkan.',
                           style: GoogleFonts.inter(
                             color: AppTheme.textLightGray,
                             fontSize: 11,
                             height: 1.4,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 40),
           ],
         ),
       ),
     );
   }

   Widget _buildSizeTab(int index, String label) {
     final active = _selectedSize == index;
     return Expanded(
       child: GestureDetector(
         onTap: () => setState(() => _selectedSize = index),
         child: Container(
           padding: const EdgeInsets.symmetric(vertical: 10),
           decoration: BoxDecoration(
             color: active ? Colors.white : Colors.transparent,
             borderRadius: BorderRadius.circular(12),
             boxShadow: active ? AppTheme.premiumShadow : null,
           ),
           child: Center(
             child: Text(
               label,
               style: GoogleFonts.inter(
                 color: active ? AppTheme.primaryBlue : AppTheme.textLightGray,
                 fontSize: 11,
                 fontWeight: FontWeight.w800,
               ),
             ),
           ),
         ),
       ),
     );
   }

   // Returns simulated widget card stack based on size
   Widget _buildSimulatedWidget() {
     if (_selectedSize == 0) {
       // Small iOS Widget Box (150x150 square)
       return Container(
         width: 150,
         height: 150,
         padding: const EdgeInsets.all(16),
         decoration: BoxDecoration(
           color: Colors.white.withOpacity(0.92),
           borderRadius: BorderRadius.circular(24),
           border: Border.all(color: Colors.white.withOpacity(0.6)),
           boxShadow: [
             BoxShadow(
               color: Colors.black.withOpacity(0.08),
               blurRadius: 16,
               offset: const Offset(0, 8),
             ),
           ],
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 const Icon(Icons.account_balance_wallet, color: AppTheme.primaryBlue, size: 20),
                 Container(
                   width: 8,
                   height: 8,
                   decoration: const BoxDecoration(color: AppTheme.shariaGreen, shape: BoxShape.circle),
                 ),
               ],
             ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text(
                   'Saldo Utama',
                   style: GoogleFonts.inter(color: AppTheme.textLightGray, fontSize: 9, fontWeight: FontWeight.w600),
                 ),
                 const SizedBox(height: 2),
                 Text(
                   'Rp 25.8M',
                   style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 18, fontWeight: FontWeight.w900),
                 ),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Yield Emas', style: GoogleFonts.inter(color: AppTheme.textLightGray, fontSize: 8, fontWeight: FontWeight.w500)),
                 Text('+11.5%', style: GoogleFonts.inter(color: AppTheme.shariaGreen, fontSize: 10, fontWeight: FontWeight.w800)),
               ],
             ),
           ],
         ),
       );
     } else if (_selectedSize == 1) {
       // Medium iOS Widget Box (320x150 horizontal)
       return Container(
         width: 320,
         height: 150,
         padding: const EdgeInsets.all(20),
         decoration: BoxDecoration(
           color: Colors.white.withOpacity(0.92),
           borderRadius: BorderRadius.circular(24),
           border: Border.all(color: Colors.white.withOpacity(0.6)),
           boxShadow: [
             BoxShadow(
               color: Colors.black.withOpacity(0.08),
               blurRadius: 16,
               offset: const Offset(0, 8),
             ),
           ],
         ),
         child: Row(
           children: [
             Expanded(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         'Total Portofolio',
                         style: GoogleFonts.inter(color: AppTheme.textLightGray, fontSize: 10, fontWeight: FontWeight.w600),
                       ),
                       const SizedBox(height: 2),
                       Text(
                         'Rp 42.850.000',
                         style: GoogleFonts.inter(color: AppTheme.primaryBlue, fontSize: 20, fontWeight: FontWeight.w900),
                       ),
                     ],
                   ),
                   Row(
                     children: [
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                         decoration: BoxDecoration(color: AppTheme.shariaGreen.withOpacity(0.08), borderRadius: BorderRadius.circular(4)),
                         child: Text('+12.4%', style: GoogleFonts.inter(color: AppTheme.shariaGreen, fontSize: 9, fontWeight: FontWeight.w800)),
                       ),
                       const SizedBox(width: 8),
                       Text('Bulan ini', style: GoogleFonts.inter(color: AppTheme.textLightGray, fontSize: 9)),
                     ],
                   ),
                 ],
               ),
             ),
             const VerticalDivider(width: 24, color: Colors.white30),
             // Quick actions targets shortcuts
             Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 _buildActionWidgetBtn('Scan QRIS', Icons.qr_code_scanner, '/transactions/qris-scan'),
                 _buildActionWidgetBtn('Transfer', Icons.send_outlined, '/transactions/transfer'),
                 _buildActionWidgetBtn('Asisten AI', Icons.auto_awesome, '/analytics/chat'),
               ],
             ),
           ],
         ),
       );
     } else {
       // Large iOS Widget Box (320x320 large square)
       return Container(
         width: 300,
         height: 300,
         padding: const EdgeInsets.all(24),
         decoration: BoxDecoration(
           color: Colors.white.withOpacity(0.92),
           borderRadius: BorderRadius.circular(28),
           border: Border.all(color: Colors.white.withOpacity(0.6)),
           boxShadow: [
             BoxShadow(
               color: Colors.black.withOpacity(0.08),
               blurRadius: 16,
               offset: const Offset(0, 8),
             ),
           ],
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Shared Vault Target', style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 13, fontWeight: FontWeight.w800)),
                 Text('35%', style: GoogleFonts.inter(color: AppTheme.primaryBlue, fontSize: 13, fontWeight: FontWeight.w900)),
               ],
             ),
             
             // Progress bar
             ClipRRect(
               borderRadius: BorderRadius.circular(6),
               child: const SizedBox(
                 height: 8,
                 width: double.infinity,
                 child: LinearProgressIndicator(
                   value: 0.35,
                   backgroundColor: Color(0xFFF1F3FF),
                   color: AppTheme.primaryBlue,
                 ),
               ),
             ),

             const Divider(height: 16, color: Colors.white30),

             // Spending insights log list
             Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Text('Analisis Aset AI', style: GoogleFonts.inter(color: AppTheme.textLightGray, fontSize: 9, fontWeight: FontWeight.w600)),
                 const SizedBox(height: 6),
                 _buildInsightMiniRow('Hemat Makan & Minum Rp 250.000', AppTheme.shariaGreen),
                 _buildInsightMiniRow('Autosave micro-savings Rp 120.000', AppTheme.primaryBlue),
               ],
             ),

             const Divider(height: 16, color: Colors.white30),

             // Widget actions list
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 _buildActionIconBtn('QRIS', Icons.qr_code_scanner, '/transactions/qris-scan'),
                 _buildActionIconBtn('Kirim', Icons.send_outlined, '/transactions/transfer'),
                 _buildActionIconBtn('Invest', Icons.eco_outlined, '/wealth/invest'),
               ],
             ),
           ],
         ),
       );
     }
   }

   Widget _buildInsightMiniRow(String text, Color color) {
     return Padding(
       padding: const EdgeInsets.symmetric(vertical: 4),
       child: Row(
         children: [
           Container(width: 6, height: 6, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
           const SizedBox(width: 8),
           Expanded(
             child: Text(
               text,
               maxLines: 1,
               overflow: TextOverflow.ellipsis,
               style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 10, fontWeight: FontWeight.w700),
             ),
           ),
         ],
       ),
     );
   }

   Widget _buildActionWidgetBtn(String title, IconData icon, String route) {
     return GestureDetector(
       onTap: () => context.push(route),
       child: Padding(
         padding: const EdgeInsets.symmetric(vertical: 4),
         child: Row(
           children: [
             Icon(icon, color: AppTheme.primaryBlue, size: 16),
             const SizedBox(width: 8),
             Text(title, style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 11, fontWeight: FontWeight.w700)),
           ],
         ),
       ),
     );
   }

   Widget _buildActionIconBtn(String label, IconData icon, String route) {
     return GestureDetector(
       onTap: () => context.push(route),
       child: Column(
         children: [
           Container(
             width: 44,
             height: 44,
             decoration: BoxDecoration(color: AppTheme.primaryBlue, borderRadius: BorderRadius.circular(12)),
             child: Icon(icon, color: Colors.white, size: 18),
           ),
           const SizedBox(height: 4),
           Text(label, style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 9, fontWeight: FontWeight.w700)),
         ],
       ),
     );
   }
}
