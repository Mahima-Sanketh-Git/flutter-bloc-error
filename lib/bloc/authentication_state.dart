part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthSuccessState extends AuthenticationState {}

final class AuthLodingState extends AuthenticationState {
  final bool isloadin;

  AuthLodingState({required this.isloadin});
  List<Object> get props => [isloadin];
}

final class AuthFaliureState extends AuthenticationState {
  final String error;

  AuthFaliureState({required this.error});
  List<Object> get props => [error];
}

// ignore: must_be_immutable
final class UserDataState extends AuthenticationState {
  UserModel userModel;

  UserDataState({required this.userModel});
  List<Object> get props => [userModel];
}
