part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  ChatModel chatModel;
  ChatSuccess({@required this.chatModel});
  @override
  List<Object> get props => [this.chatModel];
}

class ChatFailure extends ChatState {}

class ChatEmpty extends ChatState {}
