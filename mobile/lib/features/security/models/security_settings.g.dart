// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SecuritySettings _$SecuritySettingsFromJson(Map<String, dynamic> json) =>
    _SecuritySettings(
      cardFrozen: json['cardFrozen'] as bool,
      onlinePaymentLocked: json['onlinePaymentLocked'] as bool,
      internationalLocked: json['internationalLocked'] as bool,
      dailySpendingLimit: (json['dailySpendingLimit'] as num).toDouble(),
      currentSpending: (json['currentSpending'] as num).toDouble(),
      passkeyEnabled: json['passkeyEnabled'] as bool,
      lockedMerchantCategories:
          (json['lockedMerchantCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SecuritySettingsToJson(_SecuritySettings instance) =>
    <String, dynamic>{
      'cardFrozen': instance.cardFrozen,
      'onlinePaymentLocked': instance.onlinePaymentLocked,
      'internationalLocked': instance.internationalLocked,
      'dailySpendingLimit': instance.dailySpendingLimit,
      'currentSpending': instance.currentSpending,
      'passkeyEnabled': instance.passkeyEnabled,
      'lockedMerchantCategories': instance.lockedMerchantCategories,
    };
