import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/theme/app_theme.dart';

class AIFinancialInsightsScreen extends StatefulWidget {
   const AIFinancialInsightsScreen({Key? key}) : super(key: key);

   @override
   State<AIFinancialInsightsScreen> createState() => _AIFinancialInsightsScreenState();
}

class _AIFinancialInsightsScreenState extends State<AIFinancialInsightsScreen> {
   // Spending categories values
   final List<double> _spendingValues = [40.0, 25.0, 20.0, 15.0]; // percentage splits
   final List<String> _categories = ['Belanja Harian', 'Tagihan Bulanan', 'Makan & Minum', 'Investasi'];
   final List<Color> _colors = [
     AppTheme.primaryBlue,
     Colors.amber,
     Colors.deepOrange,
     AppTheme.shariaGreen,
   ];

   // Smart advisory recommendation cards logs
   final List<Map<String, dynamic>> _insights = [
     {
       'title': 'Penghematan Makan & Minum 🍲',
       'desc': 'Bagus sekali! Pengeluaran restoran Anda turun Rp 250.000 dibanding bulan lalu.',
       'color': AppTheme.shariaGreen,
       'gain': 'Hemat Rp 250k',
     },
     {
       'title': 'Optimalisasi Receh Pembulatan 🪙',
       'desc': 'Autosave pembulatan kopi & jajan Anda telah menyumbang Rp 120.000 ke reksa dana syariah bulan ini.',
       'color': AppTheme.primaryBlue,
       'gain': 'Ditabung Rp 120k',
     },
     {
       'title': 'Peringatan Tagihan Bulanan ⚡️',
       'desc': 'Tagihan PLN pascabayar Anda telah diselesaikan (Rp 450.000) dan bebas denda terlambat.',
       'color': Colors.amber,
       'gain': 'Lunas',
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
           'AI Financial Insights',
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

             // Spending Category Doughnut Chart Box
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
                   Text(
                     'Distribusi Pengeluaran Mei 2026',
                     style: GoogleFonts.inter(
                       color: AppTheme.textDark,
                       fontSize: 14,
                       fontWeight: FontWeight.w800,
                     ),
                   ),
                   const SizedBox(height: 24),
                   
                   // Doughnut visual painting
                   SizedBox(
                     height: 140,
                     width: 140,
                     child: CustomPaint(
                       painter: DoughnutChartPainter(
                         values: _spendingValues,
                         colors: _colors,
                       ),
                     ),
                   ),
                   const SizedBox(height: 24),

                   // Color index legends grid
                   GridView.builder(
                     shrinkWrap: true,
                     physics: const NeverScrollableScrollPhysics(),
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 2,
                       childAspectRatio: 3.5,
                       mainAxisSpacing: 8,
                       crossAxisSpacing: 8,
                     ),
                     itemCount: _categories.length,
                     itemBuilder: (context, index) {
                       return Row(
                         children: [
                           Container(
                             width: 12,
                             height: 12,
                             decoration: BoxDecoration(
                               color: _colors[index],
                               shape: BoxShape.circle,
                             ),
                           ),
                           const SizedBox(width: 8),
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   _categories[index],
                                   maxLines: 1,
                                   overflow: TextOverflow.ellipsis,
                                   style: GoogleFonts.inter(
                                     color: AppTheme.textDark,
                                     fontSize: 10,
                                     fontWeight: FontWeight.w700,
                                   ),
                                 ),
                                 Text(
                                   '${_spendingValues[index].toInt()}%',
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
                       );
                     },
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 28),

             // AI smart advisory feed cards
             Text(
               'Rekomendasi Pintar AI',
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
               itemCount: _insights.length,
               itemBuilder: (context, index) {
                 final ins = _insights[index];
                 final Color col = ins['color'];
                 return Container(
                   margin: const EdgeInsets.only(bottom: 16),
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
                       Container(
                         padding: const EdgeInsets.all(10),
                         decoration: BoxDecoration(
                           color: col.withOpacity(0.08),
                           shape: BoxShape.circle,
                         ),
                         child: Icon(
                           Icons.auto_awesome,
                           color: col,
                           size: 20,
                         ),
                       ),
                       const SizedBox(width: 16),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Expanded(
                                   child: Text(
                                     ins['title']!,
                                     maxLines: 1,
                                     overflow: TextOverflow.ellipsis,
                                     style: GoogleFonts.inter(
                                       color: AppTheme.textDark,
                                       fontSize: 13,
                                       fontWeight: FontWeight.w800,
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 8),
                                 Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                   decoration: BoxDecoration(
                                     color: col.withOpacity(0.1),
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                   child: Text(
                                     ins['gain']!,
                                     style: GoogleFonts.inter(
                                       color: col,
                                       fontSize: 9,
                                       fontWeight: FontWeight.w900,
                                     ),
                                   ),
                                 ),
                               ],
                             ),
                             const SizedBox(height: 6),
                             Text(
                               ins['desc']!,
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

// Custom painter to draw beautiful categories doughnut pie chart
class DoughnutChartPainter extends CustomPainter {
   final List<double> values;
   final List<Color> colors;

   DoughnutChartPainter({required this.values, required this.colors});

   @override
   void paint(Canvas canvas, Size size) {
     final double total = values.fold(0, (sum, val) => sum + val);
     double startAngle = -pi / 2; // start top center

     final Rect rect = Rect.fromCircle(
       center: Offset(size.width / 2, size.height / 2),
       radius: size.width / 2,
     );

     final Paint paint = Paint()
       ..style = PaintingStyle.stroke
       ..strokeWidth = 18
       ..strokeCap = StrokeCap.round;

     for (int i = 0; i < values.length; i++) {
       final double sweepAngle = (values[i] / total) * 2 * pi;
       paint.color = colors[i];

       // Draw rounded arcs
       canvas.drawArc(rect, startAngle + 0.05, sweepAngle - 0.1, false, paint);
       startAngle += sweepAngle;
     }
   }

   @override
   bool shouldRepaint(covariant CustomPainter oldDelegate) {
     return true;
   }
}
