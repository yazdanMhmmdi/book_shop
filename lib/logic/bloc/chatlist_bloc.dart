import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/chat_list_model.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/data/repository/chat_list_repository.dart';
import 'package:book_shop/presentation/widgets/global_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'chatlist_event.dart';
part 'chatlist_state.dart';

class ChatlistBloc extends Bloc<ChatlistEvent, ChatlistState> {
  ChatlistBloc() : super(ChatlistInitial());
  late ChatListRepository _repository = new ChatListRepository();
  late AccountRepository _accountRepository = new AccountRepository();

  late ChatListModel _model;
  late int page = 1;
  late int totalPage;
  @override
  Stream<ChatlistState> mapEventToState(
    ChatlistEvent event,
  ) async* {
    if (event is GetChatList) {
      yield ChatlistLoading();
      try {
        if (page == 1) {
          _model = await _repository.getChatList(
              GlobalWidget.userId, page.toString());
          if (_model.chatsList.length == 0) {
            yield ChatlistEmpty();
          } else {
            totalPage = int.parse(_model.data.totalPages.toString());
            page++;
            yield ChatlistSuccess(
                chatListModel: _model, userId: GlobalWidget.userId);
          }
        } else if (page <= totalPage) {
          ChatListModel _tempModel = await _repository.getChatList(
              GlobalWidget.userId, page.toString());
          _tempModel.chatsList.forEach((element) {
            _model.chatsList.add(element);
          });
          page++;
          yield ChatlistSuccess(
              chatListModel: _model, userId: GlobalWidget.userId);
        }
      } catch (err) {
        yield ChatlistFailure();
      }
    }
  }
}
