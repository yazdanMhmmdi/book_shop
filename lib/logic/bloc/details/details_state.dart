part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  DetailsModel detailsModel;
  DetailsSuccess(this.detailsModel);
  @override
  // TODO: implement props
  List<Object> get props => [detailsModel];
}

class DetailsFailure extends DetailsState {}
