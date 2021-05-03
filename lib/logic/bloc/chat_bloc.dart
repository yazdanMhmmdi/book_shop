import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/chat_model.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/data/repository/chat_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

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
  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is GetChatMessages) {
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
            yield ChatSuccess(chatMessagesModel: _model);
          }
        } else if (page <= totalPage) {
          ChatModel _tempModel = await _chatRepository.getChatMessages(
              user_id, event.book_id, page.toString());
          _tempModel.chats.forEach((element) {
            _model.chats.add(element);
          });
          page++;
          yield ChatSuccess(chatMessagesModel: _model);
        }
      } catch (err) {
        yield ChatFailure();
      }
    } else if (event is DisposeChatMessages) {
      page = 1;
      totalPage = 0;
      _model = ChatModel();
    }
  }
}
