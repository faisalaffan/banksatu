import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simulator/features/subscriptions/models/subscription.dart';

part 'subscription_state.freezed.dart';

@freezed
sealed class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.loading() = SubscriptionLoading;
  const factory SubscriptionState.loaded({
    required List<Subscription> subscriptions,
    required double totalCommitment,
  }) = SubscriptionLoaded;
}
