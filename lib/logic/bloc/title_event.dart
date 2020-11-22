part of 'title_bloc.dart';

abstract class TitleEvent extends Equatable {
  const TitleEvent();

  @override
  List<Object> get props => [];
}

class FetchBooks extends TitleEvent {
  int title;
  FetchBooks(this.title);

  @override
  List<Object> get props => [title];
}
