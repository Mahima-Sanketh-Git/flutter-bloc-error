part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class UserAuthenticationEvent extends AuthenticationEvent {
  final String email;
  final String password;
  final String name;

  UserAuthenticationEvent(this.email, this.password, this.name);
}

final class UserLogOut extends AuthenticationEvent {}

final class FetchUserData extends AuthenticationEvent {}
