import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/basket_model.dart';
import 'package:book_shop/data/model/functional_model.dart';
import 'package:book_shop/data/repository/account_repository.dart';
import 'package:book_shop/data/repository/basket_repository.dart';
import 'package:book_shop/presentation/widgets/global_widget.dart';
import 'package:equatable/equatable.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketInitial()) {
    BasketRepository _basketRepository = BasketRepository();
    AccountRepository _accountRepository = AccountRepository();
    late BasketModel _model;
    on<BasketEvent>((event, emit) async {
      if (event is GetBasket) {
        emit(BasketLoading());
        try {
          _model = await _basketRepository.getBasket(GlobalWidget.userId, "1");
          if (_model.basket.isEmpty) {
            emit(BasketEmpty());
          } else if (_model.basket.isNotEmpty) {
            emit(BasketSuccess(basketModel: _model));
          }
        } catch (err) {
          print('basket error :: ${err.toString()}');
          emit(BasketFailure());
        }
      } else if (event is DeleteBasket) {
        FunctionalModel _tempModel = await _basketRepository.deleteBasket(
            GlobalWidget.userId, event.book_id);
        if (_tempModel.status == "1") {
          add(GetBasket());
        } else {
          emit(BasketFailure());
        }
      } else if (event is AddBasket) {
        emit(BasketLoading());

        await Future.delayed(const Duration(seconds: 2));

        FunctionalModel _tempModel = await _basketRepository.addBasket(
            GlobalWidget.userId, event.book_id);
        if (_tempModel.status == "1") {
          emit(BasketSuccess());

          await Future.delayed(const Duration(seconds: 2));
          emit(BasketInitial());
        } else {
          emit(BasketFailure());

          await Future.delayed(const Duration(seconds: 2));
          emit(BasketInitial());
        }
      }
    });
  }
}
