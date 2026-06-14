part of 'wealth_bloc.dart';

@immutable
sealed class WealthState {
  const WealthState();
}

class WealthInitial extends WealthState {
  const WealthInitial();
}

class WealthLoaded extends WealthState {
  const WealthLoaded();
}
