import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulator/features/subscriptions/models/subscription.dart';
import 'package:simulator/features/subscriptions/bloc/subscription_event.dart';
import 'package:simulator/features/subscriptions/bloc/subscription_state.dart';

export 'subscription_event.dart';
export 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  SubscriptionBloc() : super(const SubscriptionState.loading()) {
    on<LoadSubscriptions>(_onLoadSubscriptions);
    on<CancelSubscription>(_onCancelSubscription);
  }

  void _onLoadSubscriptions(LoadSubscriptions event, Emitter<SubscriptionState> emit) {
    final mockSubs = [
      Subscription(
        id: 'sub_01',
        providerName: 'Netflix Premium',
        monthlyFee: 186000.00,
        nextBillingDate: DateTime.now().add(const Duration(days: 12)),
        isActive: true,
        logoAsset: 'netflix',
      ),
      Subscription(
        id: 'sub_02',
        providerName: 'Spotify Family',
        monthlyFee: 86900.00,
        nextBillingDate: DateTime.now().add(const Duration(days: 5)),
        isActive: true,
        logoAsset: 'spotify',
      ),
      Subscription(
        id: 'sub_03',
        providerName: 'YouTube Premium',
        monthlyFee: 59000.00,
        nextBillingDate: DateTime.now().add(const Duration(days: 18)),
        isActive: true,
        logoAsset: 'youtube',
      ),
      Subscription(
        id: 'sub_04',
        providerName: 'BPJS Kesehatan Mandiri',
        monthlyFee: 150000.00,
        nextBillingDate: DateTime.now().add(const Duration(days: 9)),
        isActive: true,
        logoAsset: 'bpjs',
        billingType: 'BPJS Auto-Debit',
      ),
    ];

    final total = mockSubs.fold<double>(0, (sum, sub) => sum + sub.monthlyFee);

    emit(SubscriptionState.loaded(
      subscriptions: mockSubs,
      totalCommitment: total,
    ));
  }

  void _onCancelSubscription(CancelSubscription event, Emitter<SubscriptionState> emit) {
    if (state case SubscriptionLoaded currentState) {
      final updatedList = currentState.subscriptions.map((sub) {
        if (sub.id == event.subscriptionId) {
          return sub.copyWith(isActive: false);
        }
        return sub;
      }).toList();

      final newTotal = updatedList
          .where((sub) => sub.isActive)
          .fold<double>(0, (sum, sumSub) => sum + sumSub.monthlyFee);

      emit(currentState.copyWith(
        subscriptions: updatedList,
        totalCommitment: newTotal,
      ));
    }
  }
}
