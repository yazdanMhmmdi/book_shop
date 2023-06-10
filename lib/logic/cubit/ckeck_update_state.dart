// ignore_for_file: must_be_immutable

part of 'ckeck_update_cubit.dart';

abstract class CheckUpdateState extends Equatable {
  const CheckUpdateState();

  @override
  List<Object> get props => [];
}

class CheckUpdateLoading extends CheckUpdateState {}

class CheckUpdateFailure extends CheckUpdateState {}

class CheckUpdateSuccessNoUpdate extends CheckUpdateState {
  String route;
  CheckUpdateSuccessNoUpdate({required this.route});
  @override
  List<Object> get props => [this.route];
}

class CheckUpdateSuccessUpdateAvailable extends CheckUpdateState {
  UpdateAppModel updateAppModel;
  String route;

  CheckUpdateSuccessUpdateAvailable(
      {required this.updateAppModel, required this.route});

  @override
  List<Object> get props => [this.updateAppModel, this.route];
}
