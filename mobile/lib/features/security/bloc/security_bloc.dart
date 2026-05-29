import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulator/features/security/models/security_settings.dart';

// Events
abstract class SecurityEvent {}

class LoadSecurity extends SecurityEvent {}

class ToggleCardFreeze extends SecurityEvent {}

class ToggleOnlinePayment extends SecurityEvent {}

class ToggleInternational extends SecurityEvent {}

class UpdateSpendingLimit extends SecurityEvent {
  final double newLimit;
  UpdateSpendingLimit(this.newLimit);
}

class TogglePasskey extends SecurityEvent {}

class ToggleCategoryLock extends SecurityEvent {
  final String category;
  ToggleCategoryLock(this.category);
}

// States
abstract class SecurityState {}

class SecurityLoading extends SecurityState {}

class SecurityLoaded extends SecurityState {
  final SecuritySettings settings;
  SecurityLoaded(this.settings);
}

// Bloc
class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(SecurityLoading()) {
    on<LoadSecurity>(_onLoadSecurity);
    on<ToggleCardFreeze>(_onToggleCardFreeze);
    on<ToggleOnlinePayment>(_onToggleOnlinePayment);
    on<ToggleInternational>(_onToggleInternational);
    on<UpdateSpendingLimit>(_onUpdateSpendingLimit);
    on<TogglePasskey>(_onTogglePasskey);
    on<ToggleCategoryLock>(_onToggleCategoryLock);
  }

  void _onLoadSecurity(LoadSecurity event, Emitter<SecurityState> emit) {
    emit(SecurityLoaded(
      const SecuritySettings(
        cardFrozen: false,
        onlinePaymentLocked: false,
        internationalLocked: true,
        dailySpendingLimit: 10000000.00, // Rp 10jt
        currentSpending: 425000.00,
        passkeyEnabled: true,
        lockedMerchantCategories: ['Entertainment', 'Gaming'],
      ),
    ));
  }

  void _onToggleCardFreeze(ToggleCardFreeze event, Emitter<SecurityState> emit) {
    if (state is SecurityLoaded) {
      final currentState = state as SecurityLoaded;
      emit(SecurityLoaded(
        currentState.settings.copyWith(
          cardFrozen: !currentState.settings.cardFrozen,
        ),
      ));
    }
  }

  void _onToggleOnlinePayment(ToggleOnlinePayment event, Emitter<SecurityState> emit) {
    if (state is SecurityLoaded) {
      final currentState = state as SecurityLoaded;
      emit(SecurityLoaded(
        currentState.settings.copyWith(
          onlinePaymentLocked: !currentState.settings.onlinePaymentLocked,
        ),
      ));
    }
  }

  void _onToggleInternational(ToggleInternational event, Emitter<SecurityState> emit) {
    if (state is SecurityLoaded) {
      final currentState = state as SecurityLoaded;
      emit(SecurityLoaded(
        currentState.settings.copyWith(
          internationalLocked: !currentState.settings.internationalLocked,
        ),
      ));
    }
  }

  void _onUpdateSpendingLimit(UpdateSpendingLimit event, Emitter<SecurityState> emit) {
    if (state is SecurityLoaded) {
      final currentState = state as SecurityLoaded;
      emit(SecurityLoaded(
        currentState.settings.copyWith(
          dailySpendingLimit: event.newLimit,
        ),
      ));
    }
  }

  void _onTogglePasskey(TogglePasskey event, Emitter<SecurityState> emit) {
    if (state is SecurityLoaded) {
      final currentState = state as SecurityLoaded;
      emit(SecurityLoaded(
        currentState.settings.copyWith(
          passkeyEnabled: !currentState.settings.passkeyEnabled,
        ),
      ));
    }
  }

  void _onToggleCategoryLock(ToggleCategoryLock event, Emitter<SecurityState> emit) {
    if (state is SecurityLoaded) {
      final currentState = state as SecurityLoaded;
      final currentList = List<String>.from(currentState.settings.lockedMerchantCategories);

      if (currentList.contains(event.category)) {
        currentList.remove(event.category);
      } else {
        currentList.add(event.category);
      }

      emit(SecurityLoaded(
        currentState.settings.copyWith(
          lockedMerchantCategories: currentList,
        ),
      ));
    }
  }
}
