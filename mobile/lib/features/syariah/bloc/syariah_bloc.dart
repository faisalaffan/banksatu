import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulator/features/syariah/models/syariah_state_data.dart';

// Events
abstract class SyariahEvent {}

class LoadSyariah extends SyariahEvent {}

class CleanseSyubhat extends SyariahEvent {}

class ToggleZakatAutoDebit extends SyariahEvent {}

class SignAkad extends SyariahEvent {
  final String akadName;
  SignAkad(this.akadName);
}

class PayZakatNow extends SyariahEvent {
  final double amount;
  PayZakatNow(this.amount);
}

// States
abstract class SyariahState {}

class SyariahLoading extends SyariahState {}

class SyariahLoaded extends SyariahState {
  final SyariahStateData data;
  SyariahLoaded(this.data);
}

// Bloc
class SyariahBloc extends Bloc<SyariahEvent, SyariahState> {
  SyariahBloc() : super(SyariahLoading()) {
    on<LoadSyariah>(_onLoadSyariah);
    on<CleanseSyubhat>(_onCleanseSyubhat);
    on<ToggleZakatAutoDebit>(_onToggleZakatAutoDebit);
    on<SignAkad>(_onSignAkad);
    on<PayZakatNow>(_onPayZakatNow);
  }

  void _onLoadSyariah(LoadSyariah event, Emitter<SyariahState> emit) {
    emit(SyariahLoaded(
      const SyariahStateData(
        halalBalance: 23750000.00, // Saldo Halal
        syubhatBalance: 387500.00, // Saldo Syubhat (reward/bunga/discount)
        zakatDue: 593750.00,       // 2.5% of total wealth
        isAkadSigned: false,
        selectedAkad: 'Belum Terpilih',
        availableAkads: [
          'Mudharabah Mutlaqah (Tabungan)',
          'Wadiah Yad Dhamanah (Giro)',
          'Murabahah (Pembiayaan Cicilan)',
        ],
        zakatAutoDebitEnabled: false,
      ),
    ));
  }

  void _onCleanseSyubhat(CleanseSyubhat event, Emitter<SyariahState> emit) {
    if (state is SyariahLoaded) {
      final currentState = state as SyariahLoaded;
      emit(SyariahLoaded(
        currentState.data.copyWith(
          // Syubhat balance successfully cleansed (moved into Zakat/Charity)
          syubhatBalance: 0.00,
        ),
      ));
    }
  }

  void _onToggleZakatAutoDebit(ToggleZakatAutoDebit event, Emitter<SyariahState> emit) {
    if (state is SyariahLoaded) {
      final currentState = state as SyariahLoaded;
      emit(SyariahLoaded(
        currentState.data.copyWith(
          zakatAutoDebitEnabled: !currentState.data.zakatAutoDebitEnabled,
        ),
      ));
    }
  }

  void _onSignAkad(SignAkad event, Emitter<SyariahState> emit) {
    if (state is SyariahLoaded) {
      final currentState = state as SyariahLoaded;
      emit(SyariahLoaded(
        currentState.data.copyWith(
          isAkadSigned: true,
          selectedAkad: event.akadName,
        ),
      ));
    }
  }

  void _onPayZakatNow(PayZakatNow event, Emitter<SyariahState> emit) {
    if (state is SyariahLoaded) {
      final currentState = state as SyariahLoaded;
      final remainingZakat = currentState.data.zakatDue - event.amount;
      emit(SyariahLoaded(
        currentState.data.copyWith(
          halalBalance: currentState.data.halalBalance - event.amount,
          zakatDue: remainingZakat < 0 ? 0.00 : remainingZakat,
        ),
      ));
    }
  }
}
