import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

class CustomBottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const CustomBottomNav({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        children: [
          Expanded(child: navigationShell),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              border: const Border(
                top: BorderSide(color: Color(0xFFE8EEFF), width: 0.5),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      icon: CupertinoIcons.square_grid_2x2,
                      activeIcon: CupertinoIcons.square_grid_2x2_fill,
                      label: 'Home',
                      isSelected: navigationShell.currentIndex == 0,
                      onTap: () => navigationShell.goBranch(0),
                    ),
                    _NavItem(
                      icon: CupertinoIcons.shield,
                      activeIcon: CupertinoIcons.shield_fill,
                      label: 'Security',
                      isSelected: navigationShell.currentIndex == 1,
                      onTap: () => navigationShell.goBranch(1),
                    ),
                    _NavItem(
                      icon: CupertinoIcons.arrow_2_circlepath,
                      activeIcon: CupertinoIcons.arrow_2_circlepath,
                      label: 'AutoDebit',
                      isSelected: navigationShell.currentIndex == 2,
                      onTap: () => navigationShell.goBranch(2),
                    ),
                    _NavItem(
                      icon: CupertinoIcons.checkmark_seal,
                      activeIcon: CupertinoIcons.checkmark_seal_fill,
                      label: 'Syariah',
                      isSelected: navigationShell.currentIndex == 3,
                      onTap: () => navigationShell.goBranch(3),
                    ),
                    _NavItem(
                      icon: CupertinoIcons.bolt,
                      activeIcon: CupertinoIcons.bolt_fill,
                      label: 'Future',
                      isSelected: navigationShell.currentIndex == 4,
                      onTap: () => navigationShell.goBranch(4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppTheme.primaryBlue : AppTheme.textLightGray;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue.withAlpha(20) : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(isSelected ? activeIcon : icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
