import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulator/features/security/models/security_settings.dart';
import 'package:simulator/features/security/bloc/security_event.dart';
import 'package:simulator/features/security/bloc/security_state.dart';

export 'security_event.dart';
export 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc() : super(const SecurityState.loading()) {
    on<LoadSecurity>(_onLoadSecurity);
    on<ToggleCardFreeze>(_onToggleCardFreeze);
    on<ToggleOnlinePayment>(_onToggleOnlinePayment);
    on<ToggleInternational>(_onToggleInternational);
    on<UpdateSpendingLimit>(_onUpdateSpendingLimit);
    on<TogglePasskey>(_onTogglePasskey);
    on<ToggleCategoryLock>(_onToggleCategoryLock);
  }

  void _onLoadSecurity(LoadSecurity event, Emitter<SecurityState> emit) {
    emit(const SecurityState.loaded(
      SecuritySettings(
        cardFrozen: false,
        onlinePaymentLocked: false,
        internationalLocked: true,
        dailySpendingLimit: 10000000.00,
        currentSpending: 425000.00,
        passkeyEnabled: true,
        lockedMerchantCategories: ['Entertainment', 'Gaming'],
      ),
    ));
  }

  void _onToggleCardFreeze(ToggleCardFreeze event, Emitter<SecurityState> emit) {
    if (state case SecurityLoaded currentState) {
      emit(SecurityState.loaded(
        currentState.settings.copyWith(
          cardFrozen: !currentState.settings.cardFrozen,
        ),
      ));
    }
  }

  void _onToggleOnlinePayment(ToggleOnlinePayment event, Emitter<SecurityState> emit) {
    if (state case SecurityLoaded currentState) {
      emit(SecurityState.loaded(
        currentState.settings.copyWith(
          onlinePaymentLocked: !currentState.settings.onlinePaymentLocked,
        ),
      ));
    }
  }

  void _onToggleInternational(ToggleInternational event, Emitter<SecurityState> emit) {
    if (state case SecurityLoaded currentState) {
      emit(SecurityState.loaded(
        currentState.settings.copyWith(
          internationalLocked: !currentState.settings.internationalLocked,
        ),
      ));
    }
  }

  void _onUpdateSpendingLimit(UpdateSpendingLimit event, Emitter<SecurityState> emit) {
    if (state case SecurityLoaded currentState) {
      emit(SecurityState.loaded(
        currentState.settings.copyWith(
          dailySpendingLimit: event.newLimit,
        ),
      ));
    }
  }

  void _onTogglePasskey(TogglePasskey event, Emitter<SecurityState> emit) {
    if (state case SecurityLoaded currentState) {
      emit(SecurityState.loaded(
        currentState.settings.copyWith(
          passkeyEnabled: !currentState.settings.passkeyEnabled,
        ),
      ));
    }
  }

  void _onToggleCategoryLock(ToggleCategoryLock event, Emitter<SecurityState> emit) {
    if (state case SecurityLoaded currentState) {
      final currentList = List<String>.from(currentState.settings.lockedMerchantCategories);

      if (currentList.contains(event.category)) {
        currentList.remove(event.category);
      } else {
        currentList.add(event.category);
      }

      emit(SecurityState.loaded(
        currentState.settings.copyWith(
          lockedMerchantCategories: currentList,
        ),
      ));
    }
  }
}
