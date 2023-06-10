// ignore_for_file: must_be_immutable

part of 'basket_bloc.dart';

abstract class BasketState extends Equatable {
  const BasketState();

  @override
  List<Object> get props => [];
}

class BasketInitial extends BasketState {}

class BasketLoading extends BasketState {}

class BasketSuccess extends BasketState {
  List<BookModel>? basketModel;
  BasketDataModel? basketDataModel;
  bool noMoreData;
  BasketSuccess(
      {this.basketModel, this.basketDataModel, this.noMoreData = true});
  @override
  List<Object> get props => [this.basketModel!, basketDataModel!];
}

class BasketEmpty extends BasketState {}

class BasketFailure extends BasketState {}

class BasketDuplicatedFailure extends BasketState {}

class BasketGuestUserFailure extends BasketState {}

class BasketParametersFailure extends BasketState {}
