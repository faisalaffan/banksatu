import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:simulator/core/theme/app_theme.dart';

class InvestScreen extends StatefulWidget {
   const InvestScreen({Key? key}) : super(key: key);

   @override
   State<InvestScreen> createState() => _InvestScreenState();
}

class _InvestScreenState extends State<InvestScreen> with SingleTickerProviderStateMixin {
   String _selectedTimeframe = '3M';
   int _selectedAssetCategory = 0; // 0: All, 1: Mutual Funds, 2: Gold, 3: Stocks
   
   late AnimationController _chartAnimationController;
   late Animation<double> _chartProgress;

   final List<String> _timeframes = ['1M', '3M', '1Y', 'ALL'];

   // Performance data points mapped by timeframe
   final Map<String, List<double>> _chartData = {
     '1M': [12.0, 12.8, 12.5, 13.2, 13.0, 13.8, 14.2, 14.5],
     '3M': [10.0, 10.5, 11.2, 10.8, 12.0, 12.5, 13.2, 14.5],
     '1Y': [8.0, 8.5, 9.2, 9.8, 10.5, 11.0, 12.0, 14.5],
     'ALL': [5.0, 6.2, 7.5, 9.0, 10.2, 11.5, 13.0, 14.5],
   };

   @override
   void initState() {
     super.initState();
     _chartAnimationController = AnimationController(
       vsync: this,
       duration: const Duration(milliseconds: 1000),
     );
     _chartProgress = CurvedAnimation(
       parent: _chartAnimationController,
       curve: Curves.easeInOutCubic,
     );
     _chartAnimationController.forward();
   }

   @override
   void dispose() {
     _chartAnimationController.dispose();
     super.dispose();
   }

