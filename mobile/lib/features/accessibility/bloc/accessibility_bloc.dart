import 'package:flutter_bloc/flutter_bloc.dart';

part 'accessibility_event.dart';
part 'accessibility_state.dart';

class AccessibilityBloc extends Bloc<AccessibilityEvent, AccessibilityState> {
  AccessibilityBloc() : super(const AccessibilityState.initial()) {
    on<LoadAccessibility>(_onLoad);
    on<ToggleDarkMode>(_onToggleDarkMode);
    on<ChangeLanguage>(_onChangeLanguage);
  }

  void _onLoad(LoadAccessibility event, Emitter<AccessibilityState> emit) {
    emit(const AccessibilityState.loaded(isDarkMode: false, locale: 'id'));
  }

  void _onToggleDarkMode(ToggleDarkMode event, Emitter<AccessibilityState> emit) {
    if (state is AccessibilityLoaded) {
      final current = state as AccessibilityLoaded;
      emit(current.copyWith(isDarkMode: !current.isDarkMode));
    }
  }

  void _onChangeLanguage(ChangeLanguage event, Emitter<AccessibilityState> emit) {
    if (state is AccessibilityLoaded) {
      final current = state as AccessibilityLoaded;
      emit(current.copyWith(locale: event.locale));
    }
  }
}
