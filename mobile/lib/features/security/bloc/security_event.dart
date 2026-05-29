import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_event.freezed.dart';

@freezed
sealed class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent.loadSecurity() = LoadSecurity;
  const factory SecurityEvent.toggleCardFreeze() = ToggleCardFreeze;
  const factory SecurityEvent.toggleOnlinePayment() = ToggleOnlinePayment;
  const factory SecurityEvent.toggleInternational() = ToggleInternational;
  const factory SecurityEvent.updateSpendingLimit(double newLimit) = UpdateSpendingLimit;
  const factory SecurityEvent.togglePasskey() = TogglePasskey;
  const factory SecurityEvent.toggleCategoryLock(String category) = ToggleCategoryLock;
}