   void _onTimeframeChange(String tf) {
     setState(() {
       _selectedTimeframe = tf;
     });
     _chartAnimationController.reset();
     _chartAnimationController.forward();
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
           'Investasi BankSatu',
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
             
             // Top Total Investment Value Card
             Container(
               padding: const EdgeInsets.all(24),
               decoration: BoxDecoration(
                 gradient: const LinearGradient(
                   colors: [
                     AppTheme.primaryBlue,
                     Color(0xFF003080),
                   ],
                   begin: Alignment.topLeft,
                   end: Alignment.bottomRight,
                 ),
                 borderRadius: BorderRadius.circular(24),
                 boxShadow: [
                   BoxShadow(
                     color: AppTheme.primaryBlue.withOpacity(0.3),
                     blurRadius: 20,
                     offset: const Offset(0, 10),
                   ),
                 ],
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(
                         'Total Portofolio Investasi',
                         style: GoogleFonts.inter(
                           color: Colors.white.withOpacity(0.8),
                           fontSize: 12,
                           fontWeight: FontWeight.w600,
                         ),
                       ),
                       Container(
                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                         decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.12),
                           borderRadius: BorderRadius.circular(20),
                         ),
                         child: Row(
                           children: [
                             const Icon(
                               Icons.trending_up,
                               color: AppTheme.shariaGreenLight,
                               size: 14,
                             ),
                             const SizedBox(width: 4),
                             Text(
                               '+12.4%',
                               style: GoogleFonts.inter(
                                 color: AppTheme.shariaGreenLight,
                                 fontSize: 11,
                                 fontWeight: FontWeight.w700,
                               ),
                             ),
                           ],
                         ),
                       ),
                     ],
                   ),
                   const SizedBox(height: 8),
                   Text(
                     'Rp 42.850.000',
                     style: GoogleFonts.inter(
                       color: Colors.white,
                       fontSize: 28,
                       fontWeight: FontWeight.w900,
                       letterSpacing: -0.5,
                     ),
                   ),
                   const SizedBox(height: 24),
                   const Divider(color: Colors.white24, height: 1),
                   const SizedBox(height: 16),
                   Row(
                     children: [
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               'Modal Utama',
                               style: GoogleFonts.inter(
                                 color: Colors.white60,
                                 fontSize: 10,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                             const SizedBox(height: 4),
                             Text(
                               'Rp 38.120.000',
                               style: GoogleFonts.inter(
                                 color: Colors.white,
                                 fontSize: 13,
                                 fontWeight: FontWeight.w700,
                               ),
                             ),
                           ],
                         ),
                       ),
                       Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                               'Keuntungan Bersih',
                               style: GoogleFonts.inter(
                                 color: Colors.white60,
                                 fontSize: 10,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                             const SizedBox(height: 4),
                             Text(
                               'Rp 4.730.000',
                               style: GoogleFonts.inter(
                                 color: AppTheme.shariaGreenLight,
                                 fontSize: 13,
                                 fontWeight: FontWeight.w700,
                               ),
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

             // Bezier Performance Graph Section
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   'Perkembangan Aset',
                   style: GoogleFonts.inter(
                     color: AppTheme.textDark,
                     fontSize: 15,
                     fontWeight: FontWeight.w800,
                   ),
                 ),
                 
                 // Timeframe Pills
                 Row(
                   children: _timeframes.map((tf) {
                     final active = _selectedTimeframe == tf;
                     return GestureDetector(
                       onTap: () => _onTimeframeChange(tf),
                       child: Container(
                         margin: const EdgeInsets.only(left: 6),
                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                         decoration: BoxDecoration(
                           color: active ? AppTheme.primaryBlue : Colors.white,
                           borderRadius: BorderRadius.circular(100),
                           border: Border.all(
                             color: active ? AppTheme.primaryBlue : const Color(0xFFE8EEFF),
                           ),
                         ),
                         child: Text(
                           tf,
                           style: GoogleFonts.inter(
                             color: active ? Colors.white : AppTheme.textLightGray,
                             fontSize: 10,
                             fontWeight: FontWeight.w800,
                           ),
                         ),
                       ),
                     );
                   }).toList(),
                 ),
               ],
             ),
             const SizedBox(height: 16),
             
             // Custom Line Graph Box
             Container(
               height: 180,
               width: double.infinity,
               padding: const EdgeInsets.all(16),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(20),
                 boxShadow: AppTheme.premiumShadow,
                 border: Border.all(color: const Color(0xFFE8EEFF)),
               ),
               child: AnimatedBuilder(
                 animation: _chartProgress,
                 builder: (context, child) {
                   return CustomPaint(
                     painter: BezierCurvePainter(
                       dataPoints: _chartData[_selectedTimeframe]!,
                       progress: _chartProgress.value,
                     ),
                   );
                 },
               ),
             ),
             const SizedBox(height: 28),

             // Asset Category Icons List
             Text(
               'Kategori Instrumen',
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
                 _buildCategoryBtn(0, Icons.pie_chart_outline, 'Reksadana'),
                 _buildCategoryBtn(1, Icons.brightness_high_outlined, 'Emas'),
                 _buildCategoryBtn(2, Icons.show_chart_outlined, 'Saham'),
                 _buildCategoryBtn(3, Icons.account_balance_outlined, 'Obligasi'),
               ],
             ),
             const SizedBox(height: 28),

             // Sharia/Standard Mutual Funds Grid Carousel
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   'Rekomendasi Produk Terlaris',
                   style: GoogleFonts.inter(
                     color: AppTheme.textDark,
                     fontSize: 15,
                     fontWeight: FontWeight.w800,
                   ),
                 ),
                 GestureDetector(
                   onTap: () => context.push('/wealth/roundup/instruments'),
                   child: Text(
                     'Lihat Semua',
                     style: GoogleFonts.inter(
                       color: AppTheme.primaryBlue,
                       fontSize: 12,
                       fontWeight: FontWeight.w700,
                     ),
                   ),
                 ),
               ],
             ),
             const SizedBox(height: 16),
             
             // Dynamic Horizontal Scroll recommendations cards
             SizedBox(
               height: 160,
               child: ListView(
                 scrollDirection: Axis.horizontal,
                 physics: const BouncingScrollPhysics(),
                 children: [
                   _buildProductCard(
                     'Satu Pasar Uang Sharia',
                     'Reksa Dana • Pasar Uang',
                     '+6.82%',
                     AppTheme.shariaGreen,
                     Icons.eco_outlined,
                     true,
                   ),
                   _buildProductCard(
                     'BankSatu Bluechip Fund',
                     'Reksa Dana • Saham',
                     '+14.85%',
                     AppTheme.primaryBlue,
                     Icons.trending_up,
                     false,
                   ),
                   _buildProductCard(
                     'Satu Obligasi Negara Sharia',
                     'Reksa Dana • Pendapatan Tetap',
                     '+8.42%',
                     Colors.deepOrange,
                     Icons.account_balance_wallet,
                     true,
                   ),
                 ],
               ),
             ),
             const SizedBox(height: 40),
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
           child: Row(
             children: [
               Expanded(
                 child: SizedBox(
                   height: 50,
                   child: ElevatedButton(
                     onPressed: () => context.push('/wealth/roundup'),
                     style: ElevatedButton.styleFrom(
                       backgroundColor: AppTheme.primaryBlue,
                       foregroundColor: Colors.white,
                       elevation: 0,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(16),
                       ),
                     ),
                     child: Text(
                       'Aktivasi Tabungan Otomatis',
                       style: GoogleFonts.inter(
                         fontWeight: FontWeight.w700,
                         fontSize: 14,
                       ),
                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
       ),
     );
   }

   Widget _buildCategoryBtn(int index, IconData icon, String label) {
     final active = _selectedAssetCategory == index;
     return GestureDetector(
       onTap: () {
         setState(() {
           _selectedAssetCategory = index;
         });
         _chartAnimationController.reset();
         _chartAnimationController.forward();
       },
       child: Column(
         children: [
           Container(
             width: 60,
             height: 60,
             decoration: BoxDecoration(
               color: active ? AppTheme.primaryBlue : Colors.white,
               borderRadius: BorderRadius.circular(16),
               boxShadow: AppTheme.premiumShadow,
               border: Border.all(
                 color: active ? AppTheme.primaryBlue : const Color(0xFFE8EEFF),
               ),
             ),
             child: Icon(
               icon,
               color: active ? Colors.white : AppTheme.primaryBlue,
               size: 24,
             ),
           ),
           const SizedBox(height: 8),
           Text(
             label,
             style: GoogleFonts.inter(
               color: active ? AppTheme.primaryBlue : AppTheme.textLightGray,
               fontSize: 11,
               fontWeight: FontWeight.w700,
             ),
           ),
         ],
       ),
     );
   }

   Widget _buildProductCard(
     String title,
     String type,
     String rate,
     Color color,
     IconData icon,
     bool isSharia,
   ) {
     return Container(
       width: 240,
       margin: const EdgeInsets.only(right: 16),
       padding: const EdgeInsets.all(20),
       decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(20),
         border: Border.all(color: const Color(0xFFE8EEFF)),
         boxShadow: AppTheme.premiumShadow,
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                 padding: const EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   color: color.withOpacity(0.08),
                   shape: BoxShape.circle,
                 ),
                 child: Icon(
                   icon,
                   color: color,
                   size: 18,
                 ),
               ),
               if (isSharia)
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                   decoration: BoxDecoration(
                     color: AppTheme.shariaGreen.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(8),
                   ),
                   child: Text(
                     'SHARIA',
                     style: GoogleFonts.inter(
                       color: AppTheme.shariaGreen,
                       fontSize: 8,
                       fontWeight: FontWeight.w900,
                     ),
                   ),
                 ),
             ],
           ),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 title,
                 maxLines: 1,
                 overflow: TextOverflow.ellipsis,
                 style: GoogleFonts.inter(
                   color: AppTheme.textDark,
                   fontSize: 13,
                   fontWeight: FontWeight.w800,
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
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(
                 'Yield (1Y)',
                 style: GoogleFonts.inter(
                   color: AppTheme.textLightGray,
                   fontSize: 10,
                   fontWeight: FontWeight.w600,
                 ),
               ),
               Text(
                 rate,
                 style: GoogleFonts.inter(
                   color: AppTheme.shariaGreen,
                   fontSize: 14,
                   fontWeight: FontWeight.w900,
                 ),
               ),
             ],
           ),
         ],
       ),
     );
   }
}

