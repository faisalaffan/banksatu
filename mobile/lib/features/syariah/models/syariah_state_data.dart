import 'package:freezed_annotation/freezed_annotation.dart';

part 'syariah_state_data.freezed.dart';
part 'syariah_state_data.g.dart';

@freezed
abstract class SyariahStateData with _$SyariahStateData {
  const factory SyariahStateData({
    required double halalBalance,
    required double syubhatBalance,
    required double zakatDue,
    required bool isAkadSigned,
    required String selectedAkad,
    @Default([]) List<String> availableAkads,
    @Default(false) bool zakatAutoDebitEnabled,
  }) = _SyariahStateData;

  factory SyariahStateData.fromJson(Map<String, dynamic> json) =>
      _$SyariahStateDataFromJson(json);
}
