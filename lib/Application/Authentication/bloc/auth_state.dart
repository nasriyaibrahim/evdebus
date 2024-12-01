// auth_state.dart
part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;

  Authenticated(this.user);
}

class AuthenticateError extends AuthState {
  final String message;

  AuthenticateError(this.message);  // This is where you pass the message
}

class Unauthenticated extends AuthState {}
