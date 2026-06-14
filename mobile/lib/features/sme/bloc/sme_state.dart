part of 'sme_bloc.dart';

@immutable
sealed class SmeState {
  const SmeState();
}

class SmeInitial extends SmeState {
  const SmeInitial();
}

class SmeLoaded extends SmeState {
  const SmeLoaded();
}
