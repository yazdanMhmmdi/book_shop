part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {
  String username, password;
  AccountLoading({required this.username, required this.password});
  @override
  List<Object> get props => [this.username, password];
}

class AccountSuccess extends AccountState {
  String username, password;
  AccountSuccess({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class AccountFailure extends AccountState {
  String username, password;
  AccountFailure({required this.username, required this.password});

  @override
  List<Object> get props => [this.username, this.password];
}

class AccountEditSuccess extends AccountState {
  String username, password;
  AccountEditSuccess({required this.username, required this.password});

  @override
  List<Object> get props => [this.username, this.password];
}

class AccountEditLoading extends AccountState {
  String username, password;
  AccountEditLoading({required this.username, required this.password});

  @override
  List<Object> get props => [this.username, this.password];
}

class AccountEditFailure extends AccountState {
  String username, password;
  AccountEditFailure({required this.username, required this.password});

  @override
  List<Object> get props => [this.username, this.password];
}

class AccountEditInitial extends AccountState {
  String username, password;
  AccountEditInitial({required this.username, required this.password});

  @override
  List<Object> get props => [this.username, this.password];
}
