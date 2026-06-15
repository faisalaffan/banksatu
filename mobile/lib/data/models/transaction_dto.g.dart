// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionDto _$TransactionDtoFromJson(Map<String, dynamic> json) =>
    _TransactionDto(
      id: json['id'] as String,
      merchantName: json['merchantName'] as String,
      originalAcquirerString: json['originalAcquirerString'] as String,
      amount: (json['amount'] as num).toDouble(),
      category: json['category'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      feeBreakdown: (json['feeBreakdown'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$TransactionDtoToJson(_TransactionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'merchantName': instance.merchantName,
      'originalAcquirerString': instance.originalAcquirerString,
      'amount': instance.amount,
      'category': instance.category,
      'timestamp': instance.timestamp.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'feeBreakdown': instance.feeBreakdown,
    };