// Custom painter to draw glowing investment curve line graph
class BezierCurvePainter extends CustomPainter {
   final List<double> dataPoints;
   final double progress;

   BezierCurvePainter({required this.dataPoints, required this.progress});

   @override
   void paint(Canvas canvas, Size size) {
     if (dataPoints.isEmpty) return;

     final double stepX = size.width / (dataPoints.length - 1);
     
     // Find min/max values to fit coordinates automatically
     double minVal = dataPoints.first;
     double maxVal = dataPoints.first;
     for (var val in dataPoints) {
       if (val < minVal) minVal = val;
       if (val > maxVal) maxVal = val;
     }

     final double range = maxVal - minVal == 0 ? 1 : maxVal - minVal;
     final List<Offset> points = [];

     for (int i = 0; i < dataPoints.length; i++) {
       final double x = i * stepX;
       // Fit height correctly with margin bottom/top
       final double normalizedY = (dataPoints[i] - minVal) / range;
       final double y = size.height - (normalizedY * (size.height - 30) + 15);
       points.add(Offset(x, y));
     }

     // Apply draw animation progress interpolation
     final List<Offset> animatedPoints = [];
     for (int i = 0; i < points.length; i++) {
       final double x = points[i].dx;
       // Interpolate Y value based on vertical progress animation
       final double y = size.height - ((size.height - points[i].dy) * progress);
       animatedPoints.add(Offset(x, y));
     }

     final Paint pathPaint = Paint()
       ..color = AppTheme.primaryBlue
       ..style = PaintingStyle.stroke
       ..strokeWidth = 3
       ..strokeCap = StrokeCap.round;

     final Paint fillPaint = Paint()
       ..style = PaintingStyle.fill
       ..shader = LinearGradient(
         colors: [
           AppTheme.primaryBlue.withOpacity(0.24),
           AppTheme.primaryBlue.withOpacity(0.00),
         ],
         begin: Alignment.topCenter,
         end: Alignment.bottomCenter,
       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

     final Path path = Path();
     path.moveTo(animatedPoints.first.dx, animatedPoints.first.dy);

     for (int i = 0; i < animatedPoints.length - 1; i++) {
       final Offset p1 = animatedPoints[i];
       final Offset p2 = animatedPoints[i + 1];
       final Offset control1 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p1.dy);
       final Offset control2 = Offset(p1.dx + (p2.dx - p1.dx) / 2, p2.dy);
       path.cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, p2.dx, p2.dy);
     }

     // Area filling path logic
     final Path fillPath = Path()..addPath(path, Offset.zero);
     fillPath.lineTo(size.width, size.height);
     fillPath.lineTo(0, size.height);
     fillPath.close();

     canvas.drawPath(fillPath, fillPaint);
     canvas.drawPath(path, pathPaint);

     // Draw little glowing points
     final Paint dotOutlinePaint = Paint()
       ..color = Colors.white
       ..style = PaintingStyle.fill;
     final Paint dotFillPaint = Paint()
       ..color = AppTheme.primaryBlue
       ..style = PaintingStyle.fill;

     // Highlight the last terminal point
     final Offset endPoint = animatedPoints.last;
     canvas.drawCircle(endPoint, 6, dotOutlinePaint);
     canvas.drawCircle(endPoint, 4, dotFillPaint);
   }

   @override
   bool shouldRepaint(covariant BezierCurvePainter oldDelegate) {
     return oldDelegate.dataPoints != dataPoints || oldDelegate.progress != progress;
   }
}
