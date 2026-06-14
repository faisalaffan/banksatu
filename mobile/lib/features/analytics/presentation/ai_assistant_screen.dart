import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class AIAssistantScreen extends StatefulWidget {
   const AIAssistantScreen({Key? key}) : super(key: key);

   @override
   State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
   final List<Map<String, String>> _messages = [
     {
       'sender': 'ai',
       'text': 'Halo! Saya Asisten Pintar BankSatu. Ada yang bisa saya bantu untuk analisis keuangan atau portofolio investasi Anda hari ini?',
       'time': '10:00',
     }
   ];

   final TextEditingController _inputController = TextEditingController();
   final ScrollController _scrollController = ScrollController();
   bool _isThinking = false;

   final List<String> _quickQueries = [
     'Analisis pengeluaran kopi saya ☕️',
     'Rekomendasi reksa dana syariah 📈',
     'Berapa target Shared Vault kita? 👥',
     'Bandingkan yield emas vs saham ⚖️',
   ];

   @override
   void dispose() {
     _inputController.dispose();
     _scrollController.dispose();
     super.dispose();
   }

   void _sendMessage(String text) {
     if (text.isEmpty) return;

     setState(() {
       _messages.add({
         'sender': 'user',
         'text': text,
         'time': '10:02',
       });
       _isThinking = true;
     });

     _inputController.clear();
     _scrollToBottom();

     // Simulated AI answer logic based on keywords
     Future.delayed(const Duration(milliseconds: 1800), () {
       if (mounted) {
         String response = 'Maaf, saya tidak mengerti maksud Anda. Silakan coba tanyakan seputar rekomendasi reksa dana syariah atau pengeluaran kopi Anda.';
         
         final lower = text.toLowerCase();
         if (lower.contains('kopi')) {
           response = 'Analisis AI: Bulan ini Anda telah berbelanja Kopi sebanyak 8 kali dengan total pengeluaran Rp 320.000. Penggunaan fitur pembulatan (autosave 2x) berhasil menyaring tabungan otomatis sebesar Rp 80.000 dari transaksi kopi tersebut!';
         } else if (lower.contains('reksa dana') || lower.contains('syariah')) {
           response = 'Rekomendasi AI: "Satu Pasar Uang Sharia" adalah produk pasar uang terbaik dengan kestabilan yield mencapai +6.82% YTD dan memiliki tingkat risiko sangat rendah, cocok untuk profil investasi Anda!';
         } else if (lower.contains('vault') || lower.contains('target')) {
           response = 'Info AI: Target Shared Vault "Liburan Bersama Keluarga" saat ini telah terkumpul 35% (Rp 5.250.000 dari total Rp 15.000.000). Butuh Rp 9.750.000 lagi untuk mencapai garis finish!';
         } else if (lower.contains('emas') || lower.contains('saham') || lower.contains('yield')) {
           response = 'Analisis AI: yield Emas Antam (Satu Logam Mulia) berada pada kisaran +11.50% YTD dengan risiko rendah, sedangkan Saham Sharia Fund mencapai +15.40% YTD dengan volatilitas sedang-tinggi.';
         }

         setState(() {
           _isThinking = false;
           _messages.add({
             'sender': 'ai',
             'text': response,
             'time': '10:02',
           });
         });

         _scrollToBottom();
       }
     });
   }

   void _scrollToBottom() {
     Future.delayed(const Duration(milliseconds: 100), () {
       if (_scrollController.hasClients) {
         _scrollController.animateTo(
           _scrollController.position.maxScrollExtent,
           duration: const Duration(milliseconds: 300),
           curve: Curves.easeOut,
         );
       }
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
           onPressed: () => Navigator.of(context).pop(),
         ),
         title: Text(
           'Asisten Pintar AI',
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
       body: Column(
         children: [
           // Conversation lists area
           Expanded(
             child: ListView.builder(
               controller: _scrollController,
               physics: const BouncingScrollPhysics(),
               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
               itemCount: _messages.length,
               itemBuilder: (context, index) {
                 final msg = _messages[index];
                 final isAi = msg['sender'] == 'ai';
                 return Align(
                   alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                   child: Container(
                     margin: const EdgeInsets.only(bottom: 16),
                     constraints: BoxConstraints(
                       maxWidth: MediaQuery.of(context).size.width * 0.75,
                     ),
                     padding: const EdgeInsets.all(16),
                     decoration: BoxDecoration(
                       color: isAi ? Colors.white : AppTheme.primaryBlue,
                       borderRadius: BorderRadius.only(
                         topLeft: const Radius.circular(20),
                         topRight: const Radius.circular(20),
                         bottomLeft: Radius.circular(isAi ? 4 : 20),
                         bottomRight: Radius.circular(isAi ? 20 : 4),
                       ),
                       boxShadow: isAi ? AppTheme.premiumShadow : null,
                       border: isAi ? Border.all(color: const Color(0xFFE8EEFF)) : null,
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           msg['text']!,
                           style: GoogleFonts.inter(
                             color: isAi ? AppTheme.textDark : Colors.white,
                             fontSize: 13,
                             fontWeight: isAi ? FontWeight.w600 : FontWeight.w500,
                             height: 1.4,
                           ),
                         ),
                         const SizedBox(height: 6),
                         Align(
                           alignment: Alignment.bottomRight,
                           child: Text(
                             msg['time']!,
                             style: GoogleFonts.inter(
                               color: isAi ? AppTheme.textLightGray : Colors.white70,
                               fontSize: 8,
                               fontWeight: FontWeight.w500,
                             ),
                           ),
                         ),
                       ],
                     ),
                   ),
                 );
               },
             ),
           ),

           // Animated typing mesh indicators
           if (_isThinking)
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
               child: Row(
                 children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(20),
                       border: Border.all(color: const Color(0xFFE8EEFF)),
                     ),
                     child: Row(
                       children: [
                         Text(
                           'Asisten sedang berpikir',
                           style: GoogleFonts.inter(
                             color: AppTheme.textLightGray,
                             fontSize: 11,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                         const SizedBox(width: 8),
                         const SizedBox(
                           width: 12,
                           height: 12,
                           child: CircularProgressIndicator(
                             strokeWidth: 2,
                             color: AppTheme.primaryBlue,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),

           // Quick starters query chips horizontal
           if (!_isThinking && _messages.length == 1)
             Container(
               height: 44,
               margin: const EdgeInsets.only(bottom: 12),
               child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 physics: const BouncingScrollPhysics(),
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 itemCount: _quickQueries.length,
                 itemBuilder: (context, index) {
                   final query = _quickQueries[index];
                   return GestureDetector(
                     onTap: () => _sendMessage(query),
                     child: Container(
                       margin: const EdgeInsets.only(right: 8),
                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(100),
                         border: Border.all(color: const Color(0xFFE8EEFF)),
                         boxShadow: AppTheme.premiumShadow,
                       ),
                       child: Center(
                         child: Text(
                           query,
                           style: GoogleFonts.inter(
                             color: AppTheme.textDark,
                             fontSize: 11,
                             fontWeight: FontWeight.w700,
                           ),
                         ),
                       ),
                     ),
                   );
                 },
               ),
             ),

           // Input message area bar
           Container(
             padding: const EdgeInsets.all(20),
             decoration: const BoxDecoration(
               color: Colors.white,
               border: Border(top: BorderSide(color: Color(0xFFF1F3FF))),
             ),
             child: SafeArea(
               child: Row(
                 children: [
                   Expanded(
                     child: TextField(
                       controller: _inputController,
                       decoration: InputDecoration(
                         hintText: 'Tanyakan sesuatu ke Asisten...',
                         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(100),
                           borderSide: const BorderSide(color: Color(0xFFE8EEFF)),
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(100),
                           borderSide: const BorderSide(color: Color(0xFFE8EEFF)),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(100),
                           borderSide: const BorderSide(color: AppTheme.primaryBlue),
                         ),
                       ),
                       onSubmitted: (val) => _sendMessage(val),
                     ),
                   ),
                   const SizedBox(width: 12),
                   GestureDetector(
                     onTap: () => _sendMessage(_inputController.text),
                     child: Container(
                       padding: const EdgeInsets.all(12),
                       decoration: const BoxDecoration(
                         color: AppTheme.primaryBlue,
                         shape: BoxShape.circle,
                       ),
                       child: const Icon(
                         Icons.send,
                         color: Colors.white,
                         size: 20,
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
         ],
       ),
     );
   }
}
