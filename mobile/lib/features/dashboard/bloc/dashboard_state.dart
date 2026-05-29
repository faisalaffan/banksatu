import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simulator/features/dashboard/models/transaction.dart';

part 'dashboard_state.freezed.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState.loading() = DashboardLoading;
  const factory DashboardState.loaded({
    required double balance,
    required List<Transaction> transactions,
    required List<Transaction> filteredTransactions,
    required String searchQuery,
  }) = DashboardLoaded;
}
