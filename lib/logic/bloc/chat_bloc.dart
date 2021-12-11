import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/chat_model.dart';
import 'package:book_shop/data/model/socket_model.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/data/repository/chat_repository.dart';
import 'package:book_shop/networking/api_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());
  late ChatRepository _chatRepository = new ChatRepository();
  late AccountRepository _accountRepository = new AccountRepository();
  late String user_id;
  late ChatModel _model;
  late int totalPage;
  late String bookId;
  late String fromId = "1";
  late String conversationId = "0";

  var channel =
      IOWebSocketChannel.connect(Uri.parse("${ApiProvider.WEB_SOCKET}"));
  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is GetChatMessages) {
      Stream _stream = channel.stream.asBroadcastStream();
      bookId = event.book_id;
      _stream.listen((event) {
        add(SocketMessage(message: event, bookId: bookId));
      });

      yield ChatLoading();
      user_id = await _accountRepository.getSharedPrefs();
      try {
        _model =
            await _chatRepository.getChatMessages(user_id, event.book_id, "1");
        if (_model.chats.length == 0) {
          yield ChatEmpty();
        } else {
          totalPage = int.parse(_model.data.totalPages.toString());
          fromId = _model
              .chats[0].fromId; //get user id cause he send his id on user id
          conversationId = _model.chats[0].conversationId;

          yield ChatSuccess(chatModel: _model, scrollDown: false);
        }
      } catch (err) {
        yield ChatFailure();
      }
    } else if (event is DisposeChatMessages) {
      totalPage = 0;
      _model = new ChatModel(
          chats: [],
          data: Data(
              currentPage: "0",
              offsetPage: 0,
              oprationType: "0",
              totalPages: 0));
    } else if (event is SocketMessage) {
      yield ChatLoading();
      print(event.message);

      try {
        var a = json.decode(event.message);
        a["chats"].forEach((v) {
          print(v['message']);
          if (v['book_id'] == event.bookId && v['from_id'] == user_id) {
            _model.chats.add(new Chats.fromJson(v));
            print(_model.chats[_model.chats.length - 1].message);
          }
        });
        if (_model.chats[_model.chats.length - 1].bookId == event.bookId &&
            _model.chats[_model.chats.length - 1].fromId == user_id) {
          yield ChatSuccess(chatModel: _model, scrollDown: true);
        } else {
          yield ChatSuccess(chatModel: _model, scrollDown: false);
        }
      } catch (err) {
        print(err);
      }
    } else if (event is SendSocketMessage) {
      yield ChatLoading();
      channel.sink.add(
          '{"chats":[{"id":"17","0":"17","message":"${event.message}","1":"${event.message}","from_id":"${fromId}","2":"2","user_id":"${user_id}","3":"1","book_id":"${bookId}","4":"108","conversation_id":"${conversationId}","5":"3","date":null,"6":null,"is_read":"1","7":"1","time":null,"8":null,"type":"chat"}],"data":{"opration_type":"chat","total_pages":1,"current_page":"1","offset_page":0}}');
      _model.chats.add(new Chats(
          message: event.message,
          fromId: fromId,
          userId: user_id,
          bookId: bookId,
          conversationId: conversationId,
          id: '1',
          isRead: '0'));
      yield ChatSuccess(chatModel: _model, scrollDown: true);
    }
  }

  @override
  Future<void> close() {
    channel.sink.close();
    return super.close();
  }
}
