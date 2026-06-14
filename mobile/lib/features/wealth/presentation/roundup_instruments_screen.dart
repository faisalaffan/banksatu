import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class RoundUpInstrumentsScreen extends StatefulWidget {
   const RoundUpInstrumentsScreen({Key? key}) : super(key: key);

   @override
   State<RoundUpInstrumentsScreen> createState() => _RoundUpInstrumentsScreenState();
}

class _RoundUpInstrumentsScreenState extends State<RoundUpInstrumentsScreen> {
   int _selectedInstrument = 0; // 0: Satu Pasar Uang Sharia, 1: Satu Logam Mulia, 2: Syariah Equities
   double _allocationRatio = 100.0; // split slider percentage

   final List<Map<String, dynamic>> _instruments = [
     {
       'name': 'Satu Pasar Uang Sharia',
       'type': 'Reksa Dana • Risiko Sangat Rendah',
       'yield': '+6.82% YTD',
       'color': AppTheme.shariaGreen,
       'icon': Icons.eco_outlined,
       'recommended': true,
     },
     {
       'name': 'Satu Logam Mulia (Gold)',
       'type': 'Tabungan Emas • Risiko Rendah',
       'yield': '+11.50% YTD',
       'color': Colors.amber,
       'icon': Icons.brightness_high_outlined,
       'recommended': true,
     },
     {
       'name': 'Satu Saham Sharia Fund',
       'type': 'Reksa Dana • Risiko Tinggi',
       'yield': '+15.40% YTD',
       'color': AppTheme.primaryBlue,
       'icon': Icons.trending_up,
       'recommended': false,
     },
   ];

