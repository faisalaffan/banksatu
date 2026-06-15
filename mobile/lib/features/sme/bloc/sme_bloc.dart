import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sme_event.dart';
part 'sme_state.dart';

class SmeBloc extends Bloc<SmeEvent, SmeState> {
  SmeBloc() : super(const SmeInitial()) {
    on<LoadSme>(_onLoad);
  }

  void _onLoad(LoadSme event, Emitter<SmeState> emit) {
    emit(const SmeLoaded());
  }
}
