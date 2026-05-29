import 'package:freezed_annotation/freezed_annotation.dart';

part 'future_rails_event.freezed.dart';

@freezed
sealed class FutureRailsEvent with _$FutureRailsEvent {
  const factory FutureRailsEvent.loadFutureRails() = LoadFutureRails;
  const factory FutureRailsEvent.mintCbdcTokens(double amount) = MintCbdcTokens;
  const factory FutureRailsEvent.backupCustodyKeys() = BackupCustodyKeys;
  const factory FutureRailsEvent.spendBansosAid({
    required double amount,
    required String category,
  }) = SpendBansosAid;
  const factory FutureRailsEvent.resetTransactionState() = ResetTransactionState;
}
