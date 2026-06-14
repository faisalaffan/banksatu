import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNav({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey<String>('CustomBottomNav'));

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          // Floating Frosted Glass Navigation Bar
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceCard.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFE8EEFF).withOpacity(0.5),
                      width: 1.5,
                    ),
                    boxShadow: AppTheme.floatingShadow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        context,
                        index: 0,
                        icon: CupertinoIcons.square_grid_2x2,
                        activeIcon: CupertinoIcons.square_grid_2x2_fill,
                        label: 'Home',
                      ),
                      _buildNavItem(
                        context,
                        index: 1,
                        icon: CupertinoIcons.shield,
                        activeIcon: CupertinoIcons.shield_fill,
                        label: 'Security',
                      ),
                      _buildNavItem(
                        context,
                        index: 2,
                        icon: CupertinoIcons.arrow_2_circlepath,
                        activeIcon: CupertinoIcons.arrow_2_circlepath,
                        label: 'AutoDebit',
                      ),
                      _buildNavItem(
                        context,
                        index: 3,
                        icon: CupertinoIcons.checkmark_seal,
                        activeIcon: CupertinoIcons.checkmark_seal_fill,
                        label: 'Syariah',
                        color: AppTheme.shariaGreen,
                      ),
                      _buildNavItem(
                        context,
                        index: 4,
                        icon: CupertinoIcons.bolt,
                        activeIcon: CupertinoIcons.bolt_fill,
                        label: 'Future',
                        color: Colors.teal,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    Color? color,
  }) {
    final isSelected = index == navigationShell.currentIndex;
    final themeColor = color ?? AppTheme.primaryBlue;

    return GestureDetector(
      onTap: () => _onTap(context, index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? themeColor.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? themeColor : AppTheme.textLightGray,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? themeColor : AppTheme.textLightGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
