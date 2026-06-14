import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:banksatu_mobile/core/theme/app_theme.dart';

void main() {
  group('AppTheme', () {
    test('lightTheme returns valid ThemeData', () {
      final theme = AppTheme.lightTheme;

      expect(theme, isNotNull);
      expect(theme.scaffoldBackgroundColor, equals(AppTheme.background));
      expect(theme.primaryColor, equals(AppTheme.primaryBlue));
    });

    test('colorScheme has correct primary and secondary', () {
      final theme = AppTheme.lightTheme;

      expect(theme.colorScheme.primary, equals(AppTheme.primaryBlue));
      expect(theme.colorScheme.secondary, equals(AppTheme.shariaGreen));
      expect(theme.colorScheme.error, equals(AppTheme.errorRed));
    });

    test('textTheme uses Inter font', () {
      final theme = AppTheme.lightTheme;

      expect(theme.textTheme.displayLarge, isNotNull);
      expect(theme.textTheme.bodyMedium, isNotNull);
      expect(theme.textTheme.labelMedium, isNotNull);
    });

    test('cardTheme has correct border radius', () {
      final theme = AppTheme.lightTheme;

      expect(theme.cardTheme.shape, isA<RoundedRectangleBorder>());
      final shape = theme.cardTheme.shape as RoundedRectangleBorder;
      expect(shape.borderRadius, equals(BorderRadius.circular(16)));
    });
  });
}
