
import 'package:book_shop/data/model/home_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  HomeModel postModel;
  HomeSuccess(this.postModel);
}
class HomeFailure extends HomeState {}
