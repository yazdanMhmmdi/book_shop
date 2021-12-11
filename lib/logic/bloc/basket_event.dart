part of 'basket_bloc.dart';

abstract class BasketEvent extends Equatable {
  const BasketEvent();

  @override
  List<Object> get props => [];
}

class GetBasket extends BasketEvent {}

class DeleteBasket extends BasketEvent {
  String book_id;
  DeleteBasket({required this.book_id});

  @override
  // TODO: implement props
  List<Object> get props => [this.book_id];
}

class AddBasket extends BasketEvent {
  String book_id;
  AddBasket({required this.book_id});

  @override
  // TODO: implement props
  List<Object> get props => [this.book_id];
}
