import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

@freezed
abstract class Subscription with _$Subscription {
  const factory Subscription({
    required String id,
    required String providerName,
    required double monthlyFee,
    required DateTime nextBillingDate,
    required bool isActive,
    required String logoAsset,
    @Default('Auto-Debit') String billingType,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);
}
