import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simulator/core/theme/app_theme.dart';

class SharedVaultScreen extends StatefulWidget {
   const SharedVaultScreen({Key? key}) : super(key: key);

   @override
   State<SharedVaultScreen> createState() => _SharedVaultScreenState();
}

class _SharedVaultScreenState extends State<SharedVaultScreen> {
   final double _targetAmount = 15000000.0;
   double _collectedAmount = 5250000.0;

   // List of members in the collaborative vault
   final List<Map<String, String>> _members = [
     {'name': 'You', 'role': 'Owner', 'initials': 'Y'},
     {'name': 'Budi Pratama', 'role': 'Contributor', 'initials': 'BP'},
     {'name': 'Siti Aminah', 'role': 'Contributor', 'initials': 'SA'},
     {'name': 'Agus Tri', 'role': 'Contributor', 'initials': 'AT'},
   ];

   // Contribution events feed logs list
   final List<Map<String, String>> _logs = [
     {'member': 'Budi Pratama', 'amount': 'Rp 750.000', 'time': 'Hari ini, 14:20'},
     {'member': 'Siti Aminah', 'amount': 'Rp 1.500.000', 'time': 'Kemarin, 09:15'},
     {'member': 'You', 'amount': 'Rp 2.000.000', 'time': '27 Mei, 18:40'},
     {'member': 'Agus Tri', 'amount': 'Rp 1.000.000', 'time': '25 Mei, 11:10'},
   ];

   void _showDepositSheet() {
     showModalBottomSheet(
       context: context,
       isScrollControlled: true,
       backgroundColor: Colors.transparent,
       builder: (context) {
         return DepositKeypadSheet(
           onDepositSuccess: (amount) {
             setState(() {
               _collectedAmount += amount;
               // Add log
               _logs.insert(0, {
                 'member': 'You',
                 'amount': 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                 'time': 'Baru saja',
               });
             });
           },
         );
       },
     );
   }

