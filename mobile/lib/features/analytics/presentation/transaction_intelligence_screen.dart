import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class TransactionIntelligenceScreen extends StatefulWidget {
   const TransactionIntelligenceScreen({Key? key}) : super(key: key);

   @override
   State<TransactionIntelligenceScreen> createState() => _TransactionIntelligenceScreenState();
}

class _TransactionIntelligenceScreenState extends State<TransactionIntelligenceScreen> {
   // Active category budget indicators percentages
   final List<Map<String, dynamic>> _budgets = [
     {'category': 'Makan & Minum', 'spent': 680000, 'cap': 1000000, 'color': Colors.deepOrange},
     {'category': 'Belanja Harian', 'spent': 1200000, 'cap': 1500000, 'color': AppTheme.primaryBlue},
     {'category': 'Transportasi', 'spent': 150000, 'cap': 500000, 'color': Colors.amber},
   ];

   // Smart transaction categorizer items logs
   final List<Map<String, String>> _transactions = [
     {'merchant': 'Kopi Kenangan', 'amount': 'Rp 35.000', 'tag': 'Makan & Minum', 'conf': '99%'},
     {'merchant': 'Indomaret Cilandak', 'amount': 'Rp 142.500', 'tag': 'Belanja Harian', 'conf': '97%'},
     {'merchant': 'McDonalds Kemang', 'amount': 'Rp 88.000', 'tag': 'Makan & Minum', 'conf': '98%'},
     {'merchant': 'Gojek Ride', 'amount': 'Rp 22.000', 'tag': 'Transportasi', 'conf': '95%'},
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
           'Analisis Transaksi Pintar',
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

             // Budget indicators progress tracks
             Text(
               'Batas Anggaran Kategori (Budgets)',
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
               itemCount: _budgets.length,
               itemBuilder: (context, index) {
                 final b = _budgets[index];
                 final double spent = b['spent'].toDouble();
                 final double cap = b['cap'].toDouble();
                 final double ratio = (spent / cap).clamp(0.0, 1.0);
                 final Color color = b['color'];

                 String spentStr = 'Rp ${(b['spent'] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
                 String capStr = 'Rp ${(b['cap'] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

                 return Container(
                   margin: const EdgeInsets.only(bottom: 16),
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
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(
                             b['category']!,
                             style: GoogleFonts.inter(
                               color: AppTheme.textDark,
                               fontSize: 13,
                               fontWeight: FontWeight.w800,
                             ),
                           ),
                           Text(
                             '$spentStr / $capStr',
                             style: GoogleFonts.inter(
                               color: AppTheme.textLightGray,
                               fontSize: 11,
                               fontWeight: FontWeight.w600,
                             ),
                           ),
                         ],
                       ),
                       const SizedBox(height: 12),
                       
                       // Progress bar
                       ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                         child: SizedBox(
                           height: 8,
                           width: double.infinity,
                           child: LinearProgressIndicator(
                             value: ratio,
                             backgroundColor: const Color(0xFFF1F3FF),
                             color: color,
                           ),
                         ),
                       ),
                     ],
                   ),
                 );
               },
             ),
             const SizedBox(height: 20),

             // Smart Merchant lists transactions categorizer
             Text(
               'Klasifikasi Aset & Merchant AI',
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
               itemCount: _transactions.length,
               itemBuilder: (context, index) {
                 final tx = _transactions[index];
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
                         decoration: const BoxDecoration(
                           color: Color(0xFFEDFBF0),
                           shape: BoxShape.circle,
                         ),
                         child: const Icon(
                           Icons.shopping_bag_outlined,
                           color: AppTheme.shariaGreen,
                           size: 18,
                         ),
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               tx['merchant']!,
                               style: GoogleFonts.inter(
                                 color: AppTheme.textDark,
                                 fontSize: 13,
                                 fontWeight: FontWeight.w800,
                               ),
                             ),
                             const SizedBox(height: 2),
                             Row(
                               children: [
                                 Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                   decoration: BoxDecoration(
                                     color: AppTheme.primaryBlue.withOpacity(0.08),
                                     borderRadius: BorderRadius.circular(4),
                                   ),
                                   child: Text(
                                     tx['tag']!,
                                     style: GoogleFonts.inter(
                                       color: AppTheme.primaryBlue,
                                       fontSize: 8,
                                       fontWeight: FontWeight.w800,
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 8),
                                 Text(
                                   'AI Akurasi: ${tx['conf']}',
                                   style: GoogleFonts.inter(
                                     color: AppTheme.textLightGray,
                                     fontSize: 9,
                                     fontWeight: FontWeight.w500,
                                   ),
                                 ),
                               ],
                             ),
                           ],
                         ),
                       ),
                       Text(
                         tx['amount']!,
                         style: GoogleFonts.inter(
                           color: AppTheme.textDark,
                           fontSize: 13,
                           fontWeight: FontWeight.w800,
                         ),
                       ),
                     ],
                   ),
                 );
               },
             ),
             const SizedBox(height: 40),
           ],
         ),
       ),
     );
   }
}
