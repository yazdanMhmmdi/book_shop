import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/error/failure.dart';
import '../../../core/params/basket_params.dart';
import '../../../data/data.dart';
import '../../../data/model/basket_data_model.dart';
import '../../../data/model/book_model.dart';
import '../../../data/model/function_response_model.dart';
import '../../../domain/usecases/add_basket_usecase.dart';
import '../../../domain/usecases/delete_basket_usecase.dart';
import '../../../domain/usecases/get_basket_usecase.dart';
import '../../../presentation/widgets/widgets.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  BasketBloc({
    required this.getBasketUsecase,
    required this.addBasketUsecase,
    required this.deleteBasketUsecase,
  }) : super(BasketInitial()) {
    on<GetBasket>(_getBasket);
    on<DeleteBasket>(_delete);
    on<AddBasket>(_addItemToBasket);
  }
  GetBasketUsecase getBasketUsecase;
  AddBasketUsecase addBasketUsecase;
  DeleteBasketUsecase deleteBasketUsecase;
  int page = 1;
  int totalPage = 1;
  int currentCategory = 1;
  List<BookModel>? _bookModel = [];
  BasketDataModel? _basketDataModel;
  bool noMoreData = true;

  Future<void> _getBasket(GetBasket event, Emitter<BasketState> emit) async {
    emit(BasketLoading());
    try {
      if (page != 1) noMoreData = page < totalPage;

      BasketRequestParams params = BasketRequestParams();
      if (page <= totalPage) {
        params.userId = GlobalWidget.userId;
        params.page = page.toString();

        dynamic failureOrSuccess = await getBasketUsecase(params);
        page++;

        failureOrSuccess!.fold((Failure) {
          emit(BasketFailure());
        }, (BasketModel success) {
          if (success.basket.isEmpty) {
            emit(BasketEmpty());
          } else if (success.basket.isNotEmpty) {
            page++;
            totalPage = success.basketData.totalPages!;

            _bookModel!.addAll(success.basket);
            _basketDataModel = success.basketData;

            if (page > totalPage) noMoreData = false;

            emit(BasketSuccess(
                basketModel: _bookModel!,
                basketDataModel: _basketDataModel,
                noMoreData: noMoreData));
          }
        });
      }
    } catch (err) {
      print('basket error :: ${err.toString()}');
      emit(BasketFailure());
    }
  }

  Future<void> _delete(DeleteBasket event, Emitter<BasketState> emit) async {
    BasketRequestParams params = BasketRequestParams();
    params.bookId = event.book_id;
    params.userId = GlobalWidget.userId;

    Either<Failure, FunctionResponseModel> failureOrSuccess =
        await deleteBasketUsecase(params);

    failureOrSuccess.fold((failure) {
      emit(BasketFailure());
    }, (success) {
      emit(BasketLoading());
      if (success.status) {

        _bookModel!.removeWhere((e) => e.id == event.book_id);

        // when list is empty fetch data again
        if (_bookModel!.isEmpty) {
          add(GetBasket());
          page = 1;
        }

        emit(BasketSuccess(
            basketDataModel: _basketDataModel,
            noMoreData: noMoreData,
            basketModel: _bookModel));
      } else {
        emit(BasketFailure());
      }
    });
  }

  Future<void> _addItemToBasket(
      AddBasket event, Emitter<BasketState> emit) async {
    emit(BasketLoading());

    await Future.delayed(const Duration(seconds: 2));
    BasketRequestParams params = BasketRequestParams();

    params.bookId = event.book_id;
    params.userId = GlobalWidget.userId;

    Either<Failure, FunctionResponseModel> failureOrSuccess =
        await addBasketUsecase(params);

    // await .addBasket(GlobalWidget.userId, event.book_id);
    failureOrSuccess.fold((failure) async {
      if (failure is DuplicatedBookFailure) {
        emit(BasketDuplicatedFailure());
      } else if (failure is GuestUserFailure) {
        emit(BasketGuestUserFailure());
      } else {
        emit(BasketFailure());
      }
    }, (success) async {
      emit(BasketSuccess());
    });
    await Future.delayed(const Duration(seconds: 2));
    emit(BasketInitial());
  }
}

/*


*/
