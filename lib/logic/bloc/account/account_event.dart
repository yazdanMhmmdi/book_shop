// ignore_for_file: must_be_immutable

part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetDefaultEvent extends AccountEvent {}

class EditEvent extends AccountEvent {
  String newUsername, newPassword;
  EditEvent({required this.newUsername, required this.newPassword});
  @override
  List<Object> get props => [newUsername, newPassword];
}
