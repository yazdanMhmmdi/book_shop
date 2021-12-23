part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  AuthModel _authModel;
  AuthSuccess(this._authModel);

  @override
  List<Object> get props => [_authModel];
}
class AuthWrong extends AuthState {
  
}

class AuthFailure extends AuthState {}
