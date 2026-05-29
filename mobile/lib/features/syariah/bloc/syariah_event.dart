import 'package:freezed_annotation/freezed_annotation.dart';

part 'syariah_event.freezed.dart';

@freezed
sealed class SyariahEvent with _$SyariahEvent {
  const factory SyariahEvent.loadSyariah() = LoadSyariah;
  const factory SyariahEvent.cleanseSyubhat() = CleanseSyubhat;
  const factory SyariahEvent.toggleZakatAutoDebit() = ToggleZakatAutoDebit;
  const factory SyariahEvent.signAkad(String akadName) = SignAkad;
  const factory SyariahEvent.payZakatNow(double amount) = PayZakatNow;
}
