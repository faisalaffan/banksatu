import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class SandboxBanner extends StatefulWidget {
  const SandboxBanner({super.key});

  @override
  State<SandboxBanner> createState() => _SandboxBannerState();
}

class _SandboxBannerState extends State<SandboxBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: false);

    _pulseAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Elegant Apple Orange (0xFFFF9500) and Apple Yellow (0xFFFFCC00)
    const orangeColor = Color(0xFFFF9500);
    const yellowColor = Color(0xFFFFCC00);

    return DefaultTextStyle(
      style: const TextStyle(decoration: TextDecoration.none),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Container(
            height: 28.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  yellowColor.withOpacity(0.08),
                  orangeColor.withOpacity(0.12),
                  yellowColor.withOpacity(0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border(
                bottom: BorderSide(
                  color: orangeColor.withOpacity(0.25),
                  width: 1.0,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pulsing Glowing Dot
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Animated Ripple Circle
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: 1.0 - _pulseAnimation.value,
                          child: Container(
                            width: 6.0 + (_pulseAnimation.value * 14.0),
                            height: 6.0 + (_pulseAnimation.value * 14.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: orangeColor.withOpacity(0.4),
                            ),
                          ),
                        );
                      },
                    ),
                    // Core Solid Dot
                    Container(
                      width: 6.0,
                      height: 6.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: orangeColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),

                // Sandbox Text
                Text(
                  'SANDBOX MODE',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFCC7A00),
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 1.5,
                  height: 10,
                  color: orangeColor.withOpacity(0.3),
                ),
                const SizedBox(width: 6),
                Text(
                  'Not a real banking service',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFE68A00),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
