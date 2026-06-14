part of 'accessibility_bloc.dart';

@immutable
abstract class AccessibilityState {
  const AccessibilityState();
}

class AccessibilityInitial extends AccessibilityState {
  const AccessibilityInitial();
}

class AccessibilityLoaded extends AccessibilityState {
  final bool isDarkMode;
  final String locale;

  const AccessibilityLoaded({
    required this.isDarkMode,
    required this.locale,
  });

  AccessibilityLoaded copyWith({bool? isDarkMode, String? locale}) {
    return AccessibilityLoaded(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      locale: locale ?? this.locale,
    );
  }
}
