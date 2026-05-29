import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/theme/app_theme.dart';

class AIAssistantSearchScreen extends StatefulWidget {
   const AIAssistantSearchScreen({Key? key}) : super(key: key);

   @override
   State<AIAssistantSearchScreen> createState() => _AIAssistantSearchScreenState();
}

class _AIAssistantSearchScreenState extends State<AIAssistantSearchScreen> {
   final TextEditingController _searchController = TextEditingController();
   String _query = '';

   // Complete semantic items list in app
   final List<Map<String, String>> _searchDatabase = [
     {'title': 'Transfer BI-FAST', 'category': 'Fitur Utama', 'route': '/transactions/transfer', 'type': 'action'},
     {'title': 'Isi Saldo Token PLN', 'category': 'Fitur Utama', 'route': '/transactions/pay-bills', 'type': 'action'},
     {'title': 'Scan QRIS Pay Merchant', 'category': 'Fitur Utama', 'route': '/transactions/qris-scan', 'type': 'action'},
     {'title': 'Split Bill Makan Malam', 'category': 'Fitur Utama', 'route': '/transactions/bill-split', 'type': 'action'},
     {'title': 'Beli Reksadana Sharia', 'category': 'Investasi', 'route': '/wealth/invest', 'type': 'wealth'},
     {'title': 'Atur Autosave Round-up', 'category': 'Tabungan', 'route': '/wealth/roundup', 'type': 'wealth'},
     {'title': 'Buat Tabungan Berjangka', 'category': 'Tabungan', 'route': '/wealth/savings/time-deposit', 'type': 'wealth'},
     {'title': 'Akses Shared Vault Pocket', 'category': 'Tabungan', 'route': '/wealth/savings/shared-vault', 'type': 'wealth'},
     {'title': 'Konfigurasi Keamanan PIN', 'category': 'Keamanan', 'route': '/profile', 'type': 'profile'},
   ];

   List<Map<String, String>> _getFilteredResults() {
     if (_query.isEmpty) {
       return _searchDatabase.take(4).toList(); // show popular recents
     }
     final lower = _query.toLowerCase();
     return _searchDatabase.where((item) {
       return item['title']!.toLowerCase().contains(lower) ||
              item['category']!.toLowerCase().contains(lower);
     }).toList();
   }

   @override
   void dispose() {
     _searchController.dispose();
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {
     final results = _getFilteredResults();

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
           'Pencarian Pintar AI',
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
       body: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 24),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const SizedBox(height: 12),

             // Semantic Search Input Box
             Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(100),
                 boxShadow: AppTheme.premiumShadow,
                 border: Border.all(color: const Color(0xFFE8EEFF)),
               ),
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: TextField(
                 controller: _searchController,
                 autofocus: true,
                 onChanged: (val) {
                   setState(() {
                     _query = val;
                   });
                 },
                 decoration: InputDecoration(
                   hintText: 'Cari fitur, menu, atau bantuan (e.g. transfer)',
                   hintStyle: GoogleFonts.inter(fontSize: 12, color: AppTheme.textLightGray),
                   border: InputBorder.none,
                   prefixIcon: const Icon(Icons.search, color: AppTheme.primaryBlue),
                   suffixIcon: _query.isNotEmpty
                       ? IconButton(
                           icon: const Icon(Icons.clear, color: AppTheme.textLightGray, size: 18),
                           onPressed: () {
                             _searchController.clear();
                             setState(() {
                               _query = '';
                             });
                           },
                         )
                       : null,
                 ),
               ),
             ),
             const SizedBox(height: 28),

             // Suggestion lists header titles
             Text(
               _query.isEmpty ? 'Pencarian Terpopuler' : 'Hasil Pencarian (${results.length})',
               style: GoogleFonts.inter(
                 color: AppTheme.textDark,
                 fontSize: 14,
                 fontWeight: FontWeight.w800,
               ),
             ),
             const SizedBox(height: 16),

             // Suggestions logs list view
             Expanded(
               child: ListView.builder(
                 physics: const BouncingScrollPhysics(),
                 itemCount: results.length,
                 itemBuilder: (context, index) {
                   final item = results[index];
                   return Container(
                     margin: const EdgeInsets.only(bottom: 12),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(16),
                       border: Border.all(color: const Color(0xFFE8EEFF)),
                       boxShadow: AppTheme.premiumShadow,
                     ),
                     child: ListTile(
                       onTap: () {
                         context.push(item['route']!);
                       },
                       leading: Container(
                         padding: const EdgeInsets.all(8),
                         decoration: BoxDecoration(
                           color: item['type'] == 'action'
                               ? const Color(0xFFFFF9E6)
                               : (item['type'] == 'wealth' ? const Color(0xFFEDFBF0) : const Color(0xFFEEF4FF)),
                           shape: BoxShape.circle,
                         ),
                         child: Icon(
                           item['type'] == 'action'
                               ? Icons.bolt
                               : (item['type'] == 'wealth' ? Icons.eco : Icons.person),
                           color: item['type'] == 'action'
                               ? Colors.amber
                               : (item['type'] == 'wealth' ? AppTheme.shariaGreen : AppTheme.primaryBlue),
                           size: 18,
                         ),
                       ),
                       title: Text(
                         item['title']!,
                         style: GoogleFonts.inter(
                           color: AppTheme.textDark,
                           fontSize: 13,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                       subtitle: Text(
                         item['category']!,
                         style: GoogleFonts.inter(
                           color: AppTheme.textLightGray,
                           fontSize: 9,
                           fontWeight: FontWeight.w500,
                         ),
                       ),
                       trailing: const Icon(
                         Icons.chevron_right,
                         color: AppTheme.textLightGray,
                         size: 16,
                       ),
                     ),
                   );
                 },
               ),
             ),
           ],
         ),
       ),
     );
   }
}
