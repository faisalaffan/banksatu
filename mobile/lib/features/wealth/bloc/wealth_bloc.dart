import 'package:flutter_bloc/flutter_bloc.dart';

part 'wealth_event.dart';
part 'wealth_state.dart';

class WealthBloc extends Bloc<WealthEvent, WealthState> {
  WealthBloc() : super(const WealthState.initial()) {
    on<LoadWealth>(_onLoad);
  }

  void _onLoad(LoadWealth event, Emitter<WealthState> emit) {
    emit(const WealthState.loaded());
  }
}
