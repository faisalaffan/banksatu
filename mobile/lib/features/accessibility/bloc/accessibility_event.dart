part of 'accessibility_bloc.dart';

sealed class AccessibilityEvent {
  const AccessibilityEvent();
}

class LoadAccessibility extends AccessibilityEvent {}

class ToggleDarkMode extends AccessibilityEvent {}

class ChangeLanguage extends AccessibilityEvent {
  final String locale;
  const ChangeLanguage({required this.locale});
}
