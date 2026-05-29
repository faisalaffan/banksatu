import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simulator/features/syariah/models/syariah_state_data.dart';

part 'syariah_state.freezed.dart';

@freezed
sealed class SyariahState with _$SyariahState {
  const factory SyariahState.loading() = SyariahLoading;
  const factory SyariahState.loaded(SyariahStateData data) = SyariahLoaded;
}
