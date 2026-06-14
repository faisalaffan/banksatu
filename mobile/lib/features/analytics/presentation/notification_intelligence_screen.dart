import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class NotificationIntelligenceScreen extends StatefulWidget {
   const NotificationIntelligenceScreen({Key? key}) : super(key: key);

   @override
   State<NotificationIntelligenceScreen> createState() => _NotificationIntelligenceScreenState();
}

class _NotificationIntelligenceScreenState extends State<NotificationIntelligenceScreen> {
   // Priority notification feed items list
   final List<Map<String, dynamic>> _notifications = [
     {
       'title': 'Upaya Otorisasi Pihak Ketiga 🛡️',
       'desc': 'Aplikasi Investasi X meminta izin untuk menautkan rekening BankSatu Anda secara aman.',
       'priority': 'HIGH',
       'time': '10 Menit yang lalu',
       'route': '/login',
       'actionText': 'Buka Otorisasi',
     },
     {
       'title': 'Tagihan Listrik Siap Dibayar ⚡️',
       'desc': 'Rincian pembayaran PLN pascabayar bulan Mei telah diterbitkan sebesar Rp 450.000.',
       'priority': 'MEDIUM',
       'time': '2 Jam yang lalu',
       'route': '/transactions/pln-detail',
       'actionText': 'Bayar Sekarang',
     },
     {
       'title': 'Setoran Shared Vault Sukses! 🎉',
       'desc': 'Budi Pratama baru saja menyetor Rp 750.000 ke "Liburan Bersama Keluarga" Pocket.',
       'priority': 'LOW',
       'time': 'Kemarin',
       'route': '/wealth/savings/shared-vault',
       'actionText': 'Lihat Vault',
     },
   ];

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
           'Notifikasi Pintar',
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
       body: ListView.builder(
         physics: const BouncingScrollPhysics(),
         padding: const EdgeInsets.all(24),
         itemCount: _notifications.length,
         itemBuilder: (context, index) {
           final n = _notifications[index];
           final isHigh = n['priority'] == 'HIGH';
           final isMedium = n['priority'] == 'MEDIUM';

           final Color pColor = isHigh
               ? Colors.red
               : (isMedium ? Colors.amber : AppTheme.primaryBlue);

           return Container(
             margin: const EdgeInsets.only(bottom: 16),
             padding: const EdgeInsets.all(20),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(24),
               border: Border.all(color: const Color(0xFFE8EEFF)),
               boxShadow: AppTheme.premiumShadow,
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 // Top indicator priority badge row
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                       decoration: BoxDecoration(
                         color: pColor.withOpacity(0.08),
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: Text(
                         'PRIORITAS ${n['priority']}',
                         style: GoogleFonts.inter(
                           color: pColor,
                           fontSize: 8,
                           fontWeight: FontWeight.w900,
                         ),
                       ),
                     ),
                     Text(
                       n['time']!,
                       style: GoogleFonts.inter(
                         color: AppTheme.textLightGray,
                         fontSize: 9,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(height: 12),

                 // Message contents
                 Text(
                   n['title']!,
                   style: GoogleFonts.inter(
                     color: AppTheme.textDark,
                     fontSize: 14,
                     fontWeight: FontWeight.w800,
                   ),
                 ),
                 const SizedBox(height: 6),
                 Text(
                   n['desc']!,
                   style: GoogleFonts.inter(
                     color: AppTheme.textLightGray,
                     fontSize: 12,
                     height: 1.4,
                   ),
                 ),
                 const Divider(height: 28, color: Color(0xFFF1F3FF)),

                 // Actionable deep-link triggers CTA
                 SizedBox(
                   width: double.infinity,
                   height: 40,
                   child: ElevatedButton(
                     onPressed: () {
                       context.push(n['route']!);
                     },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: pColor,
                       foregroundColor: Colors.white,
                       elevation: 0,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(12),
                       ),
                     ),
                     child: Text(
                       n['actionText']!,
                       style: GoogleFonts.inter(
                         fontWeight: FontWeight.w700,
                         fontSize: 12,
                       ),
                     ),
                   ),
                 ),
               ],
             ),
           );
         },
       ),
     );
   }
}
