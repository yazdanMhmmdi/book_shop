// ignore_for_file: must_be_immutable

part of 'title_bloc.dart';

abstract class TitleState extends Equatable {
  const TitleState();

  @override
  List<Object> get props => [];
}

class TitleInitial extends TitleState {}

class TitleLoading extends TitleState {}

class TitleSuccess extends TitleState {
  List<BookModel> model;
  bool noMoreData = false;
  TitleSuccess({required this.model, required this.noMoreData});
  @override
  List<Object> get props => [model];
}

class TitleFailure extends TitleState {}

class TitleNothingFound extends TitleState {}