   @override
   Widget build(BuildContext context) {
     final double percent = (_collectedAmount / _targetAmount).clamp(0.0, 1.0);
     String collectedStr = 'Rp ${_collectedAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
     String targetStr = 'Rp ${_targetAmount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

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
           'Shared Vault (Joint Pocket)',
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

             // Main target progress card
             Container(
               padding: const EdgeInsets.all(24),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(24),
                 boxShadow: AppTheme.premiumShadow,
                 border: Border.all(color: const Color(0xFFE8EEFF)),
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   // Large radial target visual percentage
                   SizedBox(
                     height: 140,
                     width: 140,
                     child: Stack(
                       alignment: Alignment.center,
                       children: [
                         SizedBox(
                           height: 120,
                           width: 120,
                           child: CircularProgressIndicator(
                             value: percent,
                             strokeWidth: 12,
                             backgroundColor: const Color(0xFFF1F3FF),
                             color: AppTheme.primaryBlue,
                           ),
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               '${(percent * 100).toInt()}%',
                               style: GoogleFonts.inter(
                                 color: AppTheme.textDark,
                                 fontSize: 28,
                                 fontWeight: FontWeight.w900,
                               ),
                             ),
                             Text(
                               'Terkumpul',
                               style: GoogleFonts.inter(
                                 color: AppTheme.textLightGray,
                                 fontSize: 10,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                   const SizedBox(height: 24),

                   // Title & total amount details
                   Text(
                     'Liburan Bersama Keluarga',
                     style: GoogleFonts.inter(
                       color: AppTheme.textDark,
                       fontSize: 18,
                       fontWeight: FontWeight.w800,
                     ),
                   ),
                   const SizedBox(height: 6),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         collectedStr,
                         style: GoogleFonts.inter(
                           color: AppTheme.primaryBlue,
                           fontSize: 15,
                           fontWeight: FontWeight.w900,
                         ),
                       ),
                       Text(
                         ' dari target $targetStr',
                         style: GoogleFonts.inter(
                           color: AppTheme.textLightGray,
                           fontSize: 12,
                           fontWeight: FontWeight.w500,
                         ),
                       ),
                     ],
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 28),

             // Horizontal members avatar list
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   'Kolaborator (${_members.length})',
                   style: GoogleFonts.inter(
                     color: AppTheme.textDark,
                     fontSize: 15,
                     fontWeight: FontWeight.w800,
                   ),
                 ),
                 IconButton(
                   icon: const Icon(Icons.person_add_alt, color: AppTheme.primaryBlue, size: 20),
                   onPressed: () {},
                 ),
               ],
             ),
             const SizedBox(height: 10),
             SizedBox(
               height: 50,
               child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                 physics: const BouncingScrollPhysics(),
                 itemCount: _members.length,
                 itemBuilder: (context, index) {
                   final mem = _members[index];
                   return Container(
                     margin: const EdgeInsets.only(right: 12),
                     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                     decoration: BoxDecoration(
                       color: mem['role'] == 'Owner' ? const Color(0xFFFFF9E6) : const Color(0xFFF1F3FF),
                       borderRadius: BorderRadius.circular(12),
                       border: Border.all(
                         color: mem['role'] == 'Owner' ? Colors.amber.withOpacity(0.3) : Colors.transparent,
                       ),
                     ),
                     child: Row(
                       children: [
                         CircleAvatar(
                           radius: 12,
                           backgroundColor: mem['role'] == 'Owner' ? Colors.amber : AppTheme.primaryBlue,
                           child: Text(
                             mem['initials']!,
                             style: GoogleFonts.inter(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white),
                           ),
                         ),
                         const SizedBox(width: 8),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               mem['name']!,
                               style: GoogleFonts.inter(color: AppTheme.textDark, fontSize: 11, fontWeight: FontWeight.w700),
                             ),
                             Text(
                               mem['role']!,
                               style: GoogleFonts.inter(color: AppTheme.textLightGray, fontSize: 8, fontWeight: FontWeight.w500),
                             ),
                           ],
                         ),
                       ],
                     ),
                   );
                 },
               ),
             ),
             const SizedBox(height: 28),

             // Activity Log Feed Feed list
             Text(
               'Aktivitas Tabungan',
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
               itemCount: _logs.length,
               itemBuilder: (context, index) {
                 final log = _logs[index];
                 return Container(
                   margin: const EdgeInsets.only(bottom: 12),
                   padding: const EdgeInsets.all(16),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(16),
                     border: Border.all(color: const Color(0xFFE8EEFF)),
                   ),
                   child: Row(
                     children: [
                       Container(
                         padding: const EdgeInsets.all(8),
                         decoration: const BoxDecoration(
                           color: Color(0xFFFFF4F2),
                           shape: BoxShape.circle,
                         ),
                         child: const Icon(
                           Icons.vertical_align_bottom,
                           color: Colors.redAccent,
                           size: 16,
                         ),
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             RichText(
                               text: TextSpan(
                                 style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textDark),
                                 children: [
                                   TextSpan(
                                     text: log['member'],
                                     style: const TextStyle(fontWeight: FontWeight.w700),
                                   ),
                                   const TextSpan(text: ' menyetor dana sebesar '),
                                   TextSpan(
                                     text: log['amount'],
                                     style: const TextStyle(fontWeight: FontWeight.w800, color: AppTheme.shariaGreen),
                                   ),
                                 ],
                               ),
                             ),
                             const SizedBox(height: 4),
                             Text(
                               log['time']!,
                               style: GoogleFonts.inter(
                                 color: AppTheme.textLightGray,
                                 fontSize: 9,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                 );
               },
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
               onPressed: _showDepositSheet,
               style: ElevatedButton.styleFrom(
                 backgroundColor: AppTheme.primaryBlue,
                 foregroundColor: Colors.white,
                 elevation: 0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(100),
                 ),
               ),
               child: Text(
                 'Ikut Patungan',
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

// Quick interactive deposit modal sheet with custom keypad dial dialer
class DepositKeypadSheet extends StatefulWidget {
   final Function(double) onDepositSuccess;

   const DepositKeypadSheet({Key? key, required this.onDepositSuccess}) : super(key: key);

   @override
   State<DepositKeypadSheet> createState() => _DepositKeypadSheetState();
}

class _DepositKeypadSheetState extends State<DepositKeypadSheet> {
   String _amount = '';
   bool _isDepositing = false;

   void _onKeyPress(String val) {
     if (_amount.length < 9) {
       setState(() {
         _amount += val;
       });
     }
   }

   void _onBackspace() {
     if (_amount.isNotEmpty) {
       setState(() {
         _amount = _amount.substring(0, _amount.length - 1);
       });
     }
   }

   void _handleDeposit() {
     final val = double.tryParse(_amount) ?? 0.0;
     if (val <= 0.0) return;

     setState(() {
       _isDepositing = true;
     });

     // Simulate fast transaction
     Future.delayed(const Duration(milliseconds: 1200), () {
       if (mounted) {
         setState(() {
           _isDepositing = false;
         });
         Navigator.of(context).pop();
         widget.onDepositSuccess(val);
       }
     });
   }

   @override
   Widget build(BuildContext context) {
     double parsedVal = double.tryParse(_amount) ?? 0.0;
     String balanceStr = parsedVal == 0
         ? 'Rp 0'
         : 'Rp ${parsedVal.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

     return Container(
       decoration: const BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.only(
           topLeft: Radius.circular(28),
           topRight: Radius.circular(28),
         ),
       ),
       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           // Drag handle bar indicator
           Container(
             width: 40,
             height: 4,
             decoration: BoxDecoration(
               color: AppTheme.textDisabled.withOpacity(0.4),
               borderRadius: BorderRadius.circular(2),
             ),
           ),
           const SizedBox(height: 24),

           Text(
             _isDepositing ? 'Mengirim Dana Patungan...' : 'Setor ke Shared Vault',
             style: GoogleFonts.inter(
               color: AppTheme.textDark,
               fontSize: 16,
               fontWeight: FontWeight.w800,
             ),
           ),
           const SizedBox(height: 32),

           // Glowing active balance nominal digits text
           if (_isDepositing)
             Platform.isIOS
                 ? const CupertinoActivityIndicator(color: AppTheme.primaryBlue, radius: 14)
                 : const CircularProgressIndicator(color: AppTheme.primaryBlue)
           else
             Text(
               balanceStr,
               style: GoogleFonts.inter(
                 color: AppTheme.primaryBlue,
                 fontSize: 32,
                 fontWeight: FontWeight.w900,
                 letterSpacing: -0.5,
               ),
             ),
           const SizedBox(height: 40),

           // Numerical Dial Dial grid dialpad
           if (!_isDepositing) ...[
             GridView.builder(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 3,
                 childAspectRatio: 1.5,
                 mainAxisSpacing: 12,
                 crossAxisSpacing: 12,
               ),
               itemCount: 12,
               itemBuilder: (context, index) {
                 if (index == 9) return const SizedBox.shrink();
                 if (index == 11) {
                   return InkWell(
                     onTap: _onBackspace,
                     borderRadius: BorderRadius.circular(100),
                     child: const Center(
                       child: Icon(Icons.backspace_outlined, color: AppTheme.textDark, size: 20),
                     ),
                   );
                 }
                 final digit = index == 10 ? '0' : (index + 1).toString();
                 return InkWell(
                   onTap: () => _onKeyPress(digit),
                   borderRadius: BorderRadius.circular(100),
                   child: Center(
                     child: Text(
                       digit,
                       style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600, color: AppTheme.textDark),
                     ),
                   ),
                 );
               },
             ),
             const SizedBox(height: 24),
             
             // Confirm deposit button CTA
             SizedBox(
               width: double.infinity,
               height: 50,
               child: ElevatedButton(
                 onPressed: parsedVal > 0 ? _handleDeposit : null,
                 style: ElevatedButton.styleFrom(
                   backgroundColor: AppTheme.primaryBlue,
                   foregroundColor: Colors.white,
                   elevation: 0,
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                 ),
                 child: Text(
                   'Setor Dana',
                   style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 14),
                 ),
               ),
             ),
           ],
         ],
       ),
     );
   }
}
