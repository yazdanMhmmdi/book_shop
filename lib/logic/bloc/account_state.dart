part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  AccountModel accountModel;
  AccountSuccess(this.accountModel);

  @override
  List<Object> get props => [accountModel];
}

class AccountFailure extends AccountState {}
