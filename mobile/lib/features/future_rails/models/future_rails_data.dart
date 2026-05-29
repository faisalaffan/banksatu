import 'package:freezed_annotation/freezed_annotation.dart';

part 'future_rails_data.freezed.dart';
part 'future_rails_data.g.dart';

@freezed
abstract class FutureRailsData with _$FutureRailsData {
  const factory FutureRailsData({
    required double cbdcBalance,
    required Map<String, double> cryptoAssets,
    required bool isSecureCustodyBackupDone,
    required double bansosBalance,
    required String bansosLockedCategory,
    @Default(true) bool bansosLockEnabled,
    @Default(0.0) double educationBalance,
    @Default("Biaya Sekolah / Kuliah") String educationLockedCategory,
  }) = _FutureRailsData;

  factory FutureRailsData.fromJson(Map<String, dynamic> json) =>
      _$FutureRailsDataFromJson(json);
}
