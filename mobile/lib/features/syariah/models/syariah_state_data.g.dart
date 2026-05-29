// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'syariah_state_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SyariahStateData _$SyariahStateDataFromJson(Map<String, dynamic> json) =>
    _SyariahStateData(
      halalBalance: (json['halalBalance'] as num).toDouble(),
      syubhatBalance: (json['syubhatBalance'] as num).toDouble(),
      zakatDue: (json['zakatDue'] as num).toDouble(),
      isAkadSigned: json['isAkadSigned'] as bool,
      selectedAkad: json['selectedAkad'] as String,
      availableAkads:
          (json['availableAkads'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      zakatAutoDebitEnabled: json['zakatAutoDebitEnabled'] as bool? ?? false,
    );

Map<String, dynamic> _$SyariahStateDataToJson(_SyariahStateData instance) =>
    <String, dynamic>{
      'halalBalance': instance.halalBalance,
      'syubhatBalance': instance.syubhatBalance,
      'zakatDue': instance.zakatDue,
      'isAkadSigned': instance.isAkadSigned,
      'selectedAkad': instance.selectedAkad,
      'availableAkads': instance.availableAkads,
      'zakatAutoDebitEnabled': instance.zakatAutoDebitEnabled,
    };
