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
  ChatRepository _chatRepository = new ChatRepository();
  AccountRepository _accountRepository = new AccountRepository();
  String user_id;
  ChatModel _model;
  int page = 1;
  int totalPage;
  String bookId;

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
        if (page == 1) {
          _model = await _chatRepository.getChatMessages(
              user_id, event.book_id, page.toString());
          if (_model.chats.length == 0) {
            yield ChatEmpty();
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;

            yield ChatSuccess(chatModel: _model);
          }
        } else if (page <= totalPage) {
          ChatModel _tempModel = await _chatRepository.getChatMessages(
              user_id, event.book_id, page.toString().trim());
          _tempModel.chats.forEach((element) {
            _model.chats.add(element);
          });
          page++;

          yield ChatSuccess(chatModel: _model);
        }
      } catch (err) {
        yield ChatFailure();
      }
    } else if (event is DisposeChatMessages) {
      page = 1;
      totalPage = 0;
      _model = ChatModel();
    } else if (event is SocketMessage) {
      yield ChatLoading();
      print(event.message);

      try {
        var a = json.decode(event.message);

        a["chats"].forEach((v) {
          print(v['message']);
          _model.chats.add(new Chats.fromJson(v));
          print(_model.chats[_model.chats.length - 1].message);
        });

        if (_model.chats[_model.chats.length - 1].bookId == event.bookId &&
            _model.chats[_model.chats.length - 1].fromId == user_id) {
          yield ChatSuccess(chatModel: _model);
        } else {}
      } catch (err) {
        print(err);
      }
    }
  }
}
