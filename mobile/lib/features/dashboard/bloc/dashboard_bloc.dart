import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:banksatu_mobile/core/error/failures.dart';
import 'package:banksatu_mobile/data/repositories/transaction_repository_impl.dart';
import 'package:banksatu_mobile/features/dashboard/models/transaction.dart';
import 'package:banksatu_mobile/features/dashboard/bloc/dashboard_event.dart';
import 'package:banksatu_mobile/features/dashboard/bloc/dashboard_state.dart';

export 'dashboard_event.dart';
export 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final TransactionRepository _repository;

  DashboardBloc({required TransactionRepository repository})
      : _repository = repository,
        super(const DashboardState.loading()) {
    on<LoadDashboard>(_onLoadDashboard);
    on<SearchTransactions>(_onSearchTransactions);
  }

  Future<void> _onLoadDashboard(
    LoadDashboard event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardState.loading());

    final (failure, dtos) = await _repository.getTransactions();

    if (failure != null) {
      emit(DashboardState.error(message: failure.message));
      return;
    }

    final transactions = dtos!.map((dto) => Transaction.fromDto(dto)).toList();

    emit(DashboardState.loaded(
      balance: 24137500.00,
      transactions: transactions,
      filteredTransactions: transactions,
      searchQuery: '',
    ));
  }

  void _onSearchTransactions(
    SearchTransactions event,
    Emitter<DashboardState> emit,
  ) {
    if (state case DashboardLoaded currentState) {
      final query = event.query.toLowerCase();

      if (query.isEmpty) {
        emit(currentState.copyWith(
          filteredTransactions: currentState.transactions,
          searchQuery: '',
        ));
      } else {
        final filtered = currentState.transactions.where((tx) {
          final nameMatch = tx.merchantName.toLowerCase().contains(query);
          final catMatch = tx.category.toLowerCase().contains(query);
          final acqMatch =
              tx.originalAcquirerString.toLowerCase().contains(query);
          return nameMatch || catMatch || acqMatch;
        }).toList();

        emit(currentState.copyWith(
          filteredTransactions: filtered,
          searchQuery: event.query,
        ));
      }
    }
  }
}
