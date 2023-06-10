// ignore_for_file: must_be_immutable

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  String username, password;
  LoginEvent(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

class SignUpEvent extends AuthEvent {
  String username, password;
  SignUpEvent({required this.username,required this.password});
  
  @override
  List<Object> get props => [username, password];
}
