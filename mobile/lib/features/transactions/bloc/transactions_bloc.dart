import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(const TransactionsInitial()) {
    on<LoadTransactions>(_onLoad);
  }

  void _onLoad(LoadTransactions event, Emitter<TransactionsState> emit) {
    emit(const TransactionsLoaded());
  }
}
