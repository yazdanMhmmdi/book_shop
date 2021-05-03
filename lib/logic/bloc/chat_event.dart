part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class InitializeChatConfig extends ChatEvent {}

class GetChatMessages extends ChatEvent {
  String book_id;
  GetChatMessages({@required this.book_id});
  @override
  // TODO: implement props
  List<Object> get props => [this.book_id];
}


class DisposeChatMessages extends ChatEvent {
}
