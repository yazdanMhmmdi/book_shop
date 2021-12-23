part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

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
