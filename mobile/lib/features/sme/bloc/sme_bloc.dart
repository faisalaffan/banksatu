import 'package:flutter_bloc/flutter_bloc.dart';

part 'sme_event.dart';
part 'sme_state.dart';

class SmeBloc extends Bloc<SmeEvent, SmeState> {
  SmeBloc() : super(const SmeState.initial()) {
    on<LoadSme>(_onLoad);
  }

  void _onLoad(LoadSme event, Emitter<SmeState> emit) {
    emit(const SmeState.loaded());
  }
}
