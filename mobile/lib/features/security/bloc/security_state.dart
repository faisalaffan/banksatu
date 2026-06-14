import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:banksatu_mobile/features/security/models/security_settings.dart';

part 'security_state.freezed.dart';

@freezed
sealed class SecurityState with _$SecurityState {
  const factory SecurityState.loading() = SecurityLoading;
  const factory SecurityState.loaded(SecuritySettings settings) = SecurityLoaded;
}
