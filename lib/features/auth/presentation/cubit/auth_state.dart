part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class AuthSignedOut extends AuthState {}

class AuthPasswordVisibility extends AuthState {
  final bool isVisible;

  AuthPasswordVisibility(this.isVisible);
}
