part of 'basket_bloc.dart';

abstract class BasketState extends Equatable {
  const BasketState();

  @override
  List<Object> get props => [];
}

class BasketInitial extends BasketState {}

class BasketLoading extends BasketState {}

class BasketSuccess extends BasketState {
  BasketModel? basketModel;
  BasketSuccess({this.basketModel});
  @override
  List<Object> get props => [this.basketModel!];
}

class BasketEmpty extends BasketState {}

class BasketFailure extends BasketState {}