import 'package:flutter/cupertino.dart';

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

    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const orangeColor = Color(0xFFFF9500);
    const yellowColor = Color(0xFFFFCC00);

    return Container(
      height: 28,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0x14FFCC00), Color(0x1EFF9500), Color(0x14FFCC00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border(
          bottom: BorderSide(color: Color(0x40FF9500), width: 1),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: 1.0 - _pulseAnimation.value,
                    child: Container(
                      width: 6.0 + (_pulseAnimation.value * 14),
                      height: 6.0 + (_pulseAnimation.value * 14),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: orangeColor.withAlpha(102),
                      ),
                    ),
                  );
                },
              ),
              const CircleAvatar(
                radius: 3,
                backgroundColor: orangeColor,
              ),
            ],
          ),
          const SizedBox(width: 8),
          const Text(
            'SANDBOX MODE',
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFFCC7A00),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(width: 6),
          Container(width: 1.5, height: 10, color: orangeColor.withAlpha(77)),
          const SizedBox(width: 6),
          const Text(
            'Not a real banking service',
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE68A00),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
