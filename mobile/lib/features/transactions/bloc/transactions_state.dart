part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {
  const TransactionsState();
}

class TransactionsInitial extends TransactionsState {
  const TransactionsInitial();
}

class TransactionsLoaded extends TransactionsState {
  const TransactionsLoaded();
}
