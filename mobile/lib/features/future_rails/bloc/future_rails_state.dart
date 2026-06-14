import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:banksatu_mobile/features/future_rails/models/future_rails_data.dart';

part 'future_rails_state.freezed.dart';

@freezed
sealed class FutureRailsState with _$FutureRailsState {
  const factory FutureRailsState.loading() = FutureRailsLoading;
  const factory FutureRailsState.loaded({
    required FutureRailsData data,
    String? transactionStatusMessage,
    @Default(true) bool isTransactionSuccessful,
  }) = FutureRailsLoaded;
}
