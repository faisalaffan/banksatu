import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_settings.freezed.dart';
part 'security_settings.g.dart';

@freezed
abstract class SecuritySettings with _$SecuritySettings {
  const factory SecuritySettings({
    required bool cardFrozen,
    required bool onlinePaymentLocked,
    required bool internationalLocked,
    required double dailySpendingLimit,
    required double currentSpending,
    required bool passkeyEnabled,
    @Default([]) List<String> lockedMerchantCategories, // spending lock per category (MCC filter)
  }) = _SecuritySettings;

  factory SecuritySettings.fromJson(Map<String, dynamic> json) =>
      _$SecuritySettingsFromJson(json);
}
