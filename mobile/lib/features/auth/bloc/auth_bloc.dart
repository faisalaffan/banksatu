import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<LogoutRequested>(_onLogout);
  }

  void _onLogin(LoginRequested event, Emitter<AuthState> emit) {
    emit(const AuthLoading());
    // TODO: implementasi login real via repository
    emit(const AuthAuthenticated(userName: 'Faisal Affan'));
  }

  void _onLogout(LogoutRequested event, Emitter<AuthState> emit) {
    emit(const AuthUnauthenticated());
  }
}
