import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
abstract class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String merchantName,
    required String originalAcquirerString,
    required double amount,
    required String category,
    required DateTime timestamp,
    required double latitude,
    required double longitude,
    required Map<String, double> feeBreakdown,
    @Default(true) bool isSuccess,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
