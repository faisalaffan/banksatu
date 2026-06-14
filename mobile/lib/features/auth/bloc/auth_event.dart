part of 'auth_bloc.dart';

sealed class AuthEvent {}

class LoginRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}
