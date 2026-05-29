import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_event.freezed.dart';

@freezed
sealed class SubscriptionEvent with _$SubscriptionEvent {
  const factory SubscriptionEvent.loadSubscriptions() = LoadSubscriptions;
  const factory SubscriptionEvent.cancelSubscription(String subscriptionId) = CancelSubscription;
}
