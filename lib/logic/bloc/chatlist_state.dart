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
  ChatlistSuccess({@required this.chatListModel});
  @override
  List<Object> get props => [this.chatListModel];
}

class ChatlistFailure extends ChatlistState {}

class ChatlistEmpty extends ChatlistState {}
