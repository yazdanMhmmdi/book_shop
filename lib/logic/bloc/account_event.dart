part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetDefaultEvent extends AccountEvent {
  GetDefaultEvent();
  @override
  List<Object> get props => [];
}

class EditEvent extends AccountEvent {
  String newUsername, newPassword;
  EditEvent({this.newUsername, this.newPassword});
  @override
  List<Object> get props => [newUsername, newPassword];
}
