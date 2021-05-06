import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/basket_model.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/data/repository/basket_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketInitial());
  BasketRepository _basketRepository = new BasketRepository();
  AccountRepository _accountRepository = new AccountRepository();
  BasketModel _model;
  @override
  Stream<BasketState> mapEventToState(
    BasketEvent event,
  ) async* {
    if (event is GetBasket) {
      yield BasketLoading();
      try {
        String user_id = await _accountRepository.getSharedPrefs();
        _model = await _basketRepository.getBasket(user_id, "1");
        if (_model.basket.length == 0) {
          yield BasketEmpty();
        } else if (_model.basket.length > 0) {
          yield BasketSuccess(basketModel: _model);
        }
      } catch (err) {
        print('basket error :: ${err.toString()}');
        yield BasketFailure();
      }
    }
  }
}
