import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState.initial()) {
    on<LoadProfile>(_onLoad);
  }

  void _onLoad(LoadProfile event, Emitter<ProfileState> emit) {
    emit(const ProfileState.loaded());
  }
}
