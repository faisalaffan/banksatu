import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulator/features/syariah/models/syariah_state_data.dart';
import 'package:simulator/features/syariah/bloc/syariah_event.dart';
import 'package:simulator/features/syariah/bloc/syariah_state.dart';

export 'syariah_event.dart';
export 'syariah_state.dart';

class SyariahBloc extends Bloc<SyariahEvent, SyariahState> {
  SyariahBloc() : super(const SyariahState.loading()) {
    on<LoadSyariah>(_onLoadSyariah);
    on<CleanseSyubhat>(_onCleanseSyubhat);
    on<ToggleZakatAutoDebit>(_onToggleZakatAutoDebit);
    on<SignAkad>(_onSignAkad);
    on<PayZakatNow>(_onPayZakatNow);
  }

  void _onLoadSyariah(LoadSyariah event, Emitter<SyariahState> emit) {
    emit(const SyariahState.loaded(
      SyariahStateData(
        halalBalance: 23750000.00,
        syubhatBalance: 387500.00,
        zakatDue: 593750.00,
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
    if (state case SyariahLoaded currentState) {
      emit(SyariahState.loaded(
        currentState.data.copyWith(
          syubhatBalance: 0.00,
        ),
      ));
    }
  }

  void _onToggleZakatAutoDebit(ToggleZakatAutoDebit event, Emitter<SyariahState> emit) {
    if (state case SyariahLoaded currentState) {
      emit(SyariahState.loaded(
        currentState.data.copyWith(
          zakatAutoDebitEnabled: !currentState.data.zakatAutoDebitEnabled,
        ),
      ));
    }
  }

  void _onSignAkad(SignAkad event, Emitter<SyariahState> emit) {
    if (state case SyariahLoaded currentState) {
      emit(SyariahState.loaded(
        currentState.data.copyWith(
          isAkadSigned: true,
          selectedAkad: event.akadName,
        ),
      ));
    }
  }

  void _onPayZakatNow(PayZakatNow event, Emitter<SyariahState> emit) {
    if (state case SyariahLoaded currentState) {
      final remainingZakat = currentState.data.zakatDue - event.amount;
      emit(SyariahState.loaded(
        currentState.data.copyWith(
          halalBalance: currentState.data.halalBalance - event.amount,
          zakatDue: remainingZakat < 0 ? 0.00 : remainingZakat,
        ),
      ));
    }
  }
}
