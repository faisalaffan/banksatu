// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_rails_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FutureRailsData _$FutureRailsDataFromJson(Map<String, dynamic> json) =>
    _FutureRailsData(
      cbdcBalance: (json['cbdcBalance'] as num).toDouble(),
      cryptoAssets: (json['cryptoAssets'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      isSecureCustodyBackupDone: json['isSecureCustodyBackupDone'] as bool,
      bansosBalance: (json['bansosBalance'] as num).toDouble(),
      bansosLockedCategory: json['bansosLockedCategory'] as String,
      bansosLockEnabled: json['bansosLockEnabled'] as bool? ?? true,
      educationBalance: (json['educationBalance'] as num?)?.toDouble() ?? 0.0,
      educationLockedCategory:
          json['educationLockedCategory'] as String? ??
          "Biaya Sekolah / Kuliah",
    );

Map<String, dynamic> _$FutureRailsDataToJson(_FutureRailsData instance) =>
    <String, dynamic>{
      'cbdcBalance': instance.cbdcBalance,
      'cryptoAssets': instance.cryptoAssets,
      'isSecureCustodyBackupDone': instance.isSecureCustodyBackupDone,
      'bansosBalance': instance.bansosBalance,
      'bansosLockedCategory': instance.bansosLockedCategory,
      'bansosLockEnabled': instance.bansosLockEnabled,
      'educationBalance': instance.educationBalance,
      'educationLockedCategory': instance.educationLockedCategory,
    };
