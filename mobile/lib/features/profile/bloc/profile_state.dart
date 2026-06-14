part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded();
}
