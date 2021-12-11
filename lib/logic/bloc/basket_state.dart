part of 'basket_bloc.dart';

abstract class BasketState extends Equatable {
  const BasketState();

  @override
  List<Object> get props => [];
}

class BasketInitial extends BasketState {}

class BasketLoading extends BasketState {}

class BasketSuccess extends BasketState {
  BasketModel basketModel;
  BasketSuccess({required this.basketModel});
  @override
  // TODO: implement props
  List<Object> get props => [this.basketModel];
}

class BasketFailure extends BasketState {}

class BasketEmpty extends BasketState {}
