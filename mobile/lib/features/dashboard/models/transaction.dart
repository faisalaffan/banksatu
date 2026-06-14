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

  factory Transaction.fromDto(dynamic dto) {
    return Transaction(
      id: dto.id as String,
      merchantName: dto.merchantName as String,
      originalAcquirerString: dto.originalAcquirerString as String,
      amount: (dto.amount as num).toDouble(),
      category: dto.category as String,
      timestamp: dto.timestamp as DateTime,
      latitude: (dto.latitude as num).toDouble(),
      longitude: (dto.longitude as num).toDouble(),
      feeBreakdown: Map<String, double>.from(
        (dto.feeBreakdown as Map).map(
          (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
        ),
      ),
    );
  }
}
