part of 'chatlist_bloc.dart';

abstract class ChatlistState extends Equatable {
  const ChatlistState();

  @override
  List<Object> get props => [];
}

class ChatlistInitial extends ChatlistState {}

class ChatlistLoading extends ChatlistState {}

class ChatlistSuccess extends ChatlistState {
  ChatListModel chatListModel;
  String userId;
  ChatlistSuccess({required this.chatListModel, required this.userId});
  @override
  List<Object> get props => [this.chatListModel, this.userId];
}

class ChatlistFailure extends ChatlistState {}

class ChatlistEmpty extends ChatlistState {}
