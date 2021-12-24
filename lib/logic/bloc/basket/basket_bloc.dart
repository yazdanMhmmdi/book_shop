import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/data.dart';
import 'package:book_shop/presentation/widgets/widgets.dart';
import 'package:equatable/equatable.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc() : super(BasketInitial()) {
    on<GetBasket>(_getBasket);
    on<DeleteBasket>(_delete);
    on<AddBasket>(_add);
  }
  final BasketRepository _basketRepository = BasketRepository();
  late BasketModel _model;

  Future<void> _getBasket(GetBasket event, Emitter<BasketState> emit) async {
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
  }

  Future<void> _delete(DeleteBasket event, Emitter<BasketState> emit) async {
    FunctionalModel _tempModel = await _basketRepository.deleteBasket(
        GlobalWidget.userId, event.book_id);
    if (_tempModel.status == "1") {
      add(GetBasket());
    } else {
      emit(BasketFailure());
    }
  }

  Future<void> _add(AddBasket event, Emitter<BasketState> emit) async {
    emit(BasketLoading());

    await Future.delayed(const Duration(seconds: 2));

    FunctionalModel _tempModel =
        await _basketRepository.addBasket(GlobalWidget.userId, event.book_id);
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
}


/*


*/
