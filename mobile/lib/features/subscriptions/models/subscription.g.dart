// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subscription _$SubscriptionFromJson(Map<String, dynamic> json) =>
    _Subscription(
      id: json['id'] as String,
      providerName: json['providerName'] as String,
      monthlyFee: (json['monthlyFee'] as num).toDouble(),
      nextBillingDate: DateTime.parse(json['nextBillingDate'] as String),
      isActive: json['isActive'] as bool,
      logoAsset: json['logoAsset'] as String,
      billingType: json['billingType'] as String? ?? 'Auto-Debit',
    );

Map<String, dynamic> _$SubscriptionToJson(_Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'providerName': instance.providerName,
      'monthlyFee': instance.monthlyFee,
      'nextBillingDate': instance.nextBillingDate.toIso8601String(),
      'isActive': instance.isActive,
      'logoAsset': instance.logoAsset,
      'billingType': instance.billingType,
    };
