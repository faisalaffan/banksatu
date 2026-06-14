import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<LoginRequested>(_onLogin);
    on<LogoutRequested>(_onLogout);
  }

  void _onLogin(LoginRequested event, Emitter<AuthState> emit) {
    emit(const AuthState.loading());
    // TODO: implementasi login real via repository
    emit(const AuthState.authenticated(userName: 'Faisal Affan'));
  }

  void _onLogout(LogoutRequested event, Emitter<AuthState> emit) {
    emit(const AuthState.unauthenticated());
  }
}
