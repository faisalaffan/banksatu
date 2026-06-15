import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_dto.freezed.dart';
part 'transaction_dto.g.dart';

@freezed
abstract class TransactionDto with _$TransactionDto {
  const factory TransactionDto({
    required String id,
    required String merchantName,
    required String originalAcquirerString,
    required double amount,
    required String category,
    required DateTime timestamp,
    required double latitude,
    required double longitude,
    required Map<String, double> feeBreakdown,
  }) = _TransactionDto;

  factory TransactionDto.fromJson(Map<String, dynamic> json) => _$TransactionDtoFromJson(json);
}
