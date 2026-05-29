// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Transaction _$TransactionFromJson(Map<String, dynamic> json) => _Transaction(
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
  isSuccess: json['isSuccess'] as bool? ?? true,
);

Map<String, dynamic> _$TransactionToJson(_Transaction instance) =>
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
      'isSuccess': instance.isSuccess,
    };
