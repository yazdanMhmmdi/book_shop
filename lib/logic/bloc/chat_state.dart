part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  ChatMessagesModel chatMessagesModel;
  ChatSuccess({@required this.chatMessagesModel});
  @override
  List<Object> get props => [this.chatMessagesModel];
}

class ChatFailure extends ChatState {}

class ChatEmpty extends ChatState {}