   void _handleSaveInstruments() {
     showDialog(
       context: context,
       builder: (context) => Platform.isIOS
           ? CupertinoAlertDialog(
               title: const Text('Konfigurasi Disimpan'),
               content: const Text(
                   'Setiap pembulatan transaksi belanja Anda akan otomatis diinvestasikan ke instrumen pilihan.'),
               actions: [
                 CupertinoDialogAction(
                   child: const Text('OK'),
                   onPressed: () {
                     Navigator.of(context).pop();
                     context.go('/wealth/portfolio');
                   },
                 ),
               ],
             )
           : AlertDialog(
               title: const Text('Konfigurasi Disimpan'),
               content: const Text(
                   'Setiap pembulatan transaksi belanja Anda akan otomatis diinvestasikan ke instrumen pilihan.'),
               actions: [
                 TextButton(
                   child: const Text('OK'),
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
           'Alokasi Autosave',
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
               'Tujuan Investasi Autosave',
               style: GoogleFonts.inter(
                 color: AppTheme.textDark,
                 fontSize: 20,
                 fontWeight: FontWeight.w800,
                 letterSpacing: -0.3,
               ),
             ),
             const SizedBox(height: 6),
             Text(
               'Pilih instrumen reksa dana atau tabungan emas syariah untuk mengalokasikan uang receh pembulatan Anda.',
               style: GoogleFonts.inter(
                 color: AppTheme.textLightGray,
                 fontSize: 14,
                 height: 1.4,
               ),
             ),
             const SizedBox(height: 28),

             // Risk Profile Recommendation Card Badge
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
                   const Icon(
                     Icons.verified,
                     color: AppTheme.shariaGreen,
                     size: 20,
                   ),
                   const SizedBox(width: 12),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Sesuai Profil Risiko Moderat Anda',
                           style: GoogleFonts.inter(
                             color: AppTheme.shariaGreen,
                             fontSize: 13,
                             fontWeight: FontWeight.w800,
                           ),
                         ),
                         const SizedBox(height: 4),
                         Text(
                           'Investasi pasar uang dan emas syariah sangat disarankan karena memiliki kestabilan yield yang sangat aman.',
                           style: GoogleFonts.inter(
                             color: AppTheme.textLightGray,
                             fontSize: 11,
                             height: 1.3,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 28),

             // Instruments Selector List Grid
             Text(
               'Instrumen Tersedia',
               style: GoogleFonts.inter(
                 color: AppTheme.textDark,
                 fontSize: 15,
                 fontWeight: FontWeight.w800,
               ),
             ),
             const SizedBox(height: 16),

             ListView.builder(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: _instruments.length,
               itemBuilder: (context, index) {
                 final inst = _instruments[index];
                 final active = _selectedInstrument == index;
                 return GestureDetector(
                   onTap: () {
                     setState(() {
                       _selectedInstrument = index;
                     });
                   },
                   child: Container(
                     margin: const EdgeInsets.only(bottom: 12),
                     padding: const EdgeInsets.all(18),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(
                         color: active ? AppTheme.primaryBlue : const Color(0xFFE8EEFF),
                         width: active ? 2.0 : 1.0,
                       ),
                       boxShadow: AppTheme.premiumShadow,
                     ),
                     child: Row(
                       children: [
                         Container(
                           padding: const EdgeInsets.all(10),
                           decoration: BoxDecoration(
                             color: inst['color'].withOpacity(0.08),
                             shape: BoxShape.circle,
                           ),
                           child: Icon(
                             inst['icon'],
                             color: inst['color'],
                             size: 22,
                           ),
                         ),
                         const SizedBox(width: 16),
                         Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 inst['name'],
                                 style: GoogleFonts.inter(
                                   color: AppTheme.textDark,
                                   fontSize: 13,
                                   fontWeight: FontWeight.w800,
                                 ),
                               ),
                               const SizedBox(height: 2),
                               Text(
                                 inst['type'],
                                 style: GoogleFonts.inter(
                                   color: AppTheme.textLightGray,
                                   fontSize: 10,
                                   fontWeight: FontWeight.w500,
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             Text(
                               inst['yield'],
                               style: GoogleFonts.inter(
                                 color: AppTheme.shariaGreen,
                                 fontSize: 12,
                                 fontWeight: FontWeight.w800,
                               ),
                             ),
                             if (inst['recommended']) ...[
                               const SizedBox(height: 4),
                               Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                 decoration: BoxDecoration(
                                   color: AppTheme.primaryBlue.withOpacity(0.08),
                                   borderRadius: BorderRadius.circular(4),
                                 ),
                                 child: Text(
                                   'REKOMENDASI',
                                   style: GoogleFonts.inter(
                                     color: AppTheme.primaryBlue,
                                     fontSize: 7,
                                     fontWeight: FontWeight.w900,
                                   ),
                                 ),
                               ),
                             ],
                           ],
                         ),
                       ],
                     ),
                   ),
                 );
               },
             ),
             const SizedBox(height: 28),

             // Allocation split percentage sliders controls
             Text(
               'Rasio Alokasi Autosave',
               style: GoogleFonts.inter(
                 color: AppTheme.textDark,
                 fontSize: 15,
                 fontWeight: FontWeight.w800,
               ),
             ),
             const SizedBox(height: 16),
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
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         _instruments[_selectedInstrument]['name'],
                         style: GoogleFonts.inter(
                           color: AppTheme.textDark,
                           fontSize: 12,
                           fontWeight: FontWeight.w800,
                         ),
                       ),
                       Text(
                         '${_allocationRatio.toInt()}%',
                         style: GoogleFonts.inter(
                           color: AppTheme.primaryBlue,
                           fontSize: 13,
                           fontWeight: FontWeight.w900,
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(height: 10),
                   Slider.adaptive(
                     value: _allocationRatio,
                     min: 10.0,
                     max: 100.0,
                     divisions: 9, // intervals for 10% divisions
                     activeColor: AppTheme.primaryBlue,
                     inactiveColor: const Color(0xFFF1F3FF),
                     onChanged: (val) {
                       setState(() {
                         _allocationRatio = val;
                       });
                     },
                   ),
                   const SizedBox(height: 12),
                   Text(
                     'Sisa ${_allocationRatio == 100.0 ? '0' : (100 - _allocationRatio.toInt()).toString()}% alokasi akan otomatis dicadangkan di rekening utama Anda.',
                     style: GoogleFonts.inter(
                       color: AppTheme.textLightGray,
                       fontSize: 10,
                       height: 1.3,
                     ),
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
               onPressed: _handleSaveInstruments,
               style: ElevatedButton.styleFrom(
                 backgroundColor: AppTheme.primaryBlue,
                 foregroundColor: Colors.white,
                 elevation: 0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(100),
                 ),
               ),
               child: Text(
                 'Simpan & Aktifkan Autosave',
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
}
