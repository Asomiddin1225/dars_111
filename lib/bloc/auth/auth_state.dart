part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class InitialAuthState extends AuthState {}

final class LoadingAuthState extends AuthState {}

final class AuthenticatedAuthState extends AuthState {
  final User user;
  AuthenticatedAuthState({required this.user});
}

final class UnAuthenticatedAuthState extends AuthState {}

final class ErrorAuthState extends AuthState {
  final String message;

  ErrorAuthState(this.message);
}